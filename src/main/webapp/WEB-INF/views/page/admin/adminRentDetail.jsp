<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
<fmt:formatDate value="${rent.rentDate}" pattern="yyyy-MM-dd" var="rentDate" />
<fmt:formatDate value="${rent.returnDate}" pattern="yyyy-MM-dd" var="returnDate" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반출 요청 상세</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css"
	rel="stylesheet">
<link href="/assetmanager/resources/css/adminDetail.css"
	rel="stylesheet">
<link href="/assetmanager/resources/css/approver.css" rel="stylesheet">
<link href="/assetmanager/resources/css/assetEntry.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<%-- SweetAlert2 라이브러리 추가 --%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script
		src="https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"></script>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp"%>
			<div class="dashboard-container">
				<h1 class="content-title">반출 요청 상세</h1>
				<div class="detail-header">
					<span class="page-description">반출 요청의 상세 내역을 확인하고 관리하세요.</span>
				</div>
				<div class="section-card">
					<!-- 결재라인 불러오기 -->
					<div class="form-section">
						<%@ include file="/WEB-INF/views/component/approverReadonly.jsp"%>
					</div>

					<!-- 신청자 정보 섹션 전체 컨테이너 -->
					<div class="applicant-info-section">
						<!-- 제목 -->
						<h2 class="applicant-section-title">신청자 정보</h2>

						<!-- 내용 목록  -->
						<div class="applicant-info-list">
							<dl class="applicant-info-f-list">
								<dt>요청ID(사번)</dt>
								<dd>${empInfo.userInfo.empNo}</dd>

								<dt>이름</dt>
								<dd>${empInfo.userInfo.username}</dd>

								<dt>부서명</dt>
								<dd>${empInfo.userInfo.deptName}</dd>
							</dl>
							<dl class="applicant-info-s-list">
								<dt>직책</dt>
								<dd>${empInfo.userInfo.position}</dd>

								<dt>연락처</dt>
								<dd>${empInfo.userInfo.phone}</dd>

								<dt>주소</dt>
								<dd>${empInfo.userInfo.deptAddress}</dd>
							</dl>
						</div>
					</div>

					<h2 class="form-section-title">요청 정보</h2>
					<div id="formInputArea" class="inputArea">
						<div class="form-date">
							<div class="form-application-date">
								<label for="application-date">반출 신청일</label> 
								<input type="date"
									   id="application-date" value="${rentDate}"
									   class="locked-input" readonly>
							</div>
							<div class="form-return-date">
								<label for="return-date">반납 예정일</label> 
								<input type="date"
									   id="return-date" value="${returnDate}" class="locked-input" readonly>
							</div>
						</div>
						<c:forEach var="contentItem" items="${item}">
						<div class="form-row">
							<div class="form-group category-group fixed-width-med">
								<label for="category">카테고리 </label> <input id="category"
									name="category" type="text" value="${contentItem.categoryName}" class="locked-input"
									readonly>
							</div>
							<div class="form-group product-select-group fixed-width-lg">
								<label for="productNameSelect">제품명</label> <input
									list="productOptions" name="productNameSelect"
									id="productNameSelect" type="text" value="${contentItem.assetName}"
									class="locked-input" readonly>
							</div>
							<div class="form-group">
								<label for="spec">스펙</label>
								<div class="last-input-group">
									<input type="text" id="spec" value="${contentItem.spec}"
										class="locked-input" readonly>
								</div>
							</div>
						</div>
						</c:forEach>

						<div class="form-group">
							<div class="form-reason">
								<label for="reason">반출 요청 사유 </label>
								<textarea id="reason" name="reason" rows="6" cols="81" maxlength="200"
									readonly>${rent.requestMsg}</textarea>
								<div class="char-count-display text-align-right"></div>
							</div>
						</div>
					</div>
					
					<div class="form-actions" 
						 id="approval-data-provider"
						 data-approval-id="${approval.id}"
						 data-approval-status="${approval.status}">
						
						<c:if test="${sessionScope.userInfo.role == 'admin'}">
							<c:if test="${approval.status == 'PENDING'}">
								<button type="button" class="primary-action approve-btn">승인</button>
								<button type="button" class="cancel-action reject-btn">반려</button>
							</c:if>
						</c:if>
						<c:if test="${sessionScope.userInfo.role == 'manager'}">
							<c:if test="${approval.status == 'FIRST_APPROVAL'}">
								<button type="button" class="primary-action approve-btn" >승인</button>
								<button type="button" class="cancel-action reject-btn">반려</button>
							</c:if>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="/assetmanager/resources/js/rentForm.js"></script>
	<script src="/assetmanager/resources/js/requestForm.js"></script>
	<script src="/assetmanager/resources/js/rent.js"></script>
	<script src="/assetmanager/resources/js/adminRentDetail.js"></script>
	<script src="/assetmanager/resources/js/notice.js"></script>	
</body>
</html>