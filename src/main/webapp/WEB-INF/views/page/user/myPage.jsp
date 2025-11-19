<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 상세</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminAssetDetail.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/user.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp"%>
			<div class="dashboard-container">
				<h1>${userInfo.username} ${userInfo.position}님의 마이페이지</h1>
				<div class="detail-header"> 
					<span>${userInfo.username} ${userInfo.position}님의 정보와 자산 내역을 확인합니다.</span>
				</div>

				<div class="dashboard-container">
					<!-- 사용자 상세 정보 시작 -->
					<div class="section-card">
						<h2>사용자 정보</h2>
						<div class="edit-container">
							<div class="edit-image-box">
								<img src="data:image/png;base64,${userInfo.base64ProfileImage}" class="my-profile-image" >
							</div>
							<div class="profile-wrapper">
								<div class="profile-box">
									<div class="edit-user-info">
										<span class="user-label">사번</span> 
										<input type="text" value="${userInfo.empNo}" class="user-value" readonly>							
									</div>
									<div class="edit-user-info">
										<span class="user-label">부서</span> 
										<input type="text" value="${userInfo.deptName}" class="user-value" readonly>							
									</div>		
									<div class="edit-user-info">
										<span class="user-label">직급</span> 
										<input type="text" value="${userInfo.position}" class="user-value" readonly>							
									</div>
									<div class="edit-user-info">
										<span class="user-label">주소</span> 
										<input type="email" value="${userInfo.deptAddress}" class="user-value" readonly>							
									</div>									
									<div class="edit-user-info">
										<span class="user-label">이메일</span> 
										<input type="text" value="${userInfo.email}" name="email" class="user-value" readonly>							
									</div>		
									<div class="edit-user-info">
										<span class="user-label">전화번호</span> 
										<input type="text" value="${userInfo.phone}" name="phone" class="user-value" readonly>							
									</div>
								</div>
								<div class="edit-total-button">
									<a href="/assetmanager/mypage/edit" class="edit-button">프로필 수정</a>
								</div>
							</div>
						</div>
					</div>
					<!-- 사용자 상세 정보 끝 -->
					<c:if test="${userInfo.role != 'admin'}">
						<!-- 자산 정보 시작 -->
						<div class="section-card">
							<h2>자산 내역</h2>
							<table class="data-table">
								<thead>
									<tr>
										<th>자산명</th>
										<th>카테고리</th>
										<th>일련 번호</th>
										<th>사용 시작일</th>
										<th>사용 반납일</th>
										<th>상태</th>
									</tr>
								</thead>
								<tbody>							
									<c:choose>
				                		<c:when test="${empty list}">
						                	<tr>
						                		<td colspan="6" style="text-align: center;">
						               				<p>데이터가 없습니다.</p>
					                			</td>
					                		</tr>	                	
			                			</c:when>
			                			<c:otherwise>
											<c:forEach var="asset" items="${list}">
												<tr>
													<td>${asset.assetName}</td>
													<td>${asset.categoryName}</td>
													<td>${asset.serialNumber}</td>
													<td><fmt:formatDate value="${asset.rentDate}" pattern="yyyy-MM-dd"/></td>
													<c:if test="${asset.returnDate != null}">
														<td><fmt:formatDate value="${asset.returnDate}" pattern="yyyy-MM-dd"/></td>
													</c:if>
													<c:if test="${asset.returnDate == null}">
														<td>-</td>
													</c:if>										
													<c:if test="${asset.returnDate != null}">
														<td><span class="status-badge status-rejected">반납됨</span></td>
													</c:if>
													<c:if test="${asset.returnDate == null}">
														<td><span class="status-badge status-used">사용중</span></td>
													</c:if>
												</tr>
											</c:forEach>			                			
			                			</c:otherwise>
			                		</c:choose>
								</tbody>
							</table>
						</div>
						<!-- 자산 정보 끝 -->
					</c:if>
				</div>

			</div>
		</div>
	</div>
</body>
</html>