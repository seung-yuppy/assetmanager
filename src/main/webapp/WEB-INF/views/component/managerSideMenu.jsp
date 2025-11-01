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
        <nav class="sidebar">
        	<div class="menu-head">
        		<img class="menu-head-item" src="/assetmanager/resources/image/icon_main_dark.svg" />
        		<h2>AMS</h2>
        	</div>
            <ul class="menu-list">
                <li class="menu-item">
                    <a href="/assetmanager/admin/home">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dashboard.svg" />
                        <span>대시보드</span>
                    </a>
                </li>
                <li class="menu-item menu-sub">
                    <div class="menu-arrow">
		                <div class="menu-link">
							<img class="sidebar-logo-item"  src="/assetmanager/resources/image/icon_asset.svg" />
		                    <span>자산</span>           
		                </div>
						<img class="sidebar-arrow-item" src="/assetmanager/resources/image/icon_arrow.svg" />              	
                	</div>
	                <ul class="sub-menu-list">
		            	<li><a href="/assetmanager/myasset/list">내 자산</a></li>
		            	<li><a href="/assetmanager/deptasset/list">부서 자산</a></li>
		            </ul> 
                </li>
                <li class="menu-item">
	            	<a href="/assetmanager/admin/order/list?status=FIRST_APPROVAL">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dollar.svg" />
		                <span>구입</span>
		            </a>          
	            </li>
	            <li class="menu-item">
	            	<a href="/assetmanager/admin/rent/list?status=FIRST_APPROVAL">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_rent.svg" />
                        <span>반출</span>
		            </a>          
	            </li>
            </ul>
        </nav>
	<script src="/assetmanager/resources/js/sidemenu.js"></script>
</body>
</html>