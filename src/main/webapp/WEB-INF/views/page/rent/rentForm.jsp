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
				<span class="page-description">새로운 반출 요청을 위해서 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</span>
				<div class="section-card">
					<form id="requestForm" action="/assetmanager/rent/approval" method="post">
						<div class="form-section">
							<!-- 결재라인 불러오기 -->
							<jsp:include page="/WEB-INF/views/component/approver.jsp">
								<jsp:param value="${admin}" name="admin" />
								<jsp:param value="${manager}" name="manager" />
								<jsp:param value="${user}" name="user" />
							</jsp:include>
						</div>

						<h2 class="form-section-title">요청 정보</h2>
						<div class="radio-input-group">
							<div class="radio-input">
								<input type="radio" id="inputMethodForm" name="inputMethod" value="form" checked onclick="showInputForm('form')"> <label for="inputMethodForm">폼 직접 입력 </label>
							</div>
							<div class="radio-input">
								<input type="radio" id="inputMethodExcel" name="inputMethod" value="excel" onclick="showInputForm('excel')"> <label for="inputMethodExcel">엑셀 파일 업로드</label>
							</div>
						</div>

						<div id="formInputArea" class="inputArea">
							<div class="form-date">
								<div class="form-application-date">
									<label for="application-date">반출 신청일</label> <input type="date" id="application-date" value="${currentDate}" class="form-input rent-input" readonly>
								</div>
								<div class="form-return-date">
									<label for="return-date">반납 예정일 <span class="required">*</span></label> 
									<input type="date" name="returnDate" id="return-date" placeholder="반납 예정일 선택" class="form-input rent-input" min="${currentDate}" required>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label> 
									<select class="category" name="category" required>
										<option value="" disabled selected>선택하세요</option>
										<option value="notebook">노트북</option>
										<option value="monitor">모니터</option>
										<option value="tablet">태블릿</option>
										<option value="smartphone">스마트폰</option>
										<option value="multiprinter">복합기</option>
										<option value="desktop">데스크탑</option>
										<option value="tv">TV</option>
										<option value="projector">프로젝터</option>
										<option value="other">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label>제품명 <span class="required">*</span></label> 
									<input list="productOptions" name="items[0].assetName" id="productNameSelect" class="productSelect" placeholder="선택  또는 직접 입력" data-target="product-modal" required>
									<input type="hidden" name="items[0].assetId" value="" />
								</div>
								<div class="form-group fixed-width-sm">
									<label>수량 <span class="required">*</span></label>
									<div class="last-input-group">
										<input type="number" class="numberSelect" name="items[0].count" min="1" value="1" required> 
										<img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)" style="visibility: hidden;"></img>
									</div>
								</div>
							</div>
							<div id="add-product-section">
								<button type="button" class="add-product-button" onclick="addProduct();">+</button>
							</div>


							<div class="form-group">
								<label for="reason">반출 요청 사유 <span class="required">*</span></label>
								<textarea id="reason" name="requestMsg" rows="5" required placeholder="반출 요청이 필요한 구체적인 사유를 입력해주세요." cols="81" maxlength="200" onkeyup="updateCharCount(this, 200)"></textarea>
								<div class="char-count-display text-align-right">
									(<span id="currentLength">0</span> / 200)
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
					<svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
						<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
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
								<th style="width:30px";>수량</th>
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
	<script src="/assetmanager/resources/js/rentExcelUpload.js"></script>
	<script src="/assetmanager/resources/js/rent.js"></script>
	<script src="/assetmanager/resources/js/assetListModal.js"></script>
</body>
</html>