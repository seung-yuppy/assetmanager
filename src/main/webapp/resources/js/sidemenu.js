document.addEventListener('DOMContentLoaded', function() {
    const menuItems = document.querySelectorAll('.menu-item.menu-sub');

    menuItems.forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault(); // 기본 링크 동작 방지 (페이지 이동)
            
            // 현재 클릭된 메뉴가 이미 활성화되어 있는지 확인
            const isActive = this.classList.contains('active');

            // 모든 메뉴에서 'active' 클래스 제거
            document.querySelectorAll('.menu-item.active').forEach(activeItem => {
                activeItem.classList.remove('active');
            });
            
            // 만약 클릭된 메뉴가 활성화 상태가 아니었다면 'active' 클래스 추가하여 하위 메뉴 열기
            if (!isActive) {
                this.classList.add('active');
            }
        });
    });
});