<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="/assetmanager/resources/css/notification.css" rel="stylesheet">
<!-- 알림 토글 영역 (position: relative를 위해 wrapper 사용) -->
<div id="notification-toggle" class="notification-toggle">
    
    <%-- 사용자가 제공한 알림 이미지와 배지 --%>
    <img src="/assetmanager/resources/image/icon_header1.png" id="bell-icon-button-img" class="header-bell header-alarm" alt="알림">

    <%-- 알림 배지 (읽지 않은 알림 수) --%>
    <span id="notification-badge" class="notification-badge" style="display:none;"></span>

    <!-- 알림 드롭다운 패널 (절대 위치 설정) -->
    <div id="notification-dropdown" class="notification-dropdown">
        
        <!-- 헤더 -->
        <div class="dropdown-header">
            <h3>알림</h3>
            <button class="mark-all-read-button">모두 읽음으로 표시</button>
        </div>

        <!-- 알림 목록 -->
        <div class="notification-list"></div>

        <!-- 푸터 -->
        <div class="dropdown-footer">더 보기</div>
    </div>
</div>
<script src="/assetmanager/resources/js/notification.js"></script>
