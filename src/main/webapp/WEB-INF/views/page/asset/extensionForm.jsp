<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반출 연장</title>
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
				<h1 class="content-title">연장 요청</h1>
				<span class="page-description">요청을 위해서 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</span>
				<div class="section-card">
					<form action="#" method="post">
						<div class="form-section">
							<!-- 결재라인 전체 컨테이너 -->
							<%@ include file="/WEB-INF/views/component/approver.jsp" %>
						</div>
						<h2 class="form-section-title">요청 내용</h2>
						<div id="formInputArea" class ="inputArea">
							<div class="form-content">
								<div class="form-date" style="margin-bottom: 20px;">
									<div class="form-application-date">
										<label for="application-date">기존 반납일</label> 
										<input type="date" id="application-date" value="" class="form-input locked-input" readonly>
									</div>
								</div>
								<div class="form-date" style="margin-bottom: 20px;">
									<div class="form-application-date">
										<label for="application-date">신규 반납일<span class="required">*</span></label> 
										<input type="date" id="application-date" value="" class="form-input">
									</div>
								</div>
							</div>
							<div class="form-content">
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
									<div class="form-group fixed-width-xl">
										<label for="spec">스펙</label>
										<input type="text" id="spec" value="cpu~~~~~" class="locked-input" readonly>
									</div>
								</div>
							</div>
							<div class="form-content">
								<div class="form-group">
									<label for="reason">연장 사유 <span class="required">*</span></label>
									<textarea id="reason" name="reason" rows="4" required placeholder="연장이 필요한 구체적인 구체적인 사유를 입력해주세요." maxlength="200" onkeyup="updateCharCount(this, 200)"></textarea>
									<div class="char-count-display text-align-right">
										(<span id="currentLength">0</span> / 200)
									</div>
								</div>
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
	<script src="/assetmanager/resources/js/requestForm.js"></script>
</body>
</html>