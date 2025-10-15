//초기화
document.addEventListener('DOMContentLoaded', function() {
	const priceInput = document.getElementById('price');
	const quantityInput = document.getElementById('quantity');
	
	// 'input' 이벤트: 사용자가 값을 입력할 때마다 즉시 실행
	priceInput.addEventListener('input', calculateTotalPrice);
	quantityInput.addEventListener('input', calculateTotalPrice);
	
	// radio 버튼 : form 입력 방식으로 초기화
	showInputForm('form'); 
	// 페이지 로드 시 초기 계산 한 번 실행
	calculateTotalPrice();
	
	// 업로드 엑셀파일 업로드 시 이벤트 처리
	document.getElementById('excelFile').addEventListener('change', handleFileSelect, false);
});

// 1. 카테고리 선택 시 제품 목록 업데이트
function updateProductOptions() {
    const categorySelect = document.getElementById('category');
    const productNameGroup = document.getElementById('productGroup');
    const productNameSelect = document.getElementById('productName');
    const selectedCategory = categorySelect.value;
    
    // 이전 입력 필드 및 가격 초기화
    document.getElementById('price').value = 0;

}

//단가와 수량을 계산하여 총액 필드에 값을 업데이트하는 함수
function calculateTotalPrice() {
    // 1. 필요한 HTML 요소 가져오기
    const priceInput = document.getElementById('price');
    const quantityInput = document.getElementById('quantity');
    const totalInput = document.getElementById('totalPrice');

    // 2. 입력 값 추출 및 유효성 검사
    // Number()를 사용하여 문자열 값을 숫자로 변환합니다.
    const price = Number(priceInput.value.replace(/,/g, '')); // 쉼표 제거 후 숫자로 변환
    const quantity = Number(quantityInput.value);

    // 값이 유효한 숫자인지, 수량이 0보다 큰지 확인
    if (isNaN(price) || isNaN(quantity) || quantity < 1 || price < 0) {
        totalInput.value = 0;
        return;
    }

    // 3. 총액 계산 (단가 * 수량)
    const totalPrice = price * quantity;

    // 4. 총액 필드에 계산 결과 적용
    // 천 단위 구분 기호를 추가하여 가독성을 높입니다.
    totalInput.value = totalPrice.toLocaleString('ko-KR'); // 총액 필드가 text 타입이 아닐 경우 (Number)
    totalInput.value = totalPrice; // 총액 필드가 number 타입이므로 단순 값만 할당
}

/**
 구매 사유 영역의 글자수를 세고 표시를 업데이트하는 함수
 */
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

    if (method === 'form') {
        // 폼 직접 입력 선택 시: 폼 영역 표시, 엑셀 영역 숨김
        formArea.style.display = 'block';
        excelArea.style.display = 'none';
        
        // 폼 직접 입력 필드 required 설정 (필수 입력으로)
        formInputs.forEach(input => input.setAttribute('required', 'required'));
        // 엑셀 파일 필드 required 해제
        if (excelInput) excelInput.removeAttribute('required');

    } else if (method === 'excel') {
        // 엑셀 파일 업로드 선택 시: 폼 영역 숨김, 엑셀 영역 표시
        formArea.style.display = 'none';
        excelArea.style.display = 'block';

        // 폼 직접 입력 필드 required 해제
        formInputs.forEach(input => input.removeAttribute('required'));
        // 엑셀 파일 필드 required 설정 (필수 입력으로)
        if (excelInput) excelInput.setAttribute('required', 'required');
    }
}

// 엑셀 템플릿 다운로드 기능 구현
function downloadExcelTemplate() {
    // 1. 실제 템플릿 파일이 위치한 경로를 지정합니다.
    const templatePath = '/assetmanager/resources/template/요청양식.xlsx'; 
    // 2. 다운로드를 실행합니다. (가장 일반적인 방법: <a> 태그를 이용)
    const link = document.createElement('a');
    link.href = templatePath;
    link.download = '요청양식.xlsx'; // 다운로드될 파일명
    document.body.appendChild(link);
    link.click(); // 클릭 이벤트 발생
    document.body.removeChild(link); // 생성된 <a> 태그 제거
}

