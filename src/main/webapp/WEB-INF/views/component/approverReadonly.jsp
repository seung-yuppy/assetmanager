<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
    <c:if test="${approval.status.koreanName == '승인됨'}">
	    <div class="status-banner-approved">
	        <svg fill="none" viewBox="0 0 24 24" stroke="currentColor">
	                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
	       	</svg>
	        <p>
	            [승인됨] 요청이 승인되었습니다. 물품 수령 후 자산 등록해주세요. 
	        </p>
	    </div>
    </c:if>
    <c:if test="${approval.status.koreanName == '반려됨'}">
	    <div class="status-banner">
	        <svg fill="none" viewBox="0 0 24 24" stroke="currentColor">
	            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
	        </svg>
	        <c:set var="rejecter" value="${approval.status == 'FIRST_REJECT' ? empInfo.approverInfo.username:empInfo.managerInfo.username}"/>
	        <c:set var="rejecterDept" value="${approval.status == 'FIRST_REJECT' ? empInfo.approverInfo.deptName: empInfo.managerInfo.deptName}"/>
	        <p>[반려됨] ${rejecter} 사원(${rejecterDept})에 의해 요청이 반려되었습니다.</p>
	    </div>
    </c:if>
	<h2 class="form-section-title">결재 정보</h2>
	<!-- 결재라인 전체 컨테이너 -->
	<div id="approval-line-container">
		<!-- 첫 번째 : 신청자 -->
		<fieldset class="approver-wrapper">
			<legend class="approver-title" align="center">요청</legend>
			<div class="approver-container">
				<div class="approver-image-container">
					<img class="approver-image" src="data:image/png;base64,${empInfo.userInfo.base64ProfileImage}" alt="요청자">
					<div class="approval-badge">
						<div class="approval-badge-icon">
							<i class="fas fa-check"></i>
						</div>
					</div>
				</div>
	
				<div class="approver-item">
					<div class="approver-info">
						<div class="name-title">
							 ${empInfo.userInfo.username}  <span class="title">사원</span>
						</div>
						<div class="team">${empInfo.userInfo.deptName} </div>
					</div>
				</div>			
			</div>
			<%-- <p class="approver-date"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></p> --%>
		</fieldset>

		<!-- 화살표 -->
		<div class="arrow-separator">
			<i class="fas fa-chevron-right"></i>
		</div>

		<!-- 중간 결재자(협의) -->
		<fieldset class="approver-wrapper">
			<legend class="approver-title" align="center">합의</legend>
			<div class="approver-container">
				<div class="approver-image-container">
					<img class="approver-image" src="data:image/png;base64,${empInfo.approverInfo.base64ProfileImage}" alt="합의자">
					<c:if test="${approval.status != 'PENDING'}">
						<div class="approval-badge">
							<c:if test="${fn:contains('FIRST_APPROVAL, FINAL_APPROVAL, FINAL_REJECT', approval.status)}">
								<c:set var="doneDate1" value="${approval.firstApprovalDate}"></c:set>
								<div class="approval-badge-icon">
									<i class="fas fa-check"></i>
								</div>
							</c:if>
							<c:if test="${approval.status == 'FIRST_REJECT'}">
								<c:set var="doneDate1" value="${approval.rejectDate}"></c:set>
								<div class="reject-badge-icon">
									<i class="fas fa-times"></i>
								</div>
							</c:if>
						</div>
					</c:if>
				</div>
				<div class="approver-item">
					<div class="approver-info">
						<div class="name-title"> ${empInfo.approverInfo.username} <span class="title">팀장</span></div>
						<div class="team">${empInfo.approverInfo.deptName}</div>
					</div>
				</div>
			</div>
			<p class="approver-date"><fmt:formatDate value="${doneDate1}" pattern="yyyy-MM-dd"/></p>
		</fieldset>

		<!-- 화살표 -->
		<div class="arrow-separator">
			<i class="fas fa-chevron-right"></i>
		</div>

		<!-- 최종 결재자 -->
		<fieldset class="approver-wrapper">
			<legend class="approver-title" align="center">결재</legend>
			<div class="approver-container">
				<div class="approver-image-container">
					<img class="approver-image" src="https://placehold.co/100x100/d5f6e4/31343C?text=SAY" alt="결재자">
					<c:if test="${fn:contains('FINAL_APPROVAL, FINAL_REJECT', approval.status)}">
						<div class="approval-badge">
							<c:if test="${approval.status == 'FINAL_APPROVAL'}">
								<c:set var="doneDate2" value="${approval.lastApprovalDate}"></c:set>
								<div class="approval-badge-icon">
									<i class="fas fa-check"></i>
								</div>
							</c:if>
							<c:if test="${approval.status == 'FINAL_REJECT'}">
								<c:set var="doneDate2" value="${approval.rejectDate}"></c:set>
								<div class="reject-badge-icon">
									<i class="fas fa-times"></i>
								</div>
							</c:if>
						</div>
					</c:if>
				</div>
				<div class="approver-item">
					<div class="approver-info">
						<div class="name-title"> ${empInfo.managerInfo.username} <span class="title">부장</span></div>
						<div class="team">${empInfo.managerInfo.deptName}</div>
					</div>
				</div>
			</div>
			<p class="approver-date"><fmt:formatDate value="${doneDate2}" pattern="yyyy-MM-dd"/></p>
		</fieldset>
	</div>
	<c:if test="${approval.status.koreanName == '반려됨'}">
		<div class="rejection-box-area">
	        <h3 class="rejection-box-header">
	            <svg fill="none" viewBox="0 0 24 24" stroke="currentColor">
	            	<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
	            </svg>결재 반려 상세 사유
	        </h3>
	        <div class="rejection-box-content">
	        	<div class="title">
		            <p class="meta">결재자: ${rejecter} 부장(${rejecterDept}) </p>
		            <p class="rejection-date-info">반려 일시:  <td><fmt:formatDate value="${approval.rejectDate}" pattern="yyyy-MM-dd hh:mm" /></td></p>
	        	</div>
	            <div class="rejection-detail">
	                <p>${approval.rejectReason}</p>
	            </div>
	        </div>
	   	</div>
	</c:if>
	
</body>
</html>