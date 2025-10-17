<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>마이페이지</title>
    <link href="resources/css/common.css" rel="stylesheet">
    <link href="resources/css/rentList.css" rel="stylesheet">
    <link href="resources/css/user.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>${userInfo.username}님의 마이 페이지</h1>
				<span>내 정보를 확인하고 관리합니다.</span>
				<div class="section-card">
					<div class="mypage-wrapper">
						<div class="user-info">
							<div class="image-container">
								<img src="data:image/png;base64,${userInfo.base64ProfileImage}" class="my-profile-image" >
								<div class="image-info">
									<h2>${userInfo.username} ${userInfo.role}</h2>
								</div>
							</div>
						
							<div class="info-container">
								<div class="info-list">
									<p class="list-title">사번</p>
									<p class="list-content">${userInfo.empNo}</p>
								</div>
								<div class="info-list">
									<p class="list-title">이메일</p>
									<p class="list-content">${userInfo.email}</p>
								</div>
								<div class="info-list">
									<p class="list-title">부서</p>
									<p class="list-content">${userInfo.deptName}</p>
								</div>								
	
								<div class="info-list">
									<p class="list-title">주소</p>
									<p class="list-content">${userInfo.deptAddress}</p>
								</div>		
								<div class="info-list">
									<p class="list-title">전화번호</p>
									<p class="list-content">${userInfo.phone}</p>
								</div>
							</div>				
						</div>
						
						<div class="button-container">
							<button type="button" class="add-button">비밀번호 변경</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>