let productRowIndex  = 0;

// 요청할 제품 추가하는 함수 
function addProduct(){
	if (!checkProductCnt()){
		alert("요청 품목은 10개까지만 가능합니다.");
		return;
	}
	const currentIndex = ++productRowIndex;
	const targetEl = document.querySelector('#add-product-section');
	const newFormRowHTML = `
							<div class="form-row">
								<div class="form-group fixed-width-sm">
									<label for="isDepartmentUse-${currentIndex}">부서 자산</label>
									<div>
										<input type="checkbox" id="isDepartmentUse-${currentIndex}" name="isDepartmentUse-${currentIndex}"> 
									</div>
								</div>
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label>
									<select id="category" name="category-${currentIndex}" required onchange="updateProductOptions()">
										<option value="" disabled selected>선택하세요</option>
										<option value="notebook">노트북</option>
										<option value="monitor">모니터</option>
										<option value="software">소프트웨어</option>
										<option value="other">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명<span class="required">*</span></label>
									<input list="productOptions" name="productNameSelect-${currentIndex}" id="productNameSelect" placeholder="선택  또는 직접 입력">
									<datalist id="productOptions">
									    <option value="LG그램">
									    <option value="macbook 10">
									    <option value="직접 입력">
									</datalist>
								</div>
								<div class="form-group fixed-width-sm">
									<label for="price">단가 (원) <span class="required">*</span></label>
									<input type="number" id="price" name="price-${currentIndex}" value="0" min="0" required>
								</div>

								<div class="form-group fixed-width-sm">
									<label for="quantity">수량 <span class="required">*</span></label>
									<input type="number" id="quantity" name="quantity-${currentIndex}" min="1" value="1" required>
								</div>
								<div class="form-group fixed-width-sm">
									<label for="totalPrice">총액 (원)</label>
									<div class="last-input-group">
										<input type="text" id="totalPrice" name="totalPrice-${currentIndex}" value="0" class="price-lock" readonly>
										<img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)"></img>
									</div>
								</div>
							</div>
	`
		targetEl.insertAdjacentHTML('beforebegin', newFormRowHTML);
}

function removeProduct(btn){
	btn.closest(".form-row").remove();
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
function handleFileSelect(event) {
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
            // 1. 워크북 파싱
            const workbook = XLSX.read(data, { type: 'array' });
            
            // 2. 첫 번째 시트 이름 가져오기
            const firstSheetName = workbook.SheetNames[0];
            
            // 3. 해당 시트 선택
            const worksheet = workbook.Sheets[firstSheetName];

            // 4. 시트 데이터를 HTML 테이블 문자열로 변환
            // sheet_to_html을 사용하면 간단하게 테이블 태그를 얻을 수 있습니다.
            const htmlTableString = XLSX.utils.sheet_to_html(worksheet, { id: 'excel-data-table'});
            
            // 5. HTML 영역에 삽입
            displayArea.innerHTML = `
            	<h3>업로드 내용</h3>
            	${htmlTableString}
            `;
            
            // 6. 생성된 테이블에 CSS 클래스 추가 (선택 사항)
            const table = document.getElementById('excel-data-table');
            if(table) {
                 // 여기에 원하는 CSS 클래스를 추가하여 테이블을 스타일링할 수 있습니다.
                 table.classList.add('excel-data-preview'); 
            }

        } catch (error) {
            console.error("Excel 파일 파싱 오류:", error);
            displayArea.innerHTML = '파일을 읽는 도중 오류가 발생했습니다. 파일 형식을 확인해 주세요.';
        }
    };

    reader.readAsArrayBuffer(file);
}

