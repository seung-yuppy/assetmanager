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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script src="https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"></script>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1 class="content-title">구매 신청서</h1>
				<span>구매 요청을 위해서 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</span>
				<div class="section-card">
					<form action="#" method="post">
						<div class="form-section">
							<h2 class="form-section-title">결재 정보</h2>
							<!-- 결재라인 전체 컨테이너 -->
							<div id="approval-line-container">
		
								<!-- 첫 번째 : 신청자 -->
								<fieldset class="approver-container">
								<legend class="approver-title" align="center">요청자</legend>
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
								<legend class="approver-title" align="center">일반결재</legend>
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
										<div class="name-title">
											<select id="category" class="form-input rent-input">
												<option>이영호 팀장</option>
												<option>송승엽 과장</option>
												<option>김성배 과장</option>
												<option>홍길동 대리</option>
												<option>김둘리 대리</option>
											</select>
										</div>
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
									<legend class="approver-title" align="center">최종결재</legend>
									<div class="approver-image-container">
										<img class="approver-image" src="https://placehold.co/100x100/d5f6e4/31343C?text=SAY" alt="신아영">
										<div class="approval-badge">
											<div class="approval-badge-icon">
												<i class="fas fa-check"></i>
											</div>
										</div>
									</div>
									<div class="approver-item">
										<div class="approver-info">
											<div class="name-title">
												<select id="category" class="form-input rent-input">
													<option>신아영 부장</option>
													<option>송승엽 과장</option>
													<option>김성배 과장</option>
													<option>홍길동 대리</option>
													<option>김둘리 대리</option>
												</select>
											</div>
											<div class="team">(사업본부)</div>
										</div>
									</div>
								</fieldset>
							</div>
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

						<div id="formInputArea" class ="inputArea">
							<div class="form-row">
								<div class="form-group fixed-width-sm">
									<label for="isDepartmentUse">부서 자산</label>
									<div>
										<input type="checkbox" id="isDepartmentUse" name="isDepartmentUse"> 
									</div>
								</div>
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label>
									<select id="category" name="category" required onchange="updateProductOptions()">
										<option value="" disabled selected>선택하세요</option>
										<option value="notebook">노트북</option>
										<option value="monitor">모니터</option>
										<option value="software">소프트웨어</option>
										<option value="other">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
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
									<input type="number" id="quantity" name="quantity" min="1" value="1" required>
								</div>
								<div class="form-group fixed-width-sm">
									<label for="totalPrice">총액 (원)</label>
									<div class="last-input-group">
										<input type="text" id="totalPrice" name="totalPrice-${currentIndex}" value="0" class="price-lock" readonly>
										<img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)" style="visibility:hidden;"></img>
									</div>
								</div>
							</div>
							<div id="add-product-section">
								<button type="button" class="add-product-button" onclick="addProduct();">+</button>
							</div>
							
							<div class="form-group">
								<label for="reason">구매 요청 사유 <span class="required">*</span></label>
								<textarea id="reason" name="reason" rows="4" required placeholder="구매 요청이 필요한 구체적인 구체적인 사유를 입력해주세요." maxlength="200" onkeyup="updateCharCount(this, 200)"></textarea>
								<div class="char-count-display text-align-right">
									(<span id="currentLength">0</span> / 200)
								</div>
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
							<button type="submit" class="primary-action">제출</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="/assetmanager/resources/js/modal.js"></script>
	<script src="/assetmanager/resources/js/requestForm.js"></script>
</body>
</html>