<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>권장 제품 추가</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/modal.css" rel="stylesheet">
<link href="/assetmanager/resources/css/orderForm.css" rel="stylesheet">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>

		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<div class="content-wrapper">
						<h1 class="content-title">권장 제품 추가</h1>
						<p class="content-description">권장 제품 추가를 위해서 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</p>
						<form id="purchaseRequestForm" action="#" method="post">
							<h2 class="form-section-title">제품 정보</h2>
							<div class="form-row" style="margin-bottom:20px;">
								<div class="form-group radio-input-group">
									<div class="radio-input">
										<input type="radio" id="inputMethodForm" name="inputMethod" value="form" checked onclick="showInputForm('form')">
										<label for="inputMethodForm">폼 직접 입력 </label>
									</div>
									<div class="radio-input">
										<input type="radio" id="inputMethodExcel" name="inputMethod" value="excel" onclick="showInputForm('excel')"> 
										<label for="inputMethodExcel">엑셀 파일 업로드</label>
									</div>
								</div>
							</div>

							<div id="formInputArea">
								<div class="form-row " style="margin-bottom: 30px;">
									<div class="form-group category-group fixed-width-sm">
										<label for="category">카테고리 <span class="required">*</span></label>
										<select id="category" name="category" required onchange="updateProductOptions()" class="order-input">
											<option value="" disabled selected>선택하세요</option>
											<option value="notebook">노트북</option>
											<option value="monitor">모니터</option>
											<option value="software">소프트웨어</option>
											<option value="other">기타</option>
										</select>
									</div>

									<div class="form-group product-input-group flex-grow-lg" id="productInputGroup" >
										<label for="productNameInput">제품명<span class="required">*</span></label> 
										<input type="text" id="productNameInput" class="order-input" name="productNameInput" placeholder="제품명을 입력하세요">
									</div>
								</div>
								
								<div class="form-row">
									<div class="form-group fixed-width-sm">
										<label for="itemPrice"> 단가 <span class="required">*</span></label>
										<input type="number" id="itemPrice" name="itemPrice" value="" class="order-input" required>
									</div>
									<div class="form-group">
										<label for="seller">거래처<span class="required">*</span></label>
										<input type="text" id="seller" name="seller" value="" class="order-input" required>
									</div>
								</div>
							</div>

							<div id="excelUploadArea" style="display: none;">
								<div class="form-group file-upload-group">
									<span>다음 양식 파일을 다운로드하여 요청 세부 사항을 기입하고 업로드하세요.</span>
									<button type="button" class="btn-template-download" style="margin-bottom: 20px;	" onclick="downloadExcelTemplate()">⬇️ 템플릿 다운로드</button>
									<label for="excelFile">엑셀 파일 선택 <span class="required">*</span></label>
									<input type="file" id="excelFile" name="excelFile" accept=".xlsx, .xls">
								</div>
							</div>
							<div class="form-actions">
								<button type="submit" class="primary-action">등록</button>
							</div>
						</form>
					</div>
				</div>
			</div>
	</div>
	<script src="/assetmanager/resources/js/modal.js"></script>
	<script src="/assetmanager/resources/js/adminItemForm.js"></script>
</body>
</html>