<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반출 요청 목록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/sideMenu.css" rel="stylesheet">
<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
<%-- 반출 자산 등록 모달 --%>
<link href="/assetmanager/resources/css/assetEntry.css" rel="stylesheet">
<%-- SweetAlert2 라이브러리 추가 --%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<div class="main-content">
			<div class="dashboard-container">
				<h1>반출 요청 목록</h1>
				<span>현재 처리 중인 모든 반출 요청의 목록을 확인하고 관리합니다.</span>

				<div class="section-card">
					<div class="header-controls">
						<div class="filter-controls">
							<div class="status-filter">
								<label for="statusFilter">상태:</label> <select id="statusFilter">
									<option value="all">전체</option>
									<option value="pending">대기 중</option>
									<option value="approved">승인됨</option>
									<option value="rejected">거부됨</option>
								</select>
							</div>
							<div class="search-box">
								<input type="text" id="assetSearch" placeholder="품목명 검색" class="search-field">
								<button>
									<img src="/assetmanager/resources/image/icon_search.svg" alt="검색">
								</button>
							</div>
						</div>
					</div>

					<table class="data-table">
						<thead>
							<tr>
								<th>품목명</th>
								<th>요청 사유</th>
								<th>수량</th>
								<th>요청일</th>
								<th>반납 예정일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<tr data-id="REQ001">
								<td>LG 그램 노트북</td>
								<td>사업상 새 개발용 노트북</td>
								<td>1</td>
								<td>2024-07-20</td>
								<td>2025-12-31</td>
								<td><span class="status-badge status-pending">대기 중</span></td>
							</tr>
							<tr data-id="REQ002" data-product="삼성 갤럭시 탭 S9">
								<td><a href="/assetmanager/rent/detail">삼성 갤럭시 탭 S9 외 2개</a></td>
								<td>잘못된 모델이 배송되어, 교환 요청.</td>
								<td>1</td>
								<td>2024-07-19</td>
								<td>2025-12-31</td>
								<td><span class="status-badge status-approved">승인됨</span></td>
							</tr>
							<tr data-id="REQ006" data-product="애플 워치 시리즈 9">
								<td>애플 워치 시리즈 9</td>
								<td>배터리 수명 기대 이하, 교환 요청.</td>
								<td>1</td>
								<td>2024-07-15</td>
								<td>2025-12-31</td>
								<td><span class="status-badge status-approved">승인됨</span></td>
							</tr>
							<tr data-id="REQ009">
								<td>크롬캐스트 with Google TV</td>
								<td>회의실 디스플레이용</td>
								<td>1</td>
								<td>2024-07-12</td>
								<td>2025-12-31</td>
								<td><span class="status-badge status-rejected">거부됨</span></td>
							</tr>
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
				</div>
			</div>
		</div>
	</div>

	<%-- 자산 등록 모달창 --%>
	<div id="registerModal" class="modal-backdrop" style="display: none;">
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
	</div>
	<script src="/assetmanager/resources/js/rent.js"></script>
</body>
</html>