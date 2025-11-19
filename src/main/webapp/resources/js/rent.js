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
        const serialNumber = modalSerialNumber.value.trim();
        if (!serialNumber) {
            Swal.fire('입력 오류', '일련번호를 입력해주세요.', 'warning');
            return;
        }

        const data = {
            assetId: assetId,
            serialNumber: serialNumber
        };
        fetch('/assetmanager/rent/register/item', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body : JSON.stringify(data)
            
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
            			confirmButtonColor: "#1c4587"
                    });
            	}
        })
        .then((result) => {
        	if (result && result.isConfirmed) {
                closeModal();
                location.reload();
            }
        })
        .catch(error => {
            Swal.fire('처리 실패' , '일련번호 등록에 실패했습니다.', 'error');
        });
    });
});