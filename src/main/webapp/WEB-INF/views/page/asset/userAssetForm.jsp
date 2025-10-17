<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자산 등록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/modal.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">

</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1 class="content-title">자산 등록</h1>
				<span>반출 자산 등록을 위해서 아래 양식을 작성하세요.</span>
				<div class="section-card">
					<div>
						<h2 class="form-section-title">요청 정보</h2>
						            <!-- 정보 항목 컨테이너 (Flex 레이아웃으로 변경) -->
			            <div class="info-grid">
			                <div class="info-item date-item">
			                    <span class="info-label">
			                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" xmlns="http://www.w3.org/2000/svg">
			                        	<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
			                        </svg>요청 일자
			                    </span>
			                    <p class="info-value date">2025.10.17</p>
			                </div>
			                <div class="info-item request-reason">
			                    <span class="info-label">
			                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" xmlns="http://www.w3.org/2000/svg">
				                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
			                        </svg>요청 사유
			                    </span>
			                    <p class="info-value reason">신입 사원 배정으로 인한 업무용 노트북 구매</p>
			                </div>
			            </div>
					</div>
					<form action="#" method="post">
						<h2 class="form-section-title">등록 내용</h2>
						<div id="formInputArea" class ="inputArea">
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리</label>
									<input id="category" name="category" value="노트북" type="text" readonly>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명</label>
									<input list="productOptions" name="productNameSelect" id="productNameSelect" value="2024 울트라PC">
								</div>
								<div class="form-group fixed-width-lg">
									<label for="serialNum">일련번호</label>
									<input type="text" name="serialNum" id="serialNum" placeholder="일련 번호 입력">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리</label>
									<input id="category" name="category" value="노트북" type="text" readonly>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명</label>
									<input list="productOptions" name="productNameSelect" id="productNameSelect" value="2024 울트라PC">
								</div>
								<div class="form-group fixed-width-lg">
									<label for="serialNum">일련번호</label>
									<input type="text" name="serialNum" id="serialNum" placeholder="일련 번호 입력">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리</label>
									<input id="category" name="category" value="노트북" type="text" readonly>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명</label>
									<input list="productOptions" name="productNameSelect" id="productNameSelect" value="2024 울트라PC">
								</div>
								<div class="form-group fixed-width-lg">
									<label for="serialNum">일련번호</label>
									<input type="text" name="serialNum" id="serialNum" placeholder="일련 번호 입력">
								</div>
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
</body>
</html>