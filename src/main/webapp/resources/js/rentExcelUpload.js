//초기화
document.addEventListener('DOMContentLoaded', function() {
	console.log("시작했니?????")
	// radio 버튼 : form 입력 방식으로 초기화
	showInputForm('form'); 
	
	// 업로드 엑셀파일 업로드 시 이벤트 처리
	document.getElementById('excelFile').addEventListener('change', showExcelContent, false);
});

// 폼 전환 함수
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
        const excel_inputs = excelContents.querySelectorAll('.form-date input, .form-row select', '.form-row input', '.form-group input', '.form-group textarea', '.last-input-group input');
        if (excel_inputs.length) { // 요소가 존재할 때만
        	excel_inputs.forEach(el => el.disabled = true);
        }
        // 직접 입력폼 유효화
        const form_inputs = formArea.querySelectorAll('.form-date input, .form-row select', '.form-row input', '.form-group input', '.form-group textarea', '.last-input-group input');
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
        const form_inputs = formArea.querySelectorAll('.form-date input, .form-row select', '.form-row input', '.form-group input', '.form-group textarea', '.last-input-group input');
        if(form_inputs.length){
        	form_inputs.forEach(el =>  el.disabled = true);
        }
        // 엑셀 입력 폼 유효화
        const excel_inputs = excelContents.querySelectorAll('.form-date input, .form-row select', '.form-row input', '.form-group input', '.form-group textarea', '.last-input-group input');
        if(excel_inputs.length){
        	excel_inputs.forEach(el => el.disabled = false)
        }
    }
}

// 엑셀 템플릿 다운로드 기능 구현
function downloadExcelTemplate() {
    // 1. 실제 템플릿 파일이 위치한 경로를 지정합니다.
    const templatePath = '/assetmanager/resources/template/반출요청양식.xlsx';  
    
    // 2. 다운로드를 실행합니다. (가장 일반적인 방법: <a> 태그를 이용)
    const link = document.createElement('a');
    link.href = templatePath;
    link.download = '반출요청양식.xlsx'; // 다운로드될 파일명
    document.body.appendChild(link);
    link.click(); // 클릭 이벤트 발생
    document.body.removeChild(link); // 생성된 <a> 태그 제거
}

//엑셀파일 미리보기 함수
function showExcelContent(event) {
	console.log("showExcelContent 실행됨?");
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
                header: ["카테고리", "제품명", "수량"], // A5:D14 헤더
                range: 'A5:D14', // 읽어올 셀 범위 지정
                raw: false // 포맷된 값(예: 통화 형식)을 문자열로 가져옴
            });
            
            const date_cell = worksheet['A2'];
            let return_date = (date_cell && date_cell.v) ? date_cell.v.toString():'내용 없음';
            
            const reason_cell = worksheet['A16'];
            let rent_reason = (reason_cell && reason_cell.v) ? reason_cell.v.toString() : '내용 없음';
                  
            console.log("Excel json :" + JSON.stringify(data_json));
            console.log("Excel rent_reason 반납 사유?? :" + rent_reason);
            console.log("return_date 반납 예정일???"+return_date);
          
            // 데이터 표시 함수 호출
            renderFormFromExcel(data_json, rent_reason, return_date);

        } catch(error) {
            console.error("파일 처리 오류:", error); 
        }
    };

    reader.readAsArrayBuffer(file);
}


// 엑셀 파일 업로드 내용 보여주기 
function renderFormFromExcel(json, rent_reason, return_date) {
	  const container = document.getElementById('data-display-area');
	  container.innerHTML = ""; // 기존 내용 초기화

	  if (json.length === 0) return;
	  
	  const today = new Date();
	  const month = today.getMonth()+1;
	  const date = today.getDate();
	  const year = today.getFullYear();
	  
	  const r_year = return_date.slice(0,4);
	  const r_month = return_date.slice(4,6);
	  const r_day = return_date.slice(6,8);
	  const formatted = `${r_year}-${r_month}-${r_day}`;
	  

	  const returnDate = `
		  	<div class="form-date">
		  	<div class="form-return-date">
			  <label for="application-date">반출 요청일</label> 
			  <input type="date" name="application-date" readonly value="${year}-${month}-${date}"></input>
			</div>
			<div class="form-return-date">
			  <label for="return-date">반납 예정일</label> 
			  <input type="date" readonly value="${formatted}"></input>
			  <input type="hidden" value="${return_date|| ''}" name="returnDate" />
			</div>
			</div>
		  `;
	  container.insertAdjacentHTML('beforeend', returnDate);
	
	  // 모든 row를 처리하는 단일 루프
	  for (let i = 0; i < json.length; i++) {
	    const row = json[i];
	    // 첫 번째 row (i === 0)에만 실제로 표시될 label 텍스트
	    // 나머지 row에서는 CSS로 숨길 예정
	    const categoryLabel = (i === 0) ? '<label>카테고리</label>' : '';
	    const itemNameLabel = (i === 0) ? '<label>제품명</label>' : '';	    
	    const countLabel = (i === 0) ? '<label>수량</label>' : '';

	    const rowHtml = `
	      <div class="form-row">
	        <div class="form-group category-group fixed-width-med">
	          ${categoryLabel}
	          <input type="text" value="${row.카테고리 || ''}" readonly>
	          <input type="text" name="items[${i}].category" value="${(row.카테고리 || '')}" style="display:none">
	        </div>
	        <div class="form-group product-select-group fixed-width-lg">
	          ${itemNameLabel}
	          <input type="text" name="items[${i}].assetName" value="${row.제품명 || ''}" readonly>
	        </div>	        
	        <div class="form-group fixed-width-sm">
	          ${countLabel}
	          <input type="number" name="items[${i}].count" value="${row.수량 || 1}" min="1" max="10" readonly>
	        </div>
	      </div>
	    `;
	    container.insertAdjacentHTML('beforeend', rowHtml);
	  }
	  
	  // 반출 요청 사유는 변경 없이 유지
	  const reasonHtml = `		
	    <div class="form-group">
	      <label for="reason">반출 요청 사유 <span class="required">*</span></label>
	      <textarea id="reason" name="requestMsg" rows="4" required maxlength="200" readonly>${rent_reason || ''}</textarea>
	    </div>
	  `;
	  container.insertAdjacentHTML('beforeend', reasonHtml);
	   
	  
	}