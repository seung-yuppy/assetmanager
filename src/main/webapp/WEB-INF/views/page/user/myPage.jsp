<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 상세</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
<link href="/assetmanager/resources/css/adminAssetDetail.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<c:if test="${userInfo.role == '사원' || userInfo.role == '부장'}">
			<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		</c:if>
		<c:if test="${userInfo.role == '관리자'}">
			<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>
		</c:if>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp"%>
			<div class="dashboard-container">
				<h1>${userInfo.username}님의 마이페이지</h1>
				<div class="detail-header"> 
					<span>${userInfo.username}님의 정보를 확인하고 수정합니다.</span>
				</div>

				<div class="dashboard-container">
					<!-- 사용자 상세 정보 -->
					<div class="section-card">
						<h2>현재 사용자 정보</h2>
						<div class="user-info-list">
							<div class="info-f-list">
								<img src="data:image/png;base64,${userInfo.base64ProfileImage}" class="my-profile-image" >
								<form action="/assetmanager/change/myimage" method="POST" enctype="multipart/form-data" class="profile-edit-form">
									<input type="file" id="fileInput" name="profileImage" accept="image/*" class="file-input">
									<label for="fileInput" class="edit-label">
										<span class="btn-label">파일 선택</span>
									</label>
									<button type="submit" class="profile-edit-btn">이미지 수정</button>	
								</form>
							</div>
							
							<div class="info-s-list">					
								<div class="user-info-item">
									<span class="info-label">사번</span> <span class="info-value">${userInfo.empNo}</span>
								</div>
								<div class="user-info-item">
									<span class="info-label">부서명</span> <span class="info-value">${userInfo.deptName}</span>
								</div>
								<div class="user-info-item">
									<span class="info-label">직급</span> <span class="info-value">${userInfo.role}</span>
								</div>
							</div>
							<div class="info-t-list">
								<div class="user-info-item">
									<span class="info-label">전화번호</span> <span class="info-value">${userInfo.phone}</span>
								</div>
								<div class="user-info-item">
									<span class="info-label">이메일</span> <span class="info-value">${userInfo.email}</span>
								</div>
								<div class="info-dept-address">
									<span class="info-label">주소</span> <span class="info-value">${userInfo.deptAddress}</span>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 자산 정보 시작 -->
				<div class="section-card">
					<h2>사용자 자산 히스토리</h2>
					<table class="data-table">
						<thead>
							<tr>
								<th>자산명</th>
								<th>카테고리</th>
								<th>사용 시작</th>
								<th>사용 끝</th>
								<th>분류</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>LG그램</td>
								<td>노트북</td>
								<td>2025-10-10</td>
								<td>현재</td>
								<td><span class="status-badge status-approved">개인</span></td>
								<td><span class="status-badge status-used">사용중</span></td>
							</tr>
							<tr>
								<td>LG그램</td>
								<td>노트북</td>
								<td>2025-10-10</td>
								<td>현재</td>
								<td><span class="status-badge status-approved">개인</span></td>
								<td><span class="status-badge status-rejected">반납</span></td>
							</tr>
							<tr>
								<td>LG그램</td>
								<td>노트북</td>
								<td>2025-10-10</td>
								<td>현재</td>
								<td><span class="status-badge status-approved">개인</span></td>
								<td><span class="status-badge status-rejected">반납</span></td>
							</tr>
							<tr>
								<td>LG그램</td>
								<td>노트북</td>
								<td>2025-10-10</td>
								<td>현재</td>
								<td><span class="status-badge status-approved">개인</span></td>
								<td><span class="status-badge status-rejected">반납</span></td>
							</tr>
							<tr>
								<td>LG그램</td>
								<td>노트북</td>
								<td>2025-10-10</td>
								<td>현재</td>
								<td><span class="status-badge status-approved">개인</span></td>
								<td><span class="status-badge status-rejected">반납</span></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 자산 정보 끝 -->
			</div>
		</div>
	</div>
</body>
</html>