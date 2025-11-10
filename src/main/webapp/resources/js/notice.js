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
            title: toastMessage,  // 저장했던 메시지 ("거절 처리가 완료되었습니다.")
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
            customClass: {
                popup: 'custom-swal-toast'
            }
        });

        // 4. (중요) 메시지를 띄운 후 즉시 삭제
        // (새로고침할 때 토스트가 또 뜨는 것을 방지)
        sessionStorage.removeItem('showToastMessage');
    }
});