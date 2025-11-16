<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 구매요청 목록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<style>
		.radio-input-group .radio-input input[type="radio"] {
           display: none;
       }

       .radio-input-group {
           display: inline-flex; /* 탭들을 가로로 나열 */
           background-color: #f3f4f6; /* 연한 회색 배경 (이미지 참고) */
           border-radius: 10px; /* 둥근 모서리 */
           padding: 4px; /* 탭과 컨테이너 사이 여백 */
           border: 1px solid #e5e7eb; /* 연한 테두리 */
           margin-left: 2.4rem;
       }
     
       /* 3. 탭 라벨 기본 스타일 (비활성 상태) */
       .radio-input-group .radio-input label {
           display: flex; /* 아이콘과 텍스트 정렬 */
           align-items: center;
           justify-content: center;
           padding: 10px 20px; /* 탭 내부 여백 (상하 10, 좌우 20) */
           font-size: 15px;
           font-weight: 500;
           color: #6b7280; /* 비활성 텍스트 색상 (회색) */
           border-radius: 8px; /* 탭의 둥근 모서리 */
           cursor: pointer;
           transition: all 0.2s ease-in-out; /* 부드러운 전환 효과 */
           user-select: none; /* 텍스트 선택 방지 */
           white-space: nowrap; /* 텍스트 줄바꿈 방지 */
       }
       
       .radio-input-group .radio-input input[type="radio"]:checked + label {
           background-color: #ffffff; /* 흰색 배경 */
           color: var(--primary-color ); /* 활성 텍스트/아이콘 색상 (보라색 계열) */
           font-weight: 600; /* 굵은 폰트 */
           box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.06); /* 그림자 */
       }
       
       #excelUploadArea {
           padding: 24px;
           border-radius: 8px;
           background-color: #f9fafb; /* 연한 배경색 */
           border: 1px solid #e5e7eb;
       }
       
       /* 템플릿 다운로드 안내 박스 (v5) */
       .template-info-box {
           display: flex;
           align-items: center;
           border-radius: 8px;
           font-size: 14px;
           color: #374151;
           margin-bottom: 1.5rem;
           gap: 10px;
       }
       .btn-template-download-v5 {
           /* 사이드바 친화적인 파란색 버튼 */
           background-color: #eff6ff; /* bg-blue-50 */
           color: #2563eb; /* text-blue-700 */
           font-weight: 500;
           padding: 6px 12px;
           border-radius: 6px;
           border: 1px solid #bfdbfe; /* border-blue-200 */
           cursor: pointer;
           transition: all 0.2s;
           white-space: nowrap; /* 줄바꿈 방지 */
       }
       .btn-template-download-v5:hover {
           background-color: #dbeafe; /* bg-blue-100 */
       }

       /* 커스텀 파일 인풋 (v5) */
       .file-upload-wrapper {
           display: flex;
           flex-direction: column;
           width: 100%;
       }
       .file-upload-wrapper > label { /* "엑셀 파일 선택 *" 라벨 */
           font-weight: 500;
           color: #374151;
           font-size: 14px;
           margin-bottom: 8px;
       }
       .file-upload-wrapper .required {
           color: #ef4444;
           margin-left: 2px;
       }
       
       /* 실제 숨겨진 input */
       .custom-file-input input[type="file"] {
           display: none;
       }
       
       /* 커스텀 파일 인풋 컨테이너 */
       .custom-file-input {
           display: flex;
           align-items: center;
           border: 1px solid #d1d5db;
           border-radius: 6px;
           width: 100%;
           height: 42px; /* 다른 입력창과 높이 통일 */
           box-sizing: border-box;
           background-color: #ffffff;
           overflow: hidden; /* 내부 요소가 둥근 모서리를 넘지 않도록 */
       }
       
       /* "파일 선택" 버튼 */
       .custom-file-input .file-select-btn {
           background-color: #f3f4f6; /* 연한 회색 */
           border-right: 1px solid #d1d5db;
           padding: 0 16px;
           height: 100%;
           display: flex;
           align-items: center;
           font-size: 14px;
           font-weight: 500;
           color: #374151;
           cursor: pointer;
           border-top-left-radius: 5px; /* 컨테이너의 둥근 모서리와 맞춤 */
           border-bottom-left-radius: 5px;
           transition: background-color 0.2s;
           white-space: nowrap;
       }
       .custom-file-input .file-select-btn:hover {
           background-color: #e5e7eb;
       }
       
       /* "선택된 파일 없음" 텍스트 */
       .custom-file-input #file-name-display {
           padding: 8px 12px;
           font-size: 14px;
           color: #6b7280; /* 기본 회색 텍스트 */
           white-space: nowrap;
           overflow: hidden;
           text-overflow: ellipsis; /* 파일명이 길 경우 ... 처리 */
       }
</style>
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
							<div class="form-content">
								<div class="form-date">
									<div class="form-application-date">
										<label for="application-date">구매 요청일</label> 
										<input type="date" id="application-date" value="${today}" class="form-input rent-input" disabled style="width:192px;">
									</div>
								</div>
							</div>
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
									<label for="price">단가 (원) <span class="required">*</span></label>
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
	<script src="/assetmanager/resources/js/requestForm.js"></script>
	<script src="/assetmanager/resources/js/orderForm.js"></script>
</body>
</html>