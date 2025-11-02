document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('registerModal');
 
    if (!modal) return; 

    const registerButtons = document.querySelectorAll('.regist-button');
    const closeModalBtn = document.getElementById('closeModalBtn');
    const cancelBtn = document.getElementById('cancelBtn');
    const submitBtn = document.getElementById('submitBtn');

    const modalAssetId = document.getElementById('modalAssetId');
    const modalRentId = document.getElementById('modalRentId');
    const modalProductName = document.getElementById('modalProductName');
    const modalReturnDate = document.getElementById('modalReturnDate');
    const modalRegDate = document.getElementById('modalRegisterDate');
    const modalSerialNumber = document.getElementById('modalSerialNumber');

    const openModal = (e) => {
        const btn = e.currentTarget;
        const dataset = btn.dataset;

        modalAssetId.value = dataset.assetId;
        modalRentId.value = dataset.rentId;
        modalProductName.value = dataset.assetName;
        modalReturnDate.value = dataset.returnDate;
        modalSerialNumber.value = '';

        modal.style.display = 'flex';
    };

    const closeModal = () => {
        modal.style.display = 'none';
    };

    registerButtons.forEach(button => {
        button.addEventListener('click', openModal);
    });
    closeModalBtn.addEventListener('click', closeModal);
    cancelBtn.addEventListener('click', closeModal);
    modal.addEventListener('click', (event) => {
        if (event.target === modal) {
            closeModal();
        }
    });
    
    submitBtn.addEventListener('click', () => { 
        
        const assetId = modalAssetId.value;
        const rentId = modalRentId.value;
        const serialNumber = modalSerialNumber.value.trim();

        if (!serialNumber) {
            Swal.fire('입력 오류', '일련번호를 입력해주세요.', 'warning');
            return;
        }

        const data = {
            assetId: assetId,
            rentId: rentId,
            serialNumber: serialNumber
        };
        
        fetch('/assetmanager/rent/register-item', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (response.ok) {
                return; 
            } else {
                return response.json().then(errorData => {
                    const error = new Error(errorData.message || '일련번호가 일치하지 않거나 오류가 발생했습니다.');
                    throw error; 
                });
            }
        })
        .then(() => {
            return Swal.fire('처리 완료', '자산 반출이 등록되었습니다.', 'success');
        })
        .then(() => {
            closeModal();
            location.reload();
        })
        .catch(error => {
            console.error('Error:', error);
            Swal.fire('처리 실패', error.message || '요청 중 오류가 발생했습니다.', 'error');
        });
    });
});