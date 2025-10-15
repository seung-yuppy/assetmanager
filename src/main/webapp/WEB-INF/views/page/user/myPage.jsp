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
				<h1>배고파님의 마이 페이지</h1>
				<span>내 정보를 확인하고 관리합니다.</span>
				<div class="section-card">
					<div class="mypage-wrapper">
						<div class="user-info">
							<div class="image-container">
								<img src="/assetmanager/resources/image/img_profile.png" class="my-profile-image" >
								<div class="image-info">
									<h2>배고파 사원</h2>
								</div>
							</div>
						
							<div class="info-container">
								<div class="info-list">
									<p class="list-title">사번</p>
									<p class="list-content">AMS1003</p>
								</div>
								<div class="info-list">
									<p class="list-title">이메일</p>
									<p class="list-content">t1@gmail.com</p>
								</div>
								<div class="info-list">
									<p class="list-title">부서</p>
									<p class="list-content">개발팀</p>
								</div>								
	
								<div class="info-list">
									<p class="list-title">주소</p>
									<p class="list-content">진천</p>
								</div>		
								<div class="info-list">
									<p class="list-title">전화번호</p>
									<p class="list-content">010-1234-5678</p>
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