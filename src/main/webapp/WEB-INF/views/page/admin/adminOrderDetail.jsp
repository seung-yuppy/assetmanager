<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 요청 상세</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css"
	rel="stylesheet">
<link href="/assetmanager/resources/css/adminDetail.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<script
		src="https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"></script>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp"%>
			<div class="dashboard-container">
				<h1 class="content-title">구매 요청 상세</h1>
				<div class="detail-header">
					<span class="page-description">구매 요청의 상세 내용을 확인하세요</span>
				</div>
				<div class="section-card">
					<div class="form-section">
						<!-- 결재라인 전체 컨테이너 -->
						<%@ include file="/WEB-INF/views/component/approverReadonly.jsp"%>
					</div>
					<!-- 신청자 정보 섹션 전체 컨테이너 -->
					<div class="applicant-info-section">
						<!-- 제목 -->
						<h2 class="applicant-section-title">요청자 정보</h2>
						<!-- 내용 목록 -->
						<div class="applicant-info-list">
							<dl class="applicant-info-f-list">
								<dt>사번</dt>
								<dd>${empInfo.userInfo.empNo}</dd>

								<dt>이름</dt>
								<dd>${empInfo.userInfo.username}</dd>
								
								<dt>직급</dt>
								<dd>${empInfo.userInfo.position}</dd>

							</dl>
							<dl class="applicant-info-s-list">
								<dt>부서</dt>
								<dd>${empInfo.userInfo.deptName}</dd>							

								<dt>연락처</dt>
								<dd>${empInfo.userInfo.phone}</dd>

								<dt>주소</dt>
								<dd>${empInfo.userInfo.deptAddress}</dd>
							</dl>
						</div>
					</div>
					<form action="#" method="post">
						<h2 class="form-section-title">요청 내용</h2>
						<div id="formInputArea" class ="inputArea">
							<div class="form-date">
								<div class="form-application-date">
									<label for="application-date">구매 요청일</label> 
									<input type="date" id="application-date" value='<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/>' class="form-input rent-input locked-input" readonly>
								</div>
							</div>
							<c:forEach var="product" items="${products}">
								<div class="form-row">
									<div class="form-group category-group fixed-width-med">
										<label for="category">카테고리 </label>
										<input id="category" name="category" type="text" value="${product.categoryName}" class="locked-input" readonly>
									</div>
									<div class="form-group product-select-group fixed-width-lg">
										<label for="productNameSelect">제품명</label>
										<input list="productOptions" name="productNameSelect" id="productNameSelect" type="text" value="${product.itemName}" class="locked-input" readonly>
									</div>
									<div class="form-group fixed-width-med">
										<label for="price">단가(₩)</label>
										<input type="text" id="price" name="price" value='<fmt:formatNumber value="${product.price}" type="number"/>' data-value="${product.price}" class="locked-input" readonly>
									</div>
									<div class="form-group fixed-width-sm">
										<label for="quantity">수량 <span class="required">*</span></label>
										<input type="number" id="quantity" name="products[0].count" min="1" max="10" value="${product.count}" required>
									</div>
									<div class="form-group fixed-width-med">
										<label for="totalPrice">총액(₩)</label>
										<input type="text" id="totalPrice" name="totalPrice" value="0" class="locked-input" readonly>
										<img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)" style="visibility:hidden;"></img>
									</div>
								</div>
							</c:forEach>
							<div class="form-group">
								<label for="reason">구매 요청 사유</label>
								<textarea id="reason" name="reason" rows="4" readonly>${order.requestMsg}</textarea>
							</div>
						</div>

						<div id="excelUploadArea" class="inputArea">
							<div class="form-group file-upload-group">
								<span>다음 양식 파일을 다운로드하여 요청 세부 사항을 기입하고 업로드하세요.</span>
								<button type="button" class="btn-template-download"
									style="margin-bottom: 20px;" onclick="downloadExcelTemplate()">⬇️
									템플릿 다운로드</button>
								<label for="excelFile">엑셀 파일 선택 <span class="required">*</span></label>
								<input type="file" id="excelFile" name="excelFile"
									accept=".xlsx, .xls">
							</div>
							<div id="data-display-area"></div>
						</div>
						<div class="form-actions">
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
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="/assetmanager/resources/js/adminOrderDetail.js"></script>
</body>
</html>