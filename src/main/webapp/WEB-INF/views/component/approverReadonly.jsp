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
		        <!-- 전체 결재 상태 표시 -->
		<!-- 첫 번째 : 신청자 -->
		<fieldset class="approver-container">
			<legend class="approver-title" align="center">요청</legend>
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
		<fieldset class="approver-container select-info">
			<legend class="approver-title" align="center">합의</legend>
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
					<div class="name-title"> 이영호 <span class="title">팀장</span></div>
					<div class="team">(경영팀)</div>
				</div>
			</div>
		</fieldset>

		<!-- 화살표 -->
		<div class="arrow-separator">
			<i class="fas fa-chevron-right"></i>
		</div>

		<!-- 최종 결재자 -->
		<fieldset class="approver-container select-info">
			<legend class="approver-title" align="center">결재</legend>
			<div class="approver-image-container">
				<img class="approver-image" src="https://placehold.co/100x100/d5f6e4/31343C?text=SAY" alt="신아영">
				<div class="approval-badge">
					<div class="reject-badge-icon">
						<i class="fas fa-times"></i>
					</div>
				</div>
			</div>
			<div class="approver-item">
				<div class="approver-info">
					<div class="name-title"> 신아영 <span class="title">부장</span></div>
					<div class="team">(사업본부)</div>
				</div>
			</div>
		</fieldset>
	</div>
</body>
</html>