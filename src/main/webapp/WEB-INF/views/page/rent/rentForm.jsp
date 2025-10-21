<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 반출 요청</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">
<link href="/assetmanager/resources/css/assetListModal.css" rel="stylesheet">
<link href="/assetmanager/resources/css/approver.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script src="https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"></script>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp"%>
			<div class="dashboard-container">
				<h1 class="content-title">반출 신청서</h1>
				<span>새로운 반출 요청을 위해서 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</span>
				<div class="section-card">
					<form action="#" method="post">
						<div class="form-section">
							<!-- 결재라인 불러오기 -->
							<%@ include file="/WEB-INF/views/component/approver.jsp"%>
						</div>

						<h2 class="form-section-title">요청 내용</h2>
						<div class="radio-input-group">
							<div class="radio-input">
								<input type="radio" id="inputMethodForm" name="inputMethod" value="form" checked onclick="showInputForm('form')"> <label for="inputMethodForm">폼 직접 입력 </label>
							</div>
							<div class="radio-input">
								<input type="radio" id="inputMethodExcel" name="inputMethod" value="excel" onclick="showInputForm('excel')"> <label for="inputMethodExcel">엑셀 파일 업로드</label>
							</div>
						</div>

						<div id="formInputArea" class="inputArea">
							<div class="form-row">
								<div class="form-group fixed-width-sm">
									<label for="isDepartmentUse">부서 자산</label> <input type="checkbox" id="isDepartmentUse" name="isDepartmentUse">
								</div>
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label> <select id="category" name="category" required onchange="updateProductOptions()">
										<option value="" disabled selected>선택하세요</option>
										<option value="notebook">노트북</option>
										<option value="monitor">모니터</option>
										<option value="software">소프트웨어</option>
										<option value="other">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label>제품명<span class="required">*</span></label> 
									<input list="productOptions" name="productNameSelect" id="productNameSelect" class="productSelect" placeholder="선택 " data-target="product-modal">
								
								</div>
								<div class="form-group fixed-width-sm">
									<label for="quantity">수량 <span class="required">*</span></label>
									<div class="last-input-group">
										<input type="number" id="quantity" name="quantity" min="1" value="1" required> <img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)" style="visibility: hidden;"></img>
									</div>
								</div>

							</div>
							<div id="add-product-section">
								<button type="button" class="add-product-button" onclick="addProduct();">+</button>
							</div>

							<div class="form-footer">
								<div class="form-reason">
									<label for="reason">반출 요청 사유 <span class="required">*</span></label>
									<textarea id="reason" name="reason" rows="5" required placeholder="반출 요청이 필요한 구체적인 구체적인 사유를 입력해주세요." cols="81" maxlength="200" onkeyup="updateCharCount(this, 200)"></textarea>
									<div class="char-count-display text-align-right">
										(<span id="currentLength">0</span> / 200)
									</div>
								</div>

								<div class="form-date">
									<div class="form-application-date">
										<label for="application-date">반출 신청일</label> <input type="date" id="application-date" value="${currentDate}" class="form-input rent-input" readonly>
									</div>
									<div class="form-return-date">
										<label for="return-date">반납 예정일</label> <input type="date" id="return-date" placeholder="반납 예정일 선택" class="form-input rent-input">
									</div>
								</div>
							</div>
						</div>


						<div id="excelUploadArea" class="inputArea">
							<div class="form-group file-upload-group">
								<span>다음 양식 파일을 다운로드하여 요청 세부 사항을 기입하고 업로드하세요.</span>
								<button type="button" class="btn-template-download" style="margin-bottom: 20px;" onclick="downloadExcelTemplate()">⬇️ 템플릿 다운로드</button>
								<label for="excelFile">엑셀 파일 선택 <span class="required">*</span></label> <input type="file" id="excelFile" name="excelFile" accept=".xlsx, .xls">
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
	
	<!-- 제품 검색 모달 -->
    <div id="product-modal" class="modal-overlay hidden">
        <div class="modal-content" id="modal-content-container">
            <div class="modal-header">
                <h3 class="modal-title">자산 리스트 검색</h3>
                <button id="close-modal-btn" class="close-modal-btn">
                    <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                </button>
            </div>
            <div class="modal-body">
                <input type="text" id="product-search-input" class="input-field" placeholder="제품명 또는 스펙으로 검색하세요...">
                <div class="table-container">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>제품명</th>
                                <th>스펙</th>
                            </tr>
                        </thead>
                        <tbody id="asset-list-body">
                            <!-- 자산 데이터가 여기에 동적으로 추가됩니다 -->
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
	<script src="/assetmanager/resources/js/rentForm.js"></script>
	<script src="/assetmanager/resources/js/requestForm.js"></script> <!-- 엑셀 업로드 -->
	<script src="/assetmanager/resources/js/assetListModal.js"></script>
</body>
</html>