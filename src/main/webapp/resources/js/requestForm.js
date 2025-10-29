//초기화
document.addEventListener('DOMContentLoaded', function() {
	// radio 버튼 : form 입력 방식으로 초기화
	showInputForm('form'); 
	
	// 업로드 엑셀파일 업로드 시 이벤트 처리
	document.getElementById('excelFile').addEventListener('change', showExcelContent, false);
});

//카테고리 Map
const categoryMap = new Map();
const categoryArr = ["카테고리","노트북","모니터","태블릿","스마트폰","복합기","데스크탑","TV","프로젝터","기타"];
categoryArr.forEach((item, index) => {
	categoryMap.set(item, index);
})

// 사유 영역의 글자수를 세고 표시를 업데이트하는 함수
function updateCharCount(textarea, maxLength) {
    const currentLength = textarea.value.length;
    const displayElement = document.getElementById('currentLength');
    
    if (displayElement) {
        // 현재 글자수를 업데이트
        displayElement.textContent = currentLength;
        
        // (선택 사항) 최대 길이에 도달했을 때 색상 변경
        if (currentLength >= maxLength) {
            displayElement.style.color = '#dc3545'; // 경고색 (빨간색)
        } else {
            displayElement.style.color = '#6c757d'; // 기본색 (회색)
        }
    }
}

//폼 전환 함수
function showInputForm(method) {
    const formArea = document.getElementById('formInputArea');
    const excelArea = document.getElementById('excelUploadArea');
    const formInputs = formArea.querySelectorAll('[required]');
    const excelInput = document.getElementById('excelFile');
    const excelContents = document.getElementById('data-display-area');

    if (method === 'form') {
        // 폼 직접 입력 선택 시: 폼 영역 표시, 엑셀 영역 숨김
        formArea.style.display = 'block';
        excelArea.style.display = 'none';
        
        // 폼 직접 입력 필드 required 설정 (필수 입력으로)
        formInputs.forEach(input => input.setAttribute('required', 'required'));
        
        // 엑셀 파일 필드 required 해제
        if (excelInput) excelInput.removeAttribute('required');
        
        // 엑셀 입력 폼 무효화
        const excel_inputs = excelContents.querySelectorAll('.form-row input, .form-row select , .form-group textarea');
        if (excel_inputs.length) { // 요소가 존재할 때만
        	excel_inputs.forEach(el => el.disabled = true);
        }
        // 직접 입력폼 유효화
        const form_inputs = formArea.querySelectorAll('.form-row input, .form-row select, .form-group textarea');
        if (form_inputs.length) { // 요소가 존재할 때만
        	form_inputs.forEach(el => el.disabled = false);
        }

    } else if (method === 'excel') {
    	// 엑셀 파일 업로드 선택 시: 폼 영역 숨김, 엑셀 영역 표시
        formArea.style.display = 'none';
        excelArea.style.display = 'block';

        // 폼 직접 입력 필드 required 해제
        formInputs.forEach(input => input.removeAttribute('required'));
        // 엑셀 파일 필드 required 설정 (필수 입력으로)
        if (excelInput) excelInput.setAttribute('required', 'required');
        
        //직접 입력 폼 무효화
        const form_inputs = formArea.querySelectorAll('.form-row input, .form-row select, .form-group textarea');
        if(form_inputs.length){
        	form_inputs.forEach(el =>  el.disabled = true);
        }
        // 엑셀 입력 폼 유효화
        const excel_inputs = excelContents.querySelectorAll('.form-row input, .form-row select, .form-group textarea');
        if(excel_inputs.length){
        	excel_inputs.forEach(el => el.disabled = false)
        }
    }
}

// 제품 추가/제거 관련

function removeProduct(btn){
	btn.closest(".form-row").remove();
	setRowIndex();
}

function checkProductCnt(){
	const rows =  document.querySelectorAll(".form-row");
	const cnt = rows.length;
	if (cnt <10){
		return true;
	}else{
		return false
	}
}

