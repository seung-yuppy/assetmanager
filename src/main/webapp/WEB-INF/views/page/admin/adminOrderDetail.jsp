<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 요청 상세</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css"
	rel="stylesheet">
<link href="/assetmanager/resources/css/adminDetail.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script
		src="https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"></script>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp"%>
			<div class="dashboard-container">
				<h1 class="content-title">구매 요청 상세</h1>
				<div class="detail-header">
					<span class="page-description">구매 요청의 상세 내용을 확인하세요</span>
				</div>
				<div class="section-card">
					<div class="form-section">
						<!-- 결재라인 전체 컨테이너 -->
						<%@ include file="/WEB-INF/views/component/approverReadonly.jsp"%>
					</div>
					<!-- 신청자 정보 섹션 전체 컨테이너 -->
					<div class="applicant-info-section">
						<!-- 제목 -->
						<h2 class="applicant-section-title">신청자 정보</h2>
						<!-- 내용 목록 -->
						<div class="applicant-info-list">
							<dl class="applicant-info-f-list">
								<dt>사번</dt>
								<dd>${empInfo.userInfo.empNo}</dd>

								<dt>이름</dt>
								<dd>${empInfo.userInfo.username}</dd>

								<dt>부서명</dt>
								<dd>${empInfo.userInfo.deptName}</dd>
							</dl>
							<dl class="applicant-info-s-list">
								<dt>직책</dt>
								<dd>사원</dd>

								<dt>연락처</dt>
								<dd>${empInfo.userInfo.phone}</dd>

								<dt>주소</dt>
								<dd>${empInfo.userInfo.deptAddress}</dd>
							</dl>
						</div>
					</div>
					<form action="#" method="post">
						<h2 class="form-section-title">요청 내용</h2>
						<div id="formInputArea" class ="inputArea">
							<div class="form-date">
								<div class="form-application-date">
									<label for="application-date">구매 요청일</label> 
									<input type="date" id="application-date" value='<fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/>' class="form-input rent-input locked-input" readonly>
								</div>
							</div>
							<c:forEach var="product" items="${products}">
								<c:forEach var="i" begin="1" end="${product.count}">
									<div class="form-row">
										<div class="form-group category-group fixed-width-med">
											<label for="category">카테고리 </label>
											<input id="category" name="category" type="text" value="${product.categoryName}" class="locked-input" readonly>
										</div>
										<div class="form-group product-select-group fixed-width-lg">
											<label for="productNameSelect">제품명</label>
											<input list="productOptions" name="productNameSelect" id="productNameSelect" type="text" value="${product.itemName}" class="locked-input" readonly>
										</div>
										<div class="form-group fixed-width-med">
											<label for="price">단가 (원)</label>
											<div class="last-input-group">
												<input type="text" id="price" name="price" value='<fmt:formatNumber value="${product.price}" type="number"/>' class="locked-input" readonly>
												<c:if test="${approval.status == 'FINAL_APPROVAL'}" >
													<button type="button" class="regist-button" data-target="registerModal">등록</button>
												</c:if>
											</div>
										</div>
									</div>
								</c:forEach>
							</c:forEach>
							<div class="form-group">
								<label for="reason">구매 요청 사유</label>
								<textarea id="reason" name="reason" rows="4" readonly>${order.requestMsg}</textarea>
							</div>
						</div>

						<div id="excelUploadArea" class="inputArea">
							<div class="form-group file-upload-group">
								<span>다음 양식 파일을 다운로드하여 요청 세부 사항을 기입하고 업로드하세요.</span>
								<button type="button" class="btn-template-download"
									style="margin-bottom: 20px;" onclick="downloadExcelTemplate()">⬇️
									템플릿 다운로드</button>
								<label for="excelFile">엑셀 파일 선택 <span class="required">*</span></label>
								<input type="file" id="excelFile" name="excelFile"
									accept=".xlsx, .xls">
							</div>
							<div id="data-display-area"></div>
						</div>
						<div class="form-actions">
							<c:if test="${approval.status == 'PENDING'}">
								<button type="button" class="primary-action" onclick="location.href='/assetmanager/approve?id=${approval.id}&status=${approval.status}'">승인</button>
								<button type="button" class="cancel-action" onclick="location.href='/assetmanager/reject?id=${approval.id}&status=${approval.status}'">반려</button>
							</c:if>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="/assetmanager/resources/js/requestForm.js"></script>
</body>
</html>