<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재라인</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/approver.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<h2 class="form-section-title">결재 정보</h2>
	<!-- 결재라인 전체 컨테이너 -->
	<div id="approval-line-container">

		<!-- 첫 번째 : 신청자 -->
		<fieldset class="approver-container pd-30">
			<legend class="approver-title" align="center">요청</legend>
			<div class="approver-image-container">
				<img src="data:image/png;base64,${userInfo.base64ProfileImage}" class="approver-image" >
				<div class="approval-badge">				
				</div>
			</div>

			<div class="approver-item">
				<div class="approver-info">
					<div class="name-title">
						${userInfo.username} <span class="title">${userInfo.role}</span>
					</div>
					<div class="team">(${userInfo.deptName})</div>
				</div>
			</div>
		</fieldset>

		<!-- 화살표 -->
		<div class="arrow-separator">
			<i class="fas fa-chevron-right"></i>
		</div>

		<!-- 중간 결재자(협의) -->
		<fieldset class="approver-container select-info pd-30">
			<legend class="approver-title" align="center">합의</legend>
			<div class="approver-image-container">
				<img class="approver-image" src="https://placehold.co/100x100/d5e4f6/31343C?text=LYH" alt="이영호">
				<div class="approval-badge">				
				</div>
			</div>
			<div class="approver-item">
				<div class="approver-info">
					<div class="name-title">
						<select class="approver-select form-input rent-input" name="approverId">
							<c:forEach var="ad" items="${admin}">
								<option value="${ad.id}"
										data-image-base64="${ad.base64ProfileImage}"
										data-image-type="image/png"										
										data-dept="(${ad.deptName})"
										data-alt="${ad.username}"> 
									${ad.username}
									<c:choose>
		                                <c:when test="${ad.role == 'admin'}">${ad.position}</c:when>       		                               
		                            </c:choose>											
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="approver-dept team"></div>
				</div>
			</div>
		</fieldset>

		<!-- 화살표 -->
		<div class="arrow-separator">
			<i class="fas fa-chevron-right"></i>
		</div>

		<!-- 최종 결재자 -->
		<fieldset class="approver-container select-info pd-30">
			<legend class="approver-title" align="center">결재</legend>
			<div class="approver-image-container">
				<img class="approver-image" src="https://placehold.co/100x100/d5f6e4/31343C?text=SAY" alt="신아영">
				<div class="approval-badge">					
				</div>
			</div>
			<div class="approver-item">
				<div class="approver-info">
					<div class="name-title">
						<select class="approver-select form-input rent-input" name="managerId">
							<c:forEach var="ma" items="${manager}">
								<option value="${ma.id}"
										data-image-base64="${ma.base64ProfileImage}"
										data-image-type="image/png"										
										data-dept="(${ma.deptName})"
										data-alt="${ma.username}">
									${ma.username}									
									<c:choose>
		                                <c:when test="${ma.role == 'manager'}">${ma.position}</c:when>       		                               
		                            </c:choose>										
								</option>
							</c:forEach>
						</select>
					</div>
					<div class="approver-dept team"></div>
				</div>
			</div>
		</fieldset>
	</div>
	<script src="/assetmanager/resources/js/approval.js"></script>
</body>
</html>