// 엑셀파일 미리보기 함수
function showExcelContent(event) {
    const file = event.target.files[0];
    const displayArea = document.getElementById('data-display-area');
    
    displayArea.innerHTML = "";

    if (!file) {
        displayArea.innerHTML = '파일을 선택해 주세요.';
        return;
    }

    // 표시 영역 초기화
    displayArea.innerHTML = '파일을 읽는 중...';

    const reader = new FileReader();
    
    reader.onload = function(e) {
        const data = new Uint8Array(e.target.result);
        
        try {
            const data = new Uint8Array(e.target.result);
            const workbook = XLSX.read(data, { type: 'array' });
            
            // 첫 번째 시트 이름을 가져옵니다.
            const sheetName = workbook.SheetNames[0];
            const worksheet = workbook.Sheets[sheetName];

            const data_json = XLSX.utils.sheet_to_json(worksheet, {
                header: ["카테고리", "제품명", "단가", "수량"], // A열부터 D열까지의 헤더
                range: 'A2:D11', // 읽어올 셀 범위 지정
                raw: false // 포맷된 값(예: 통화 형식)을 문자열로 가져옴
            });
            
            const reason_cell = worksheet['A13'];
            let purchase_reason = (reason_cell && reason_cell.v) ? reason_cell.v.toString() : '내용 없음';
            
            console.log("Excel json :" + JSON.stringify(data_json));
            console.log("Excel purchase_reason :" + purchase_reason);
            // 데이터 표시 함수 호출
            renderFormFromExcel(data_json, purchase_reason);

        } catch(error) {
            console.error("파일 처리 오류:", error);
        }
    };

    reader.readAsArrayBuffer(file);
}

function setRowIndex() {
    const container = document.querySelector("#formInputArea");
    
    if (!container) {
        console.error("Error: #formInputArea container not found.");
        return; 
    }
    container.querySelectorAll('.form-row').forEach((row, idx) => {
        // 1. categoryId 검증 및 처리
        const categoryInput = row.querySelector('[name*="categoryId"]');
        if (categoryInput) {
            categoryInput.name = `products[${idx}].categoryId`;
        }

        // 2. itemName 검증 및 처리
        const itemNameInput = row.querySelector('[name*="itemName"]');
        if (itemNameInput) {
            itemNameInput.name = `products[${idx}].itemName`;
        }

        // 3. price 검증 및 처리
        const priceInput = row.querySelector('[name*="price"]');
        if (priceInput) {
            priceInput.name = `products[${idx}].price`;
        }

        // 4. count 검증 및 처리
        const countInput = row.querySelector('[name*="count"]');
        if (countInput) {
            countInput.name = `products[${idx}].count`;
        }

        // 5. totalPrice 검증 및 처리
        const totalPriceInput = row.querySelector('[name*="totalPrice"]');
        if (totalPriceInput) {
            totalPriceInput.name = `products[${idx}].totalPrice`;
        }
    });
}


function setTitle(e){
    e.preventDefault(); // 폼 제출 막기
    const radio = document.querySelector('.radio-input-group input:checked');
    let content; 
    let container;
    if (radio && radio.id=='inputMethodForm'){ // 직접 입력 상태
    	container = document.querySelector("#formInputArea");
    	const select2 = container.querySelector('#select2-product-select-container');
        if (select2){
        	content = select2.textContent;
        }
    }else{ // 엑셀 업로드 상태
    	container = document.querySelector("#data-display-area");
    	const input = container.querySelector('.form-row .product-select-group input');
        if (input){
        	content = input.value;
        }
    }

	let length = 0;
	container.querySelectorAll('.form-row').forEach((row)=> {
		let quantity = parseInt(row.querySelector('input[name*="count"]').value);
		if (quantity > 1){
			length  += quantity;
		}else{
			length += 1;
		}
	});
	if (length > 1){
		content += " 등 " + length + "개"
	}
	document.getElementById('requestTitle').value = content;
	e.target.submit();
}

