<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>반출요청 상세</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestDetail.css" rel="stylesheet">
<link href="/assetmanager/resources/css/modal.css" rel="stylesheet">
<link href="/assetmanager/resources/css/assetEntry.css" rel="stylesheet">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<div class="main-content">
			<div class="dashboard-container">
				<div class="content-wrapper">
					<div class="request-title">
						<h2>둘리님의 반출 요청</h2>
						<h2 class="status-badge status-waited">승인 대기</h2>
					</div>
					<div class="request-description">
						<span>입사로 인한 업무 장비 구매</span> <span>2025-10-11</span>
					</div>
					<table class="data-table">
						<thead>
							<tr>
								<th>분류</th>
								<th>품명</th>
								<th>반출일</th>
								<th>수량</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>노트북</td>
								<td>Latitude 7420 노트북</td>
								<td>2025-07-01</td>
								<td>2</td>
							</tr>
							<tr>
								<td>노트북</td>
								<td>Latitude 7420 노트북</td>
								<td>2025-07-01</td>
								<td>1</td>
							</tr>
						</tbody>
					</table>

					<div class="action-buttons">
						<button class="add-button" data-toggle="modal" data-target="rejectDetailModal">자산 등록</button>
						<button class="cancel-button">취소</button>
					</div>

				</div>
			</div>
		</div>
	</div>

	<%-- 자산 등록 모달창 --%>
	<%-- <div id="registerModal" class="modal-backdrop" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<h2>물품 반출 등록</h2>
				<button id="closeModalBtn" class="modal-close-btn">&times;</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="modalProductName">제품명</label> <input type="text" id="modalProductName" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="application-date">등록일</label> <input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalReturnDate">반납 예정일</label> <input id="modalReturnDate" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalSerialNumber">일련번호</label> <input type="text" id="modalSerialNumber" class="form-input">
				</div>


			</div>
			<div class="modal-footer">
				<button id="cancelBtn" class="btn-secondary">취소</button>
				<button class="btn-primary">반출 등록</button>
			</div>
		</div>
	</div> --%>


	<%-- 다건 자산 등록 모달 --%>
	<div id="rejectDetailModal" class="custom-modal-backdrop">
		<div class="custom-modal-content">
			<div class="modal-header">
				<h2>물품 반출 등록(${currentDate})</h2>
				<button id="closeModalBtn" class="modal-close-btn">&times;</button>
			</div>

			<div class="modal-grid">
				<div class="form-group">
					<label for="modalProductName">제품명</label> <input type="text" id="modalProductName" class="form-input" readonly> <label for="modalSerialNumber">일련번호</label> <input type="text" id="modalSerialNumber" class="form-input">
				</div>
				<div class="form-group">
					<label for="modalProductName">제품명</label> <input type="text" id="modalProductName" class="form-input" readonly> <label for="modalSerialNumber">일련번호</label> <input type="text" id="modalSerialNumber" class="form-input">
				</div>
				<div class="form-group">
					<label for="modalProductName">제품명</label> <input type="text" id="modalProductName" class="form-input" readonly> <label for="modalSerialNumber">일련번호</label> <input type="text" id="modalSerialNumber" class="form-input">
				</div>
				<div class="form-group">
					<label for="modalProductName">제품명</label> <input type="text" id="modalProductName" class="form-input" readonly> <label for="modalSerialNumber">일련번호</label> <input type="text" id="modalSerialNumber" class="form-input">
				</div>
			</div>
			<div class="modal-footer">
				<button id="cancelBtn" class="btn-secondary">취소</button>
				<button class="btn-primary">반출 등록</button>
			</div>
		</div>
	</div>
	<script src="/assetmanager/resources/js/modal.js"></script>

</body>
</html>