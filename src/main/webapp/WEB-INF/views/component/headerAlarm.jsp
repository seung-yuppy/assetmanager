<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%-- 읽지 않은 알림 수를 JSP 변수로 가정 --%>
<%
    int unreadCount = 3; // 실제 환경에서는 Model에서 받아온 값 사용
%>

<!-- 알림 토글 영역 (position: relative를 위해 wrapper 사용) -->
<div id="notification-toggle" class="notification-toggle">
    
    <%-- 사용자가 제공한 알림 이미지와 배지 --%>
    <img src="/assetmanager/resources/image/icon_header1.png" id="bell-icon-button-img" 
         class="header-bell header-alarm" alt="알림">

    <%-- 알림 배지 (읽지 않은 알림 수) --%>
    <span id="notification-badge" class="notification-badge" style="<%= unreadCount == 0 ? "display: none;" : "" %>">
        <%= unreadCount > 99 ? "99+" : unreadCount %>
    </span>

    <!-- 알림 드롭다운 패널 (절대 위치 설정) -->
    <div id="notification-dropdown" class="notification-dropdown">
        
        <!-- 헤더 -->
        <div class="dropdown-header">
            <h3>알림</h3>
            <button class="mark-all-read-button">모두 읽음으로 표시</button>
        </div>

        <!-- 알림 목록 (데이터는 임시로 하드코딩) -->
        <div class="notification-list">
            <!-- 알림 아이템: 읽지 않음 -->
            <div class="notification-item unread-notification">
                <div class="unread-dot"></div>
                <div class="content">
                    <p>
                        <span>시스템 공지:</span> 새로운 기능 업데이트가 배포되었습니다!
                    </p>
                    <p>5분 전</p>
                </div>
            </div>

            <!-- 알림 아이템: 읽지 않음 -->
            <div class="notification-item unread-notification">
                <div class="unread-dot"></div>
                <div class="content">
                    <p>
                        <span>김지수</span> 님이 회원님의 게시물에 댓글을 남겼습니다.
                    </p>
                    <p>2시간 전</p>
                </div>
            </div>

            <!-- 알림 아이템: 읽음 -->
            <div class="notification-item read-notification">
                <div class="spacer"></div>
                <div class="content">
                    <p>
                        회원님의 요청이 성공적으로 처리되었습니다.
                    </p>
                    <p>3일 전</p>
                </div>
            </div>
            
        </div>

        <!-- 푸터 -->
        <div class="dropdown-footer">
            <a href="/assetmanager/notifications/all">
                전체 알림 보기
            </a>
        </div>
    </div>
</div>

<script>
	document.addEventListener('DOMContentLoaded', () => {
	    // 알림 토글을 위한 요소 선택 (이미지 자체가 토글 버튼 역할을 하도록 설정)
	    const bellImage = document.getElementById('bell-icon-button-img');
	    const dropdown = document.getElementById('notification-dropdown');
	    const bellWrapper = document.getElementById('notification-toggle');
	
	    // 알림 드롭다운 토글 함수
	    function toggleDropdown() {
	        // img는 토글을 담당하고, dropdown에 show 클래스를 토글하여 표시
	        dropdown.classList.toggle('show'); 
	    }
	
	    // 종 아이콘 이미지 클릭 이벤트 리스너
	    bellImage.addEventListener('click', (event) => {
	        event.stopPropagation(); // 버튼 클릭이 body 클릭으로 전파되는 것을 방지
	        toggleDropdown();
	    });
	
	    // 드롭다운 외부 클릭 시 닫기
	    document.addEventListener('click', (event) => {
	        const isClickInside = bellWrapper.contains(event.target);
	        
	        // 드롭다운이 열려있고, 클릭이 알림 영역 전체 (toggle wrapper) 외부일 경우 닫기
	        if (dropdown.classList.contains('show') && !isClickInside) {
	            dropdown.classList.remove('show');
	        }
	    });
	
	    // Esc 키 입력 시 닫기
	    document.addEventListener('keydown', (event) => {
	        if (event.key === 'Escape' && dropdown.classList.contains('show')) {
	            dropdown.classList.remove('show');
	        }
	    });
	    // **주의: 배지 숨김 로직은 JSP 단에서 처리되었지만, JS에서도 필요하다면 추가 구현해야 합니다.**
	});
</script>
