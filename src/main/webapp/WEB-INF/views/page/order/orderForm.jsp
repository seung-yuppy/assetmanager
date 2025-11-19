<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 요청</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>
	<script src="https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1 class="content-title">구매 요청서</h1>
				<span class="page-description">새로운 구매 요청을 위해서 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</span>
				<div class="section-card">
					<form id="requestForm" action="/assetmanager/order/form" method="post">
						<div style="display:none;">
							<input name="title" type="text" id="requestTitle" value="테스트" >
						</div>
						<div class="form-section">
							<!-- 결재라인 전체 컨테이너 -->
							<jsp:include page="/WEB-INF/views/component/approver.jsp">
								<jsp:param name="admin" value="${admin}"/>
								<jsp:param name="manager" value="${manager}" />
							</jsp:include>
						</div>
						<h2 class="form-section-title">요청 정보</h2>
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
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label>
									<select id="category" name="products[0].categoryId" required>
										<option value="" disabled selected>선택하세요</option>
										<c:forEach var="item" items="${categories}">
											<option value="${item.id}">${item.categoryName}</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="product-select">제품명<span class="required">*</span></label>
							        <select id="product-select" name="products[0].itemName" required></select>
								</div>
								<div style="display:none;">
									<input type="text" name="products[0].spec" >
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">단가 (₩) <span class="required">*</span></label>
									<input type="number" id="price" name="products[0].price" value="0" min="0" required>
								</div>
								<div class="form-group fixed-width-sm">
									<label for="quantity">수량 <span class="required">*</span></label>
									<input type="number" id="quantity" name="products[0].count" min="1" max="10" value="1" required>
								</div>
								<div class="form-group fixed-width-med">
									<label for="totalPrice">총액 (원)</label>
									<div class="last-input-group">
										<input type="text" id="totalPrice" name="totalPrice" value="0" class="locked-input" readonly>
										<img class="form-icon" src="/assetmanager/resources/image/icon_delete.svg" onclick="removeProduct(this)" style="visibility:hidden;"></img>
									</div>
								</div>
							</div>
							<div id="add-product-section">
								<button type="button" class="add-product-button" onclick="addProduct();">+</button>
							</div>
							<div class="form-group">
								<label for="reason">구매 요청 사유 <span class="required">*</span></label>
								<textarea id="reason" name="requestMsg" rows="4" required placeholder="구매 요청이 필요한 구체적인 구체적인 사유를 입력해주세요." maxlength="200" onkeyup="updateCharCount(this, 200)"></textarea>
								<div class="char-count-display text-align-right">
									(<span id="currentLength">0</span> / 200)
								</div>
							</div>
						</div>
						
						<div id="excelUploadArea" class="inputArea">
                            <div class="template-info-box">
                                <span>다음 양식 파일을 다운로드하여 요청 세부 사항을 기입하고 업로드하세요.</span>
                                <button type="button" class="btn-template-download-v5" onclick="downloadExcelTemplate()">템플릿 다운로드</button>
                            </div>
                        
                            <div class="file-upload-wrapper">
                                <label for="excelFile">엑셀 파일 선택 <span class="required">*</span></label>
                                <div class="custom-file-input">
                                    <!-- "파일 선택" 버튼 -->
                                    <label for="excelFile" class="file-select-btn">파일 선택</label>
                                    <!-- 파일명 표시 -->
                                    <span id="file-name-display">선택된 파일 없음</span>
                                    <!-- 실제 숨겨진 input -->
                                    <input type="file" id="excelFile" name="excelFile" accept=".xlsx, .xls" aria-label="엑셀 파일 선택">
                                </div>
                            </div>
                            
                            <div id="data-display-area" style="margin-top: 1rem;">
                                <!-- 엑셀 미리보기 데이터가 여기에 표시됩니다. -->
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
	<%@ include file="/WEB-INF/views/component/chatbot.jsp"%>	
	
	<script src="/assetmanager/resources/js/requestForm.js"></script>
	<script src="/assetmanager/resources/js/orderForm.js"></script>
</body>
</html>