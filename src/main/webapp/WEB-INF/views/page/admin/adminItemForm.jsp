<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>권장 제품 추가</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/modal.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1 class="content-title">권장 제품 추가</h1>
				<span>권장 제품 추가를 위해서 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</span>
				<div class="section-card">
					<form action="/assetmanager/admin/item/add" method="post" onsubmit="reindexInputsBeforeSubmit()">
						<div id="formInputArea" class ="inputArea">
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label>
									<select name="items[0].categoryId" required>
										<option value="" disabled selected>선택하세요</option>
										<option value="1">노트북</option>
										<option value="2">모니터</option>
										<option value="3">태블릿</option>
										<option value="4">스마트폰</option>
										<option value="5">복합기</option>
										<option value="6">데스크탑</option>
										<option value="7">TV</option>
										<option value="8">프로젝터</option>
										<option value="9">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명<span class="required">*</span></label>
									<input type="text" name="items[0].itemName" placeholder="직접 입력">
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">단가(₩) <span class="required">*</span></label>
									<input type="number" name="items[0].price" value="0" min="0" required>
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">제조사 <span class="required">*</span></label>
									<input type="text" name="items[0].seller" required>
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">거래처 <span class="required">*</span></label>
									<input type="text" name="items[0].maker" required>
								</div>
								<div class="form-group fixed-width-xl">
									<label for="price">스펙<span class="required">*</span></label>
									<div class="last-input-group">
										<input type="text" name="items[0].spec" required>
										<img class="form-icon" src="/assetmanager/resources/image/icon_delete.svg" onclick="removeProduct(this)" style="visibility:hidden;"></img>
									</div>
								</div>
							</div>
							<div id="add-product-section">
								<button type="button" class="add-product-button admin-item" onclick="addProduct();">+</button>
							</div>
						</div>
						<div class="button-container">
							<button type="submit" class="edit-button">등록</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script src="/assetmanager/resources/js/adminItemForm.js"></script>
</body>
</html>