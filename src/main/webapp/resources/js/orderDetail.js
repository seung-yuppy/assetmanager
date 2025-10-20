document.addEventListener('DOMContentLoaded', function() {
	// 자산 등록 모달
    const registerModal = document.getElementById('registerModal');
    
    if (registerModal) {
        const closeModalBtn = registerModal.querySelector('.modal-close-btn');      
        const modalProductName = document.getElementById('modalProductName');
        const modalSerialNumber = document.getElementById('modalSerialNumber'); 
        const cancelBtn = document.getElementById('cancelBtn');
        
        //정보 불러오기 + 모달 띄우기
        function openRegisterModal(btn) {
        	const formRow = btn.closest('.form-row');
        	if (formRow){
        		modalProductName.value = formRow.querySelector("[name='productNameSelect']").value;
        		
        	}
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

    // 모든 등록 버튼에 리스너 등록
    document.querySelectorAll('.regist-button').forEach(btn => {
    	btn.addEventListener('click', (e) => {
            const targetId = btn.getAttribute('data-target');
            if (targetId) {
            	const registBtn = e.target;
            	openRegisterModal(registBtn);
            }
        });
    });
});