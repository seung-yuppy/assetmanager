<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 요청 상세</title>
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
				<h1 class="content-title">구매 요청 상세</h1>
				<span>구매 요청의 상세 내용을 확인하세요</span>
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
										<div class="name-title"> 강예나 <span class="title">사원</span>
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
											<div class="name-title"> 신아영 <span class="title">부장</span></div>
											<div class="team">(사업본부)</div>
										</div>
									</div>
								</fieldset>
							</div>
						</div>
						<h2 class="form-section-title">요청 내용</h2>
						<div id="formInputArea" class ="inputArea">
							<div class="form-row">
								<div class="form-group fixed-width-sm">
									<label for="isDepartmentUse">부서 자산</label>
									<input type="checkbox" id="isDepartmentUse" name="isDepartmentUse" checked onclick="return false"> 
								</div>
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 </label>
									<input id="category" name="category" type="text" value="기타" class="locked-input" readonly>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명</label>
									<input list="productOptions" name="productNameSelect" id="productNameSelect" type="text" value="복합기" class="locked-input" readonly>
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">단가 (원)</label>
									<input type="number" id="price" name="price" value="3000000" class="locked-input" readonly>
								</div>
								<div class="form-group fixed-width-sm" style="display:none;">
									<label for="quantity">수량</label>
									<input type="number" id="quantity" name="quantity" value="1" class="locked-input" readonly>
								</div>
								<div class="form-group fixed-width-med">
									<label for="totalPrice">총액 (원)</label>
									<div class="last-input-group">
										<input type="text" id="totalPrice" name="totalPrice-${currentIndex}" value="0" class="locked-input" readonly>
									</div>
								</div>
								<div class="form-group fixed-width-lg">
									<label for="serialNum">일련 번호</label>
									<input type="text" id="serialNum" name="serialNum" value="">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group fixed-width-sm">
									<label for="isDepartmentUse">부서 자산</label>
									<input type="checkbox" id="isDepartmentUse" name="isDepartmentUse" onclick="return false"> 
								</div>
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 </label>
									<input id="category" name="category" type="text" value="노트북" class="locked-input" readonly>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명</label>
									<input list="productOptions" name="productNameSelect" id="productNameSelect" type="text" value="LG그램" class="locked-input" readonly>
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">단가 (원)</label>
									<input type="number" id="price" name="price" value="1000000" class="locked-input" readonly>
								</div>
								<div class="form-group fixed-width-sm" style="display:none;">
									<label for="quantity">수량</label>
									<input type="number" id="quantity" name="quantity" value="1" class="locked-input" readonly>
								</div>
								<div class="form-group fixed-width-med">
									<label for="totalPrice">총액 (원)</label>
									<div class="last-input-group">
										<input type="text" id="totalPrice" name="totalPrice" value="jsp에서 계산" class="locked-input" readonly>
									</div>
								</div>
								<div class="form-group fixed-width-lg">
									<label for="serialNum">일련 번호</label>
									<input type="text" id="serialNum" name="serialNum" value="">
								</div>
							</div>
							
							<div class="form-group">
								<label for="reason">구매 요청 사유</label>
								<textarea id="reason" name="reason" rows="4" readonly>신입 사원 배정으로 인한 노트북 구매 요청</textarea>
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
							<button type="submit" class="primary-action">자산 등록</button>
							<button type="button" class="cancel-action">요청 취소</button>
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