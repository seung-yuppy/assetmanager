document.addEventListener('DOMContentLoaded', function() {
    
    // 반출 등록 모달
    const registerModal = document.getElementById('registerModal');
    if (registerModal) {
        const closeModalBtn = registerModal.querySelector('.modal-close-btn');
        const cancelBtn = document.getElementById('cancelBtn');
        const modalProductName = document.getElementById('modalProductName');
        const modalUserName = document.getElementById('modalUserName');
        const modalSerialNumber = document.getElementById('modalSerialNumber');
        const modalDepartment = document.getElementById('modalDepartment');
        const modalPosition = document.getElementById('modalPosition');
        const modalReturnDate = document.getElementById('modalReturnDate');
        
        // 정보 불러오기
        function openRegisterModal(userInfo) {
            modalProductName.value = userInfo.productName || "";
            modalUserName.value = userInfo.userName || "";
            modalSerialNumber.value = userInfo.modalSerialNumber || "";
            modalDepartment.value = userInfo.department || "";
            modalPosition.value = userInfo.position || "";
            modalReturnDate.value = userInfo.modalReturnDate || "";
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

    // tbody에 클릭 이벤트 리스너 등록
    const tableBody = document.querySelector('.data-table tbody');
    if (!tableBody) return;
    
    tableBody.addEventListener('click', function(event) {
        const clickedRow = event.target.closest('tr');
        if (!clickedRow) return;

        const statusBadge = clickedRow.querySelector('.status-badge');
        if (!statusBadge) return;

        // 상태 배지의 클래스에 따라 다른 동작 수행
        if (statusBadge.classList.contains('status-approved')) {
            // 승인됨 row이면 반출 등록 모달 ajax 요청
        	const requestId = clickedRow.getAttribute('data-id') || clickedRow.querySelector('td:first-child').textContent;
        	// 임시 코드
            console.log(`서버에 ${requestId}의 사용자 정보를 요청합니다.`);
            // 예시 데이터
            const tempUserInfo = {
                productName: clickedRow.querySelector('td:nth-child(2)').textContent,
                userName: clickedRow.querySelector('td:nth-child(3)').textContent,
                modalSerialNumber: "ABC-123456-XYZ",
                department: "개발팀",
                position: "선임 연구원",
                modalReturnDate:"2025-12-31"
            };
            openRegisterModal(tempUserInfo);

        } else if (statusBadge.classList.contains('status-rejected')) {       
            //임시 코드
            const tempReason = "다른 제품을 이용하십시오";
            Swal.fire({
                title: "거부됨",
                text: tempReason,
                icon: "error",
                confirmButtonColor: "#d33",
                confirmButtonText: "확인",
            });

        } else if (statusBadge.classList.contains('status-pending')) {
            // 대기중 row 모달
            Swal.fire({
                title: "대기중입니다",
                text: "조금만 더 기다려주세요.",
                icon: "info",
                confirmButtonColor: "#1c4587",
                confirmButtonText: "확인",
            });
        }
    });
});