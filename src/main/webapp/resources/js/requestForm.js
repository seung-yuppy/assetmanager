//초기화
document.addEventListener('DOMContentLoaded', function() {
	// radio 버튼 : form 입력 방식으로 초기화
	showInputForm('form'); 
	
	// 업로드 엑셀파일 업로드 시 이벤트 처리
	document.getElementById('excelFile').addEventListener('change', showExcelContent, false);
});


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

// 제품 추가/제거 관련

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
            // 1. 워크북 파싱
            const workbook = XLSX.read(data, { type: 'array' });
            
            // 2. 첫 번째 시트 이름 가져오기
            const firstSheetName = workbook.SheetNames[0];
            
            // 3. 해당 시트 선택
            const worksheet = workbook.Sheets[firstSheetName];

            const json = XLSX.utils.sheet_to_json(worksheet);
            renderFormFromExcel(json);

        } catch (error) {
            console.error("Excel 파일 파싱 오류:", error);
            displayArea.innerHTML = '파일을 읽는 도중 오류가 발생했습니다. 파일 형식을 확인해 주세요.';
        }
    };

    reader.readAsArrayBuffer(file);
}

