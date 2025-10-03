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
        		<img class="menu-head-item" src="/assetmanager/resources/image/icon_main.svg" />
        		<h2>AMS</h2>
        	</div>
        	
        	<div class="menu-profile">
        		
        	</div>
	
			<div class="menu-list-separator"></div>
			
            <ul class="menu-list">
                <!-- 대시보드 (활성 메뉴) -->
                <li class="menu-item">
                    <a href="#">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dashboard.svg" />
                        <span>대시보드</span>
                    </a>
                </li>
                
                <!-- 자산 관리 메뉴 그룹 -->
                <li class="menu-item">
                    <a href="#">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_asset.svg" />
                        <span>자산</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="#">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dollar.svg" />
                        <span>구입</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="#">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_rent.svg" />
                        <span>반출</span>
                    </a>
                </li>
                <li class="menu-item">
                    <a href="#">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_setting.svg" />
                        <span>설정</span>
                    </a>
                </li>

            </ul>
        </nav>
</body>
</html>