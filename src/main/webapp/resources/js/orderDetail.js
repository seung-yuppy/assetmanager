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

//요청 취소
const cancelBtn = document.querySelector("#cancel-btn");
console.log("cancelBtn: " + cancelBtn);

cancelBtn.addEventListener("click", async () => {
	const container = document.querySelector('.section-card');
	const id = container.getAttribute('data-id');
	const userId = container.getAttribute('data-author');
	if(userId != loginUser.id) // 작성자가 취소하는지 확인
		return;
	Swal.fire({
		title:"요청을 취소하시겠습니까?",
		imageUrl: "/assetmanager/resources/image/reject_admin.jpg",
		imageWidth: 90,
		imageHeight: 90, 
		imageAlt: "경고 아이콘",
		confirmButtonColor: "#14b3ae",
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
			
			if (data.msg === "요청 취소가 완료되었습니다.") {
				Swal.fire({
					title: "성공",
					text: data.msg,
					icon: "success",
					confirmButtonColor: "#a5dc86",
					confirmButtonText: "확인",
				}).then(() =>{
					location.href = "/assetmanager/order/list";
				});
			} else {
				Swal.fire({
					title: "실패",
					text: data.msg,
					icon: "error",
					confirmButtonColor: "#d33",
					confirmButtonText: "확인",
				}).then(() =>{
					window.location.reload();
				});
			}
		}
	})
});
