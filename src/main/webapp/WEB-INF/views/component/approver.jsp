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
			<legend class="approver-title" align="center">요청자</legend>
			<div class="approver-image-container">
				<img class="approver-image" src="https://placehold.co/100x100/f6d5de/31343C?text=KYN" alt="강예나">
				<div class="approval-badge">
					<div class="approval-badge-icon">
						<i class="fas fa-check"></i>
					</div>
				</div>
			</div>

			<div class="approver-item">

				<div class="approver-info">
					<div class="name-title">
						강예나 <span class="title">사원</span>
					</div>
					<div class="team">(개발팀)</div>
				</div>
			</div>
		</fieldset>

		<!-- 화살표 -->
		<div class="arrow-separator">
			<i class="fas fa-chevron-right"></i>
		</div>

		<!-- 중간 결재자(협의) -->
		<fieldset class="approver-container select-info pd-30">
			<legend class="approver-title" align="center">일반결재</legend>
			<div class="approver-image-container">
				<img class="approver-image" src="https://placehold.co/100x100/d5e4f6/31343C?text=LYH" alt="이영호">
				<div class="approval-badge">
					<div class="approval-badge-icon">
						<i class="fas fa-check"></i>
					</div>
				</div>
			</div>
			<div class="approver-item">
				<div class="approver-info">
					<div class="name-title">
						<select id="category" class="form-input rent-input">
							<c:forEach var="ad" items="${admin}">
								<option value="${ad.username}">${ad.username}</option>
							</c:forEach>
						</select>
					</div>
					<div class="firstTeam"></div>
				</div>
			</div>
		</fieldset>

		<!-- 화살표 -->
		<div class="arrow-separator">
			<i class="fas fa-chevron-right"></i>
		</div>

		<!-- 최종 결재자 -->
		<fieldset class="approver-container select-info pd-30">
			<legend class="approver-title" align="center">최종결재</legend>
			<div class="approver-image-container">
				<img class="approver-image" src="https://placehold.co/100x100/d5f6e4/31343C?text=SAY" alt="신아영">
				<div class="approval-badge">
					<div class="approval-badge-icon">
						<i class="fas fa-check"></i>
					</div>
				</div>
			</div>
			<div class="approver-item">
				<div class="approver-info">
					<div class="name-title">
						<select id="category" class="form-input rent-input">
							<option>신아영 부장</option>
							<option>송승엽 과장</option>
							<option>김성배 과장</option>
							<option>홍길동 대리</option>
							<option>김둘리 대리</option>
						</select>
					</div>
					<div class="team">(사업본부)</div>
				</div>
			</div>
		</fieldset>
	</div>
	
</body>
</html>