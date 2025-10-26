<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>헤더</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/header.css" rel="stylesheet">
</head>
<body>
	<!-- 헤더 -->
	<header class="header">
		<ul class="header-list">
			<li class="header-item-profile">
				<a href="/assetmanager/mypage">
					<img src="data:image/png;base64,${userInfo.base64ProfileImage}" class="header-profile-image">
				</a>
			</li>			

			<li class="header-item-profile">
				<img src="/assetmanager/resources/image/icon_header1.png" class="header-bell header-alarm">
			</li>
			
			<li class="header-item-profile">
				<form method="POST" action="/assetmanager/logout" class="logout-form">
					<button type="submit" class="logout-button">
						<img src="/assetmanager/resources/image/icon_header2.png" class="header-bell">
					</button>
				</form>
			</li>
		</ul>	
	</header>
	<script>
		  const loginUser = {
		    id: "${sessionScope.userInfo != null ? sessionScope.userInfo.id : ''}",
		    username: "${sessionScope.userInfo != null ? sessionScope.userInfo.username : ''}",
		    empNo: "${sessionScope.userInfo != null ? sessionScope.userInfo.empNo : ''}",
		    deptName: "${sessionScope.userInfo != null ? sessionScope.userInfo.deptName : ''}",
		    role: "${sessionScope.userInfo != null ? sessionScope.userInfo.role : ''}"
		  };
		  const isLoggedIn = ${sessionScope.loginUser != null ? "true" : "false"};
	</script>
</body>
</html>