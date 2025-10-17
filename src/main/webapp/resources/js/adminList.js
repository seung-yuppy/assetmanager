document.addEventListener('DOMContentLoaded', function() {
	const tableBody = document.querySelector('.data-table tbody');
	
	if (tableBody) {
        tableBody.addEventListener('click', function(event) { 
        	console.log("1234");
        	window.location.href="/assetmanager/admin/rent/list/detail"
        	
        	
        	
        	
        	
        });
	}
});


/*    // 체크박스 선택 및 버튼 활성화
    const selectAllCheckbox = document.getElementById('selectAllCheckbox');
    const rowCheckboxes = document.querySelectorAll('.row-checkbox:not(:disabled)');
    const approveBtn = document.getElementById('approveBtn');
    const rejectBtn = document.getElementById('rejectBtn');

    function updateButtonState() {
        const checkedCount = document.querySelectorAll('.row-checkbox:checked').length;
        if (approveBtn) approveBtn.disabled = checkedCount === 0;
        if (rejectBtn) rejectBtn.disabled = checkedCount === 0;
    }

    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function() {
            rowCheckboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
                checkbox.closest('tr').classList.toggle('selected', this.checked);
            });
            updateButtonState();
        });
    }

    rowCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            this.closest('tr').classList.toggle('selected', this.checked);
            const allChecked = document.querySelectorAll('.row-checkbox:not(:disabled):checked').length === rowCheckboxes.length;
            if (selectAllCheckbox) selectAllCheckbox.checked = allChecked;
            updateButtonState();
        });
    });

    if (approveBtn) {
        approveBtn.addEventListener('click', function() {
            const selectedIds = [];
            document.querySelectorAll('.row-checkbox:checked').forEach(checkbox => {
                const id = checkbox.closest('tr').querySelector('td:nth-child(2)').textContent;
                selectedIds.push(id);
            });
            if (selectedIds.length > 0) {
                alert('다음 항목들을 승인합니다: ' + selectedIds.join(', '));

                 승인 처리 ajax 요청 
            }
        });
    }

    if (rejectBtn) {
        rejectBtn.addEventListener('click', function() {
            const selectedIds = [];
            document.querySelectorAll('.row-checkbox:checked').forEach(checkbox => {
                const id = checkbox.closest('tr').querySelector('td:nth-child(2)').textContent;
                selectedIds.push(id);
            });
            if (selectedIds.length > 0) {
                alert('다음 항목들을 거부합니다: ' + selectedIds.join(', '));
                
                 거부 처리 ajax 요청             
            }
        });
    }

    updateButtonState();

    // 행 클릭 시 상세 모달 보기
    const detailModal = document.getElementById('detailModal');
    if (detailModal) {
        const modalProductName = document.getElementById('modalProductName');
        const modalSerialNumber = document.getElementById('modalSerialNumber');
        const modalUserName = document.getElementById('modalUserName');
        const modalDepartment = document.getElementById('modalDepartment');
        const modalPosition = document.getElementById('modalPosition');
        const modalReason = document.getElementById('modalReason');
        const modalReturnDate = document.getElementById('modalReturnDate');
        
        const detailModalCloseBtns = detailModal.querySelectorAll('.modal-close-btn, .btn-primary');
        const tableBody = document.querySelector('.data-table tbody');

        function openDetailModal(data) {
            modalProductName.value = data.productName || '정보 없음'; 
            modalSerialNumber.value = data.serialNumber || '정보없음'; 
            modalUserName.value = data.userName || '정보 없음';
            modalDepartment.value = data.department || '정보 없음';
            modalPosition.value = data.position || '정보 없음';
            modalReturnDate.value = data.modalReturnDate || '정보 없음';

            if(modalReason) modalReason.value = data.reason || '정보 없음';
            
            detailModal.style.setProperty('display', 'flex', 'important');
        }

        function closeDetailModal() {
            detailModal.style.setProperty('display', 'none');
        }
        
        detailModalCloseBtns.forEach(btn => btn.addEventListener('click', closeDetailModal));
        detailModal.addEventListener('click', function(event) {
            if (event.target === detailModal) closeDetailModal();
        });

        if (tableBody) {
            tableBody.addEventListener('click', function(event) {
                const clickedElement = event.target;
                const clickedRow = clickedElement.closest('tr');
                if (!clickedRow) return;

                if (clickedElement.matches('input[type="checkbox"]')) {
                    return;
                }

                const requestId = clickedRow.getAttribute('data-id');
                if (!requestId) return;

                console.log(`${requestId}의 상세 정보를 요청합니다.`);
                
                 상세 정보 조회 ajax 요청 
               
                // 임시 코드입니다 
                const tempData = {
                    productName: clickedRow.querySelector('td:nth-child(3)').textContent,
                    serialNumber: "ABC-123456-XYZ",
                    userName: clickedRow.querySelector('td:nth-child(4)').textContent,
                    department: "개발팀",
                    position: "선임 연구원",
                    reason:"회의실 디스플레이용",  
                    modalReturnDate:"2025-12-31"
                };
                openDetailModal(tempData);  
            });
        }
    }*/