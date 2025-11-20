document.addEventListener('DOMContentLoaded', function() {
	// 자산 등록 모달
    const registerModal = document.getElementById('registerModal');
    
    if (registerModal) {
    	// 모달 html 요소 선언
        const closeModalBtn = registerModal.querySelector('.modal-close-btn');      
        const modalProductName = document.getElementById('modalProductName');
        const modalSerialNumber = document.getElementById('modalSerialNumber'); 
        const modalSpec = document.getElementById('modalSpec');
        const cancelBtn = document.getElementById('cancelBtn');
        const registerBtn = document.getElementById('registerBtn');
        
        //정보 불러오기 + 모달 띄우기
        function openRegisterModal(btn) {
        	const formRow = btn.closest('.form-row');
        	if (formRow){
        		modalProductName.value = formRow.querySelector("[name='productNameSelect']").value;
        		modalSpec.value = formRow.querySelector("[name='spec']").value;
        		
        		modalProductName.setAttribute('data-category-id', formRow.querySelector("[name*='category']").getAttribute('data-id'));  
        		modalProductName.setAttribute('data-content-id', formRow.getAttribute('data-content-id'));  
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
        // 자산 등록
        if(registerBtn) registerBtn.addEventListener('click', (e) =>{
        	const serialNum = modalSerialNumber.value.trim();
        	const assetName = modalProductName.value;
        	const spec = modalSpec.value;
        	const categoryId = modalProductName.getAttribute('data-category-id');
        	const orderContentId = modalProductName.getAttribute('data-content-id');
        	
        	const data = {
        			categoryId: categoryId, 
        			assetName: assetName , 
        			serialNumber: serialNum,
        			spec : spec
                };
        	fetch(`/assetmanager/order/register/${orderContentId}`, {
        		  method: 'POST',
        		  headers: { 'Content-Type': 'application/json' },
        		  body: JSON.stringify(data)
        		})
        		.then(response => {
                	return response.json();
                })
                .then(data => {
                    if(data.msg==='일련번호가 일치하지 않거나 오류가 발생했습니다.'){
                    		 Swal.fire('처리 실패', data.msg, 'error');
                    } else {
                    		return Swal.fire({
                                title: '처리 완료',
                                text: data.msg,
                                icon: 'success',
                                confirmButtonText: '확인',
                    			confirmButtonColor: "#1c4587",
                            });
                    	}
                })
                .then((result) => {
                	if (result && result.isConfirmed) {
                		closeRegisterModal();
                        location.reload();
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    Swal.fire('처리 실패' , '일련번호 등록에 실패했습니다.', 'error');
                });
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

//요청 취소
const cancelBtn = document.querySelector("#cancel-btn");
if(cancelBtn){
	cancelBtn.addEventListener("click", async () => {
		const container = document.querySelector('.section-card');
		const id = container.getAttribute('data-id');
		const userId = container.getAttribute('data-author');
		if(userId != loginUser.id) // 작성자가 취소하는지 확인
			return;
		Swal.fire({
			title:"회수하시겠습니까?",
			icon: "warning",
			confirmButtonColor: "#1c4587",
			confirmButtonText: "예",
			showCancelButton: true,
			cancelButtonText: '아니오',
			customClass: {
				input: 'custom-swal-input'
			},
			preConfirm: async () => { 
				const res = await fetch(`/assetmanager/order/cancel?id=${id}`, {
					method: "GET",
					headers: {
						"Content-Type": "application/json",
					}
				});
				const data = await res.json();
				
				if (data.msg === "회수가 완료되었습니다.") {
					Swal.fire({
						title: "성공",
						text: data.msg,
						icon: "success",
						confirmButtonColor: "#1c4587",
						confirmButtonText: "확인",
					}).then(() =>{
						location.reload();
					});
				} else {
					Swal.fire({
						title: "실패",
						text: data.msg,
						icon: "error",
						confirmButtonColor: "#1c4587",
						confirmButtonText: "확인",
					}).then(() =>{
						window.location.reload();
					});
				}
			}
		})
	});
}
