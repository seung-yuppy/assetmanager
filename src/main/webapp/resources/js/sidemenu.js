document.addEventListener('DOMContentLoaded', function() {
    // URL에서 도메인 부분(예: http://localhost:8080)을 제외한 경로(pathname)만 사용합니다.
    // 경로의 마지막에 슬래시(/)가 있다면 제거하여 비교의 일관성을 확보합니다.
    const currentPath = window.location.pathname.replace(/\/$/, ""); 
    const menuItems = document.querySelectorAll('.menu-list > .menu-item');

    // 모든 메뉴 항목의 활성 상태를 초기화하고 현재 URL에 매핑합니다.
    function setActiveMenu() {
        // 기존 active 클래스 모두 제거 (토글 로직과 충돌 방지 및 재설정)
        document.querySelectorAll('.menu-item.active').forEach(item => {
            item.classList.remove('active');
        });
        document.querySelectorAll('.active-sub-link').forEach(link => {
            link.classList.remove('active-sub-link');
        });
        
        // 모든 메뉴 항목 순회하며 현재 URL과 일치하는 항목 찾기
        menuItems.forEach(item => {
            // 1. 하위 메뉴가 없는 단순 메뉴 항목 처리 (대시보드, 자산)
            const directLink = item.querySelector(':scope > a'); 
            if (directLink) {
                const linkPath = directLink.getAttribute('href').replace(/\/$/, "");
                if (linkPath === currentPath) {
                    item.classList.add('active'); // 상위 메뉴 항목에 active 클래스 추가 (흰색 배경)
                    return; // 활성화 완료, 다음 항목으로 이동
                }
            }

            // 2. 하위 메뉴가 있는 항목 처리 (구입, 반출)
            if (item.classList.contains('menu-sub')) {
                const subMenuLinks = item.querySelectorAll('.sub-menu-list a');
                
                subMenuLinks.forEach(subLink => {
                    const subLinkPath = subLink.getAttribute('href').replace(/\/$/, "");
                    
                    if (subLinkPath === currentPath) {
                        // 하위 메뉴가 현재 URL과 일치하면
                        item.classList.add('active'); // 🌟 상위 메뉴 항목에 active 클래스 추가 (흰색 배경 및 펼침)
                        subLink.classList.add('active-sub-link'); // 하위 메뉴 링크에 활성 클래스 추가 (하위 메뉴 자체의 텍스트 색상 변경용)
                    }
                });
            }
        });
    }

    // 페이지 로드 시 활성 메뉴 설정
    setActiveMenu();


    // 3. 상위 메뉴 토글 로직
    // 하위 메뉴를 가진 항목에 대해서만 클릭 리스너 설정
    document.querySelectorAll('.menu-item.menu-sub').forEach(item => {
        const menuArrow = item.querySelector('.menu-arrow');
        
        menuArrow.addEventListener('click', function(e) {
            e.preventDefault();

            const isActive = item.classList.contains('active');

            // URL 매핑에 의해 active가 설정된 항목을 제외하고, 토글을 위해 active 클래스 제거
            // 모든 .menu-item.menu-sub 항목을 순회하여 active 클래스를 제거합니다.
            // **참고: 토글 시 URL 매핑으로 인한 active 상태도 일시적으로 사라지지만, 토글 후 setActiveMenu()를 호출하면 재설정됩니다.**
            document.querySelectorAll('.menu-item.menu-sub').forEach(activeItem => {
                 activeItem.classList.remove('active');
            });

            if (!isActive) {
                item.classList.add('active'); // 클릭된 항목 활성화
            }
            
            // 토글 후, 혹시 현재 경로가 포함되어 있다면 active 상태 재설정 (선택 사항이나 안정성 향상)
            // setActiveMenu(); 
        });
    });

    // 4. 하위 메뉴 클릭 시 페이지 이동 (기존 로직 유지)
    document.querySelectorAll('.sub-menu-list a').forEach(link => {
        link.addEventListener('click', function(e) {
            // 페이지 이동을 위해 e.preventDefault() 제거
        });
    });
});