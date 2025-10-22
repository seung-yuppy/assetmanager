<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
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
				
				<div class="section-card">

					<div class="form-section">
						<!-- 결재라인 불러오기 -->
						<%@ include file="/WEB-INF/views/component/approverReadonly.jsp"%>
					</div>

					<h2 class="form-section-title">요청 내용</h2>
					<div id="formInputArea" class="inputArea">
						<div class="form-row">
							<div class="form-group fixed-width-sm">
								<label for="isDepartmentUse">부서 자산</label> <input type="checkbox" id="isDepartmentUse" name="isDepartmentUse" checked onclick="return false">
							</div>
							<div class="form-group category-group fixed-width-med">
								<label for="category">카테고리 </label> <input id="category" name="category" type="text" value="기타" class="locked-input" readonly>
							</div>
							<div class="form-group product-select-group fixed-width-lg">
								<label for="productNameSelect">제품명</label> <input list="productOptions" name="productNameSelect" id="productNameSelect" type="text" value="복합기" class="locked-input" readonly>
							</div>
							<div class="form-group">
								<label for="spec">스펙</label>
								<div class="last-input-group">
									<input type="text" id="spec" value="cpu~~~~~" class="locked-input" readonly>
									<button type="button" class="regist-button" data-target="registerModal">등록</button>
								</div>
							</div>
						</div>

						<div class="form-row">
							<div class="form-group fixed-width-sm">
								<label for="isDepartmentUse">부서 자산</label> <input type="checkbox" id="isDepartmentUse" name="isDepartmentUse" checked onclick="return false">
							</div>
							<div class="form-group category-group fixed-width-med">
								<label for="category">카테고리 </label> <input id="category" name="category" type="text" value="기타" class="locked-input" readonly>
							</div>
							<div class="form-group product-select-group fixed-width-lg">
								<label for="productNameSelect">제품명</label> <input list="productOptions" name="productNameSelect" id="productNameSelect" type="text" value="복합기" class="locked-input" readonly>
							</div>
							<div class="form-group">
								<label for="spec">스펙</label>
								<div class="last-input-group">
									<input type="text" id="spec" value="cpu~~~~~" class="locked-input" readonly>
									<button type="button" class="regist-button" data-target="registerModal">등록</button>
								</div>
							</div>
						</div>


						<div class="form-footer">
							<div class="form-reason">
								<label for="reason">반출 요청 사유</label>
								<textarea id="reason" name="reason" rows="6" required placeholder="프로젝트 시작하여 새로운 기기 필요." cols="81" maxlength="200" onkeyup="updateCharCount(this, 200)" readonly></textarea>
								<div class="char-count-display text-align-right"></div>
							</div>

							<div class="form-date">
								<div class="form-application-date">
									<label for="application-date">반출 신청일</label> <input type="date" id="application-date" value="${currentDate}" class="locked-input" readonly>
								</div>
								<div class="form-return-date">
									<label for="return-date">반납 예정일</label> <input type="date" id="return-date" placeholder="반납 예정일 선택" class="locked-input" readonly>
								</div>

							</div>

						</div>
					</div>
					<div class="form-actions">
						<button type="button" class="cancel-action">요청 취소</button>
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
				<div class="form-group">
					<label for="modalProductName">제품명</label> <input type="text" id="modalProductName" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="application-date">등록일</label> <input id="application-date" value="${currentDate}" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalReturnDate">반납 예정일</label> <input id="modalReturnDate" value="2025-12-31" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalSerialNumber">일련번호</label> <input type="text" id="modalSerialNumber" class="form-input">
				</div>


			</div>
			<div class="modal-footer">
				<button id="cancelBtn" class="btn-secondary">취소</button>
				<button class="btn-primary">반출 등록</button>
			</div>
		</div>
	</div>

	<script src="/assetmanager/resources/js/rentForm.js"></script>
	<script src="/assetmanager/resources/js/requestForm.js"></script>
	<script src="/assetmanager/resources/js/rent.js"></script>
</body>
</html>