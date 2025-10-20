document.addEventListener('DOMContentLoaded', function() {
	// 반출 등록 모달
    const registerModal = document.getElementById('registerModal');
    
    if (registerModal) {
        const closeModalBtn = registerModal.querySelector('.modal-close-btn');      
        const modalProductName = document.getElementById('modalProductName');
        const modalSerialNumber = document.getElementById('modalSerialNumber'); 
        const cancelBtn = document.getElementById('cancelBtn');
        
        // 정보 불러오기
        function openRegisterModal(targetId) {
        	const modalBody = targetId.closest('.modal-body');
        	
            modalProductName.value =  "맥북";
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
    document.querySelectorAll('.regist-button').forEach(btn => {
    	btn.addEventListener('click', () => {
            const targetId = trigger.getAttribute('data-target');
            if (targetId) {
            	openRegisterModal(targetId);
            }
        });
    });
});