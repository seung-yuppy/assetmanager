<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<!-- 홈 로고 시작 -->
		<div>
			<c:if test="${userInfo.role == 'employee' || userInfo.role == 'manager' || userInfo.role == 'department'}">
				<a href="/assetmanager/home" class="logo-box">
					<img class="menu-head-item" src="/assetmanager/resources/image/icon_main_dark.svg" />
					<h2 class="logo-title">AMS</h2>
				</a>			
			</c:if>
			<c:if test="${userInfo.role == 'admin'}">
			    <a href="/assetmanager/admin/home" class="logo-box">
					<img class="menu-head-item" src="/assetmanager/resources/image/icon_main_dark.svg" />
					<h2 class="logo-title">AMS</h2>
                </a>
			</c:if>
		</div>
		<!-- 홈 로고 끝 -->
		<ul class="menu-list">
			<!-- 대시보드 시작 -->
			<li class="menu-item">
				<c:if test="${userInfo.role == 'employee' || userInfo.role == 'manager' || userInfo.role == 'department'}">
					<a href="/assetmanager/home">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dashboard.svg" />
						<span>대시보드</span>
					</a>
				</c:if>
				<c:if test="${userInfo.role == 'admin'}">
				    <a href="/assetmanager/admin/home">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dashboard.svg" />
	                    <span>대시보드</span>
	                </a>
				</c:if>
			</li>
			<!-- 대시보드 끝-->
			<!-- 사용자 메뉴 시작 -->
			<c:if test="${userInfo.role == 'admin'}">
                <li class="menu-item">
                    <a href="/assetmanager/admin/user/list">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_user.svg" />
                        <span>사용자</span>
                    </a>
                </li>			
			</c:if>
			<!-- 사용자 메뉴 끝 -->
			<!-- 자산메뉴 시작 -->
			<c:if test="${userInfo.role == 'employee'}">
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
			</c:if>
			<c:if test="${userInfo.role == 'department'}">
                <li class="menu-item">
                    <a href="/assetmanager/myasset/list">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_asset.svg" />
						<span>자산</span> 
                    </a>
                </li>			
			</c:if>
			<c:if test="${userInfo.role == 'manager'}">
                <li class="menu-item">
                    <a href="/assetmanager/deptasset/list">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_asset.svg" />
						<span>자산</span> 
                    </a>
                </li>			
			</c:if>
			<c:if test="${userInfo.role == 'admin'}">
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
		            	<li><a href="/assetmanager/admin/asset/disposal">불용 목록</a></li>
		            </ul>
                </li>						
			</c:if>
			<!-- 자산메뉴 끝 -->
			<!-- 상품메뉴 시작 -->
			<c:if test="${userInfo.role == 'admin'}">
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
			</c:if>
			<!-- 상품메뉴 끝 -->
			<!-- 반출메뉴 시작 -->
			<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
				<li class="menu-item menu-sub">
					<div class="menu-arrow">
						<div class="menu-link">
							<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_rent.svg" />
							<span>반출</span>
						</div>
						<img class="sidebar-arrow-item" src="/assetmanager/resources/image/icon_arrow.svg" />
					</div>
					<ul class="sub-menu-list">
						<li><a href="/assetmanager/rent/form">반출 요청</a></li>
						<li><a href="/assetmanager/rent/list">요청 목록</a></li>
					</ul>                    
				</li>
			</c:if>
			<c:if test="${userInfo.role == 'admin'}">
				<li class="menu-item menu-sub">
					<div class="menu-arrow">
						<div class="menu-link">
							<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_rent.svg" />
	                        <span>반출</span>          
						</div>
						<img class="sidebar-arrow-item" src="/assetmanager/resources/image/icon_arrow.svg" />              	
					</div>
					<ul class="sub-menu-list">
						<li><a href="/assetmanager/admin/rent/list">요청 목록</a></li>
						<li><a href="/assetmanager/admin/delay/list">연장 목록</a></li>
					</ul>                        
				</li>		
			</c:if>
			<c:if test="${userInfo.role == 'manager'}">
				<li class="menu-item menu-sub">
					<div class="menu-arrow">
						<div class="menu-link">
							<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_rent.svg" />
	                        <span>반출</span>          
						</div>
						<img class="sidebar-arrow-item" src="/assetmanager/resources/image/icon_arrow.svg" />              	
					</div>
					<ul class="sub-menu-list">
						<li><a href="/assetmanager/rent/form">반출 요청</a></li>
						<li><a href="/assetmanager/manager/rent/list">요청 목록</a></li>
						<li><a href="/assetmanager/manager/delay/list">연장 목록</a></li>
					</ul>                        
				</li>
			</c:if>
			<!-- 반출메뉴 끝 -->
			<!-- 구입메뉴 시작 -->
			<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
				<li class="menu-item menu-sub">
					<div class="menu-arrow">
						<div class="menu-link">
							<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dollar.svg" />
							<span>구입</span>            
						</div>
						<img class="sidebar-arrow-item" src="/assetmanager/resources/image/icon_arrow.svg" />              	
					</div>
					<ul class="sub-menu-list">
						<li><a href="/assetmanager/order/form">구입 요청</a></li>
						<li><a href="/assetmanager/order/list">요청 목록</a></li>
					</ul>                        
				</li>			
			</c:if>
			<c:if test="${userInfo.role == 'admin'}">
				<li class="menu-item menu-sub">
					<div class="menu-arrow">
						<div class="menu-link">
							<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dollar.svg" />
			                <span>구입</span>         
						</div>
						<img class="sidebar-arrow-item" src="/assetmanager/resources/image/icon_arrow.svg" />              	
					</div>
					<ul class="sub-menu-list">
						<li><a href="/assetmanager/admin/order/list">요청 목록</a></li>
						<li><a href="/assetmanager/admin/stats">구입 통계</a></li>
					</ul>      
	            </li>
			</c:if>
			<c:if test="${userInfo.role == 'manager'}">
				<li class="menu-item menu-sub">
					<div class="menu-arrow">
						<div class="menu-link">
							<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_dollar.svg" />
			                <span>구입</span>     
						</div>
						<img class="sidebar-arrow-item" src="/assetmanager/resources/image/icon_arrow.svg" />              	
					</div>
					<ul class="sub-menu-list">
						<li><a href="/assetmanager/order/form">구입 요청</a></li>
						<li><a href="/assetmanager/manager/order/list">요청 목록</a></li>
					</ul>      
	            </li>			
			</c:if>
			<!-- 구입메뉴 끝 -->
			<!-- 반납메뉴 시작 -->
			<c:if test="${userInfo.role == 'admin'}">
	            <li class="menu-item">
	            	<a href="/assetmanager/admin/return/list">
						<img class="sidebar-logo-item" src="/assetmanager/resources/image/icon_return.png" />
                        <span>반납</span>
		            </a>          
	            </li>			
			</c:if>			
			<!-- 반납메뉴 끝 -->
		</ul>
	</nav>
	<script src="/assetmanager/resources/js/sidemenu.js"></script>
</body>
</html>