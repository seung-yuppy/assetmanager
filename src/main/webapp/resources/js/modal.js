document.addEventListener('DOMContentLoaded', () => {
    // 1. 트리거 버튼 이벤트 설정: data-target 속성을 가진 모든 요소를 감지
    document.querySelectorAll('[data-toggle="modal"]').forEach(trigger => {
        trigger.addEventListener('click', () => {
            const targetId = trigger.getAttribute('data-target');
            if (targetId) {
                openModal(targetId);
            }
        });
    });

    // 2. 닫기 버튼 및 배경 클릭 이벤트 설정
    document.querySelectorAll('.custom-modal-backdrop').forEach(modal => {
        
        // 닫기 버튼 이벤트 (header, footer 등에 있는 modal-close-btn)
        modal.querySelectorAll('.modal-close-btn').forEach(closeBtn => {
             closeBtn.addEventListener('click', () => {
                closeModal(modal.id);
            });
        });
        
        // 닫기 버튼 이벤트 (header, footer 등에 있는 modal-close-btn)
        modal.querySelectorAll('.secondary-action').forEach(closeBtn => {
        	closeBtn.addEventListener('click', () => {
        		closeModal(modal.id);
        	});
        });

        // 배경 클릭으로 닫기
        modal.addEventListener('click', (event) => {
            if (event.target === modal) {
                closeModal(modal.id);
            }
        });
        
        
    });
});


/**
 * 특정 ID의 모달을 여는 함수
 * @param {string} modalId - 열고자 하는 모달의 ID (예: 'serialRegisterModal')
 */
function openModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.add('show');
        document.body.style.overflow = 'hidden'; // 배경 스크롤 방지
    }
}

/**
 * 특정 ID의 모달을 닫는 함수
 * @param {string} modalId - 닫고자 하는 모달의 ID
 */
function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.remove('show');
        document.body.style.overflow = 'auto'; // 배경 스크롤 허용
    }
}

// Global 함수로 노출하여 HTML inline 이벤트에서 직접 호출 가능하게 함
window.openModal = openModal;
window.closeModal = closeModal;