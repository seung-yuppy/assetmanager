document.addEventListener('DOMContentLoaded', () => {
    
    // 1. sessionStorage에서 토스트 메시지 가져오기
    const toastMessage = sessionStorage.getItem('showToastMessage');

    // 2. 메시지가 있는지 확인
    if (toastMessage) {
        
        // 3. SweetAlert 토스트 띄우기
        Swal.fire({
            toast: true,
            position: 'bottom-end',
            icon: 'success',
            title: toastMessage,
            showConfirmButton: false,
            timer: 5000,
            timerProgressBar: true,
            customClass: {
                popup: 'custom-swal-toast'
            }
        });

        sessionStorage.removeItem('showToastMessage');
    }
});