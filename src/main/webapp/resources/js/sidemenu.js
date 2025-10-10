document.addEventListener('DOMContentLoaded', function() {
    const menuItems = document.querySelectorAll('.menu-item.menu-sub');

    menuItems.forEach(item => {
        const menuLink = item.querySelector('.menu-link'); // 상위 메뉴 링크 (구입, 반출)
        const subMenuLinks = item.querySelectorAll('.sub-menu-list a'); // 하위 메뉴 링크 (구입 요청, 구입 상세)

        // 상위 메뉴 클릭 시 하위 메뉴 토글
        menuLink.addEventListener('click', function(e) {
            e.preventDefault(); 
            const isActive = item.classList.contains('active');
            
            document.querySelectorAll('.menu-item.active').forEach(activeItem => {
                activeItem.classList.remove('active');
            });

            if (!isActive) {
                item.classList.add('active');
            }
        });

        // 하위 메뉴 클릭 시 페이지 이동
        subMenuLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                // e.preventDefault() 제거
                // 하위 메뉴 클릭 시에는 페이지 이동이 정상적으로 발생
                // 필요하다면 추가적인 로직을 여기에 넣을 수 있습니다.
            });
        });
    });
});