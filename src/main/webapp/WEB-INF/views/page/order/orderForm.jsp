<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 구매요청 목록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/modal.css" rel="stylesheet">
<link href="/assetmanager/resources/css/orderForm.css" rel="stylesheet">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<div class="main-content">
    <div class="dashboard-container">
        <h1>구매 신청서</h1>
        <div class="section-card">
            <div class="purchase-form-container">
                <form id="purchaseRequestForm" action="#" method="post">
                    <div class="form-row first-row">
                        <div class="form-group category-group fixed-width-sm">
                            <label for="category">카테고리 <span class="required">*</span></label>
                            <select id="category" name="category" required
                                onchange="updateProductOptions()">
                                <option value="" disabled selected>선택하세요</option>
                                <option value="notebook">노트북</option>
                                <option value="monitor">모니터</option>
                                <option value="software">소프트웨어</option>
                                <option value="other">기타</option>
                            </select>
                        </div>

                        <div class="form-group product-select-group flex-grow-lg">
                            <label for="productNameSelect">제품명 
                            <span class="required">*</span></label> 
                            <select id="productNameSelect" name="productNameSelect" required onchange="handleProductChange(this.value)">
                                <option value="" disabled selected>카테고리를 먼저 선택하세요</option>
                                <option value="product1">상품1</option>
                                <option value="product2">상품2</option>
                                <option value="other">직접 입력</option>
                            </select>
                        </div>

                        <div class="form-group product-input-group flex-grow-lg" id="productInputGroup" style="display: none;">
                            <label for="productNameInput">직접 입력</label>
                            <input type="text" id="productNameInput" name="productNameInput" placeholder="제품명을 직접 입력하세요">
                        </div>
                    </div>

                    <div class="form-row second-row">
                        <div class="form-group price-group fixed-width-sm">
                            <label for="price">단가 (원) <span class="required">*</span></label>
                            <input type="number" id="price" name="price" value="0" class="price-lock" required readonly>
                        </div>

                        <div class="form-group quantity-group fixed-width-sm">
                            <label for="quantity">수량 <span class="required">*</span></label>
                            <input type="number" id="quantity" name="quantity" min="1" value="1" required>
                        </div>
                        
                        <div class="form-group price-group fixed-width-sm">
                            <label for="totalPrice">총액 (원)</label>
                            <input type="text" id="totalPrice" name="totalPrice" value="0" class="price-lock" readonly>
                        </div>

                        <div class="form-group empty-filler-second-row flex-fill"></div> 
                    </div>

                    <div class="form-group">
                        <label for="reason">구매 요청 사유 <span class="required">*</span></label>
                        <textarea id="reason" name="reason" rows="4" required placeholder="구매 요청이 필요한 구체적인 구체적인 사유를 입력해주세요." maxlength="200" onkeyup="updateCharCount(this, 200)"></textarea>
                        <div class="char-count-display text-align-right">(<span id="currentLength">0</span> / 200) </div>
                    </div>

                    <div class="form-group checkbox-group">
                        <input type="checkbox" id="isDepartmentUse" name="isDepartmentUse"> <label for="isDepartmentUse">부서 공동 사용 자산입니다.</label>
                        <p class="description">체크 시, 해당 자산은 특정 개인 소유가 아닌 부서 공동 자산으로 등록됩니다.</p>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="primary-action">제출</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
	</div>
	<script src="/assetmanager/resources/js/modal.js"></script>
	<script src="/assetmanager/resources/js/orderForm.js"></script>
</body>
</html>