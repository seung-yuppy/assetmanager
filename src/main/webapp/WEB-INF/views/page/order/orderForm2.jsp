<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 구매요청 목록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/modal.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<div class="main-content">
			<div class="dashboard-container">
				<h1 class="content-title">구매 신청서</h1>
				<span>구매 요청을 위해서 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</span>
				<div class="section-card">
					<form action="#" method="post">
						<div class="form-section">
							<h2 class="form-section-title">결재 정보</h2>
						</div>
						<h2 class="form-section-title">요청 내용</h2>
						<div class="radio-input-group">
							<div class="radio-input">
								<input type="radio" id="inputMethodForm" name="inputMethod" value="form" checked onclick="showInputForm('form')">
								<label for="inputMethodForm">폼 직접 입력 </label>
							</div>
							<div class="radio-input">
								<input type="radio" id="inputMethodExcel" name="inputMethod" value="excel" onclick="showInputForm('excel')"> 
								<label for="inputMethodExcel">엑셀 파일 업로드</label>
							</div>
						</div>

						<div id="formInputArea">
							<div class="form-row">
								<div class="form-group category-group fixed-width-sm">
									<label for="category">카테고리 <span class="required">*</span></label>
									<select id="category" name="category" required onchange="updateProductOptions()">
										<option value="" disabled selected>선택하세요</option>
										<option value="notebook">노트북</option>
										<option value="monitor">모니터</option>
										<option value="software">소프트웨어</option>
										<option value="other">기타</option>
									</select>
								</div>

								<div class="form-group product-select-group flex-grow-lg">
									<label for="productNameSelect">제품명<span class="required">*</span></label>
									<input list="productOptions" name="productNameSelect" id="productNameSelect" placeholder="선택  또는 직접 입력">
									<datalist id="productOptions">
									    <option value="LG그램">
									    <option value="macbook 10">
									    <option value="직접 입력">
									</datalist>
								</div>

								<div class="form-group fixed-width-sm">
									<label for="price">단가 (원) <span class="required">*</span></label>
									<input type="number" id="price" name="price" value="0" min="0" required>
								</div>

								<div class="form-group fixed-width-sm">
									<label for="quantity">수량 <span class="required">*</span></label>
									<input type="number" id="quantity" name="quantity" min="1"
										value="1" required>
								</div>

								<div class="form-group fixed-width-sm">
									<label for="totalPrice">총액 (원)</label>
									<input type="text" id="totalPrice" name="totalPrice" value="0" class="price-lock" readonly>
								</div>
							</div>
							
							<div class="form-group">
								<label for="reason">구매 요청 사유 <span class="required">*</span></label>
								<textarea id="reason" name="reason" rows="4" required placeholder="구매 요청이 필요한 구체적인 구체적인 사유를 입력해주세요." maxlength="200" onkeyup="updateCharCount(this, 200)"></textarea>
								<div class="char-count-display text-align-right">
									(<span id="currentLength">0</span> / 200)
								</div>
							</div>
							<div class="form-group checkbox-group">
								<input type="checkbox" id="isDepartmentUse"
									name="isDepartmentUse"> <label for="isDepartmentUse">부서 공동 사용 자산입니다.</label>
								<p class="description">체크 시, 해당 자산은 특정 개인 소유가 아닌 부서 공동 자산으로 등록됩니다.</p>
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
							<button type="submit" class="primary-action">제출</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="/assetmanager/resources/js/modal.js"></script>
	<script src="/assetmanager/resources/js/orderForm.js"></script>
</body>
</html>