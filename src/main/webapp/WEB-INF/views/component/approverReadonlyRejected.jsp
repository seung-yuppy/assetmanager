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
    <div class="status-banner">
        <svg fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
        </svg>
        <p>
            [반려됨] 최종 결재자 신아영 부장(사업본부)에 의해 요청이 반려되었습니다.
        </p>
    </div>
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
			<legend class="approver-title" align="center">결재</legend>
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
    <!-- 4. 상세 반려 사유 영역 (반려 상자 삽입) -->
    <div class="rejection-box-area">
        <h3 class="rejection-box-header">
            <svg fill="none" viewBox="0 0 24 24" stroke="currentColor">
            	<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>결재 반려 상세 사유
        </h3>
        <div class="rejection-box-content">
            <p class="meta">반려자: 신아영 부장 (사업본부)</p>
            <div class="rejection-detail">
                <p>"요청하신 고가 노트북 제품은 당사의 표준 비품 목록에 포함되지 않습니다. 동일 사양의 데스크탑으로 대체하거나, 해당 예산으로 구매해야 할 특별한 사유(예: 외근/출장이 잦은 직무)를 추가하여 재상신해 주십시오."</p>
            </div>
            <p class="rejection-date-info">반려 일시: 2024.10.16 11:30:15</p>
        </div>
    </div>
</body>
</html>