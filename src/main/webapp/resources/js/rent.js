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