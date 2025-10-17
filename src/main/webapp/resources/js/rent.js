document.addEventListener('DOMContentLoaded', function() {
	
		// 반출 등록 모달
	    const registerModal = document.getElementById('registerModal');
	    if (registerModal) {
	        const closeModalBtn = registerModal.querySelector('.modal-close-btn');      
	        const modalProductName = document.getElementById('modalProductName');
	        const modalSerialNumber = document.getElementById('modalSerialNumber'); 
	        const cancelBtn = document.getElementById('cancelBtn');
	        
	        
	        // 정보 불러오기
	        function openRegisterModal() {
	            modalProductName.value =  "LG그램";
	            modalSerialNumber.value =  "";
	            registerModal.style.display = 'flex';
	        }
	        
	        function closeRegisterModal() {
	            registerModal.style.display = 'none';
	        }

	        if(closeModalBtn) closeModalBtn.addEventListener('click', closeRegisterModal);
	        if(cancelBtn) cancelBtn.addEventListener('click', closeRegisterModal);
	        registerModal.addEventListener('click', function(event) {
	            if (event.target === registerModal) closeRegisterModal();
	        });
	    }

	    // 등록 버튼에 리스너 등록
	    const entryBtn = document.querySelector('.regist-button');   
	    console.log(entryBtn);
	    if(!entryBtn) return;
	    
	    entryBtn.addEventListener('click', function(event) {
	    	
	    	
	        // 상태 배지의 클래스에 따라 다른 동작 수행

	            openRegisterModal();
	            
	            
	        
	        // else if (statusBadge.classList.contains('status-rejected')) {
	            // 임시 코드
	            // const tempReason = "다른 제품을 이용하십시오";
	            // Swal.fire({
	            // title: "거부됨",
	            // text: tempReason,
	            // icon: "error",
	            // confirmButtonColor: "#d33",
	            // confirmButtonText: "확인",
	            // });

	        // } else if (statusBadge.classList.contains('status-pending')) {
	            // 대기중 row 모달
	          // Swal.fire({
	          // title: "대기중입니다",
	         // text: "조금만 더 기다려주세요.",
	         // icon: "info",
	         // confirmButtonColor: "#1c4587",
	         // confirmButtonText: "확인",
	        // });
	       // }
	    }); 
		
	});


// 폼 전환 함수
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