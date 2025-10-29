<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 요청 상세</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/assetEntry.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">
<link href="/assetmanager/resources/css/formStyle.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<script src="https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"></script>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1 class="content-title">구매 요청 상세</h1>
				<div class="detail-header">
					<span class="page-description">구매 요청의 상세 내용을 확인하세요</span>
				</div>
				<div class="section-card">
					<form action="#" method="post">
						<div class="form-section">
							<!-- 결재라인 전체 컨테이너 -->
							<%@ include file="/WEB-INF/views/component/approverReadonly.jsp" %>
						</div>
						
						<h2 class="form-section-title">요청 정보</h2>
						<div id="formInputArea" class ="inputArea">
							<div class="form-date" style="margin-bottom: 20px;">
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
										<label for="price">단가 (원)</label>
										<div class="last-input-group">
											<input type="text" id="price" name="price" value='<fmt:formatNumber value="${product.price}" type="number"/>' class="locked-input" readonly>
											<button type="button" class="regist-button" data-target="registerModal">등록</button>
										</div>
									</div>
								</div>
							</c:forEach>
							<div class="form-group">
								<label for="reason">구매 요청 사유</label>
								<textarea id="reason" name="reason" rows="4" readonly>${order.requestMsg}</textarea>
							</div>
						</div>
						<div id="excelUploadArea" class ="inputArea">
							<div class="form-group file-upload-group">
								<span>다음 양식 파일을 다운로드하여 요청 세부 사항을 기입하고 업로드하세요.</span>
								<button type="button" class="btn-template-download" style="margin-bottom: 20px;	" onclick="downloadExcelTemplate()">⬇️ 템플릿 다운로드</button>
								<label for="excelFile">엑셀 파일 선택 <span class="required">*</span></label>
								<input type="file" id="excelFile" name="excelFile" accept=".xlsx, .xls">
							</div>
							<div id="data-display-area"></div>
						</div>
						<div class="form-actions">
							<button type="button" class="cancel-action">요청 취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달 -->
	<div id="registerModal" class="modal-backdrop" style="display: none;">
	    <div class="modal-content">
	        <div class="modal-header">
	            <h3>일련번호 등록</h3>
	            <button id="closeModalBtn" class="modal-close-btn">&times;</button> 
	        </div>
	        <div class="modal-body">
     			<div class="form-group">
					<label for="modalProductName">제품명</label>
					<input type="text" id="modalProductName" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="application-date">등록 일자</label> 
					<input id="application-date" value="${currentDate}" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalSerialNumber">일련번호</label>
					<input type="text" id="modalSerialNumber" class="form-input" placeholder="일련번호를 입력하세요">
				</div>
	        </div>
	        <div class="modal-footer">
	            <button id="cancelBtn" class="btn-secondary">취소</button>
	            <button class="btn-primary" onclick="registerSerial()">등록하기</button>
	        </div>
	    </div>
	</div>
	<script src="/assetmanager/resources/js/orderDetail.js"></script>
	<script src="/assetmanager/resources/js/requestForm.js"></script>
</body>
</html>