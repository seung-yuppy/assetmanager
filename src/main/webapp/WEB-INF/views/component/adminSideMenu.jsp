<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 Side Menu</title>
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
                <li class="menu-item">
                    <a href="/assetmanager/admin/user/list">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_user.svg" />
                        <span>사용자</span>
                    </a>
                </li>
                <li class="menu-item menu-sub">
					<div class="menu-arrow">
		                <div class="menu-link">
							<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_asset.svg" />
	                        <span>자산</span>      
		                </div>
						<img class="sidebar-arrow-item" src="/assetmanager/resources/image/icon_arrow.svg" />              	
                	</div>
                	<ul class="sub-menu-list">
		            	<li><a href="/assetmanager/admin/asset/list">자산 목록</a></li>
		            	<li><a href="/assetmanager/admin/asset/disposal">불용 자산</a></li>
		            </ul>
                </li>
                <li class="menu-item menu-sub">
                    <div class="menu-arrow">
		                <div class="menu-link">
							<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_item.svg" />
		                    <span>제품</span>            
		                </div>
						<img class="sidebar-arrow-item" src="/assetmanager/resources/image/icon_arrow.svg" />              	
                	</div>
	                <ul class="sub-menu-list">
		            	<li><a href="/assetmanager/admin/item/form">제품 추가</a></li>
		            	<li><a href="/assetmanager/admin/item/list">제품 목록</a></li>
		            </ul>                	
                </li>
				<li class="menu-item">
	            	<a href="/assetmanager/admin/order/list">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dollar.svg" />
		                <span>구입</span>
		            </a>          
	            </li>
	            <li class="menu-item">
	            	<a href="/assetmanager/admin/rent/list">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_rent.svg" />
                        <span>반출</span>
		            </a>          
	            </li>
            </ul>
        </nav>
	<script src="/assetmanager/resources/js/sidemenu.js"></script>
</body>
</html>