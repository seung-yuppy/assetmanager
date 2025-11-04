<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">

<link href="/assetmanager/resources/css/approver.css" rel="stylesheet">
<link href="/assetmanager/resources/css/assetEntry.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script src="https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"></script>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp"%>
			<div class="dashboard-container">
				<h1 class="content-title">반출 요청 상세</h1>
				<div class="detail-header">
					<span class="page-description">반출 요청의 상세 내역을 확인하고 관리하세요.</span>
				</div>

				<div class="section-card" data-id="${rentdto.id}" data-author="${rentdto.userId}">

					<div class="form-section">
						<!-- 결재라인 불러오기 -->
						<%@ include file="/WEB-INF/views/component/approverReadonly.jsp"%>
					</div>

					<h2 class="form-section-title">요청 정보</h2>
					<div id="formInputArea" class="inputArea">
						<div class="form-date">
							<div class="form-application-date">
								<label for="application-date">반출 신청일</label> <input type="date" id="application-date" value="${rentDate}" class="form-input rent-input" readonly>
							</div>
							<div class="form-return-date">
								<label for="return-date">반납 예정일</label> <input type="date" name="returnDate" id="return-date" value="${returnDate}" class="form-input rent-input" readonly>
							</div>
						</div>
						<c:forEach var="item" items="${items}">
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 </label> <input id="category" name="categoryName" type="text" value="${item.categoryName}" class="locked-input" readonly>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명</label> <input list="productOptions" name="productNameSelect" id="productNameSelect" type="text" value="${item.assetName}" class="locked-input" readonly>
								</div>
								<div class="form-group">
									<label for="spec">스펙</label>
									<div class="last-input-group">
										<input type="text" id="spec" value="${item.spec}" class="locked-input" readonly>
										<c:if test="${approval.status == 'FINAL_APPROVAL'&& item.register==true}">
											<button type="button" class="regist-button" data-target="registerModal" data-asset-name="${item.assetName}" data-return-date="${returnDate}" data-asset-id="${item.assetId}" data-rent-id="${item.rentId}">등록</button>
										</c:if>
										<c:if test="${approval.status == 'FINAL_APPROVAL'&& item.register==false}">
											<button type="button" class="regist-button-save" disabled>완료</button>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>

						<div class="form-group">
							<div class="form-reason">
								<label for="reason">반출 요청 사유</label>
								<textarea id="reason" name="requestMsg" rows="5" cols="81" maxlength="200" readonly>${rent.requestMsg}</textarea>
								<div class="char-count-display text-align-right"></div>
							</div>
						</div>
					</div>
					<div class="form-actions">
						<c:if test="${approval.status == 'PENDING'}">
							<button id="cancel-btn" type="button" class="cancel-action">요청 취소</button>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%-- 자산 등록 모달창 --%>
	<div id="registerModal" class="modal-backdrop" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<h2>물품 반출 등록</h2>
				<button id="closeModalBtn" class="modal-close-btn">&times;</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="modalAssetId"> <input type="hidden" id="modalRentId">

				<div class="form-group">
					<label for="modalProductName">제품명</label> <input type="text" id="modalProductName" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="application-date">등록일</label> <input id="application-date" value="${currentDate}" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalReturnDate">반납 예정일</label> <input id="modalReturnDate" value="${returnDate}" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalSerialNumber">일련번호</label> <input type="text" id="modalSerialNumber" class="form-input">
				</div>

			</div>
			<div class="modal-footer">
				<button id="cancelBtn" class="btn-secondary">취소</button>
				<button class="btn-primary" id="submitBtn">반출 등록</button>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="/assetmanager/resources/js/rentForm.js"></script>
	<script src="/assetmanager/resources/js/rent.js"></script>
	<script src="/assetmanager/resources/js/toDetail.js"></script> 
</body>
</html>