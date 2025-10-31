<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반출 승인 목록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
<link href="/assetmanager/resources/css/adminList.css" rel="stylesheet">
<link href="/assetmanager/resources/css/adminDetail.css" rel="stylesheet">
<link href="/assetmanager/resources/css/assetEntry.css" rel="stylesheet">

<%-- SweetAlert2 라이브러리 추가 --%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>

		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>		
			<div class="dashboard-container">
				<h1>반출 요청 목록</h1>
				<span>현재 처리 중인 모든 반출 요청의 목록을 확인하고 관리합니다.</span>

				<div class="section-card">
					<div class="search-card">
						<div class="filter-controls">
							<div class="status-filter">
								<label for="statusFilter">상태:</label>
				                <select id="statusFilter" onchange="setBoardParam('status', this.value)">
				                    <option value="" ${empty param.status ? 'selected' : ''}>전체</option>
								    <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>대기중</option>
								    <option value="FIRST_APPROVAL" ${param.status == 'FIRST_APPROVAL' ? 'selected' : ''}>처리중</option>
								    <option value="FINAL_APPROVAL" ${param.status == 'FINAL_APPROVAL' ? 'selected' : ''}>승인됨</option>
								    <option value="REJECT" ${param.status == 'REJECT' ? 'selected' : ''}>거절됨</option>
				                </select>
							</div>
							<div class="search-box">
								<input type="text" id="assetSearch" placeholder="품목명 검색" class="search-field">
								<button><img src="/assetmanager/resources/image/icon_search.svg" alt="검색"></button>
							</div>
						</div>
					</div>


					<table class="data-table">
						<thead>
							<tr>
								<th>요청 내용</th>	
								<th>요청자</th>	
								<th>부서</th>													
								<th>요청일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty adminList}">
						        <tr>
						            <td colspan="5" style="text-align: center; padding: 20px;">결재 요청이 존재하지 않습니다.</td>
						        </tr>
						    </c:if>
							<c:forEach var="item" items="${adminList}">
								<tr data-id="${item.id}">
									<td><a href="/assetmanager/admin/user/detail">${item.title}</td>
									<td><a href="/assetmanager/admin/user/detail">${item.username}</a></td>
									<td>${item.deptName}</td>									
									<td><fmt:formatDate value="${item.rentDate}" pattern="yyyy-MM-dd" /></td>
									<td><span class="status-badge status-${item.status.badgeType}">${item.status.koreanName}</span></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<nav class="pagination-container">
						<ul class="pagination-list">
							<li class="page-item prev"><a class="page-link" href="#">&lt; 이전</a></li>
							<li class="page-item active"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item next"><a class="page-link" href="#">다음 &gt;</a></li>
						</ul>
					</nav>
<!-- 					<div class="action-buttons">
						<button id="rejectBtn" class="btn btn-reject" disabled>거부</button>
						<button id="approveBtn" class="btn btn-approve" disabled>승인</button>
					</div> -->
				</div>
			</div>
		</div>
	</div>

	<%-- 상세 정보 모달 --%>
	<div id="detailModal" class="modal-backdrop" style="display: none;">
		<div class="modal-content">
			<div class="modal-header">
				<h2>반출 요청 상세 정보</h2>
				<button class="modal-close-btn">&times;</button>
			</div>
			<div class="modal-body" id="detailModalBody">
				<div class="form-group">
					<label for="modalProductName">제품명</label> <input type="text" id="modalProductName" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalSerialNumber">일련번호</label> <input type="text" id="modalSerialNumber" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalUserName">사용자명</label> <input type="text" id="modalUserName" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalDepartment">부서명</label> <input type="text" id="modalDepartment" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalPosition">직위</label> <input type="text" id="modalPosition" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalReason">요청 사유</label> <input type="text" id="modalReason" class="form-input" readonly>
				</div>
				<div class="form-group">
					<label for="modalReturnDate">반납 예정일</label> <input type="text" id="modalReturnDate" class="form-input" readonly>
				</div>
			</div>
			<div class="modal-footer">
				<button class="btn-primary">확인</button>
			</div>
		</div>
	</div>
	<script src="/assetmanager/resources/js/notice.js"></script>
</body>
</html>