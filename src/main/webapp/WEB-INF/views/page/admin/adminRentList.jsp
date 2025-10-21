<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
								<label for="statusFilter">카테고리:</label>
								<select id="statusFilter">
									<option value="all">전체</option>
									<option value="laptop">노트북</option>
									<option value="monitor">모니터</option>
									<option value="keyboard">키보드</option>
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
								<%--<th><input type="checkbox" id="selectAllCheckbox"></th>--%>
								<th>품목명</th>	
								<th>사번</th>
								<th>요청자</th>						
								<!-- <th>요청 사유</th> -->
								<th>요청일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<%-- 모든 tr 태그에 data-id="요청ID" 를 추가합니다 --%>
							<tr data-id="REQ001">
								<%--<td><input type="checkbox" class="row-checkbox"></td>--%>
								<td>LG 그램 노트북 외 2개</td>
								<td>REQ001</td>
								<td>둘리</td>								
								<!-- <td>사업상 새 개발용 노트북</td> -->
								<td>2024-07-20</td>
								<td><span class="status-badge status-waited">대기 중</span></td>
							</tr>
							<tr data-id="REQ002">
								<%--<td><input type="checkbox" class="row-checkbox"></td>--%>
								<td>삼성 갤럭시 탭 S9</td>	
								<td>REQ002</td>
								<td>또치</td>										
								<!-- <td>잘못된 모델이 배송되어, 교환 요청.</td> -->
								<td>2024-07-19</td>
								<td><span class="status-badge status-waited">대기 중</span></td>
							</tr>
							<tr data-id="REQ003">
								<%--<td><input type="checkbox" class="row-checkbox"></td>--%>
								<td>로지텍 MX 마스터 3S 마우스</td>
								<td>REQ003</td>
								<td>도우너</td>								
								<!-- <td>더블 클릭 문제, 스크롤 휠 작동 불량.</td> -->
								<td>2024-07-18</td>
								<td><span class="status-badge status-waited">대기 중</span></td>
							</tr>
							<tr class="processed" data-id="REQ003">
								<%--<td><input type="checkbox" class="row-checkbox" disabled></td>--%>
								<td>애플 워치 시리즈 9</td>	
								<td>REQ003</td>
								<td>도우너</td>															
								<!-- 	<td>배터리 수명 기대 이하, 교환 요청.</td> -->
								<td>2025-07-15</td>
								<td><span class="status-badge status-approved">승인됨</span></td>
							</tr>
							<tr class="processed" data-id="REQ005">
								<%--<td><input type="checkbox" class="row-checkbox" disabled></td>--%>
								<td>크롬캐스트 with Google TV</td>	
								<td>REQ005</td>
								<td>고길동</td>															
								<!-- <td>회의실 디스플레이용</td> -->
								<td>2025-10-12</td>
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
	<script src="/assetmanager/resources/js/toDetail.js"></script>
	<script src="/assetmanager/resources/js/notice.js"></script>
</body>
</html>