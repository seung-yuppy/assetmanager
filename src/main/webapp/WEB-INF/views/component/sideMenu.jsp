<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Side Menu</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/sideMenu.css" rel="stylesheet"> 	
</head>
<body>
        <!-- 사이드바 -->
        <nav class="sidebar">
        	<div class="menu-head">
        		<img class="menu-head-item" src="/assetmanager/resources/image/icon_main_dark.svg" />
        		<h2>AMS</h2>
        	</div>
            <ul class="menu-list">
                <li class="menu-item">
                    <a href="/assetmanager/home/user">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dashboard.svg" />
                        <span>대시보드</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="#">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_asset.svg" />
                        <span>자산</span>
                    </a>
                </li>
                <li class="menu-item menu-sub">
	                <div class="menu-link">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dollar.svg" />
	                    <span>구입</span>            
	                </div>
	                <ul class="sub-menu-list">
		            	<li><a href="/assetmanager/order/form">구입 요청</a></li>
		            	<li><a href="/assetmanager/order/user/list">구입 상세</a></li>
		            </ul>                        
                </li>
                <li class="menu-item menu-sub">
                    <div class="menu-link">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_rent.svg" />
                        <span>반출</span>
                    </div>
	                <ul class="sub-menu-list">
	                    <li><a href="#">반출 요청</a></li>
	                    <li><a href="#">반출 상세</a></li>
	                </ul>                    
                </li>
                <li class="menu-list-separator">
                </li>
                <li class="menu-item">
                    <a href="#">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_setting.svg" />
                        <span>설정</span>
                    </a>
                </li>
				<li class="menu-item">
                    <a href="/assetmanager/login">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_logout.svg" />
                        <span>로그아웃</span>
                    </a>
                </li>

            </ul>
        </nav>
		<script src="/assetmanager/resources/js/sidemenu.js"></script>
</body>
</html>