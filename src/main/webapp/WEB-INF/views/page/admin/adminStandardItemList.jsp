<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>권장 제품 목록</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>		
			<div class="dashboard-container">
				<h1>권장 제품 목록</h1>
				<span>모든 권장 제품의 목록을 확인하고 관리합니다.</span>
				
				<div class="section-card">
					<div class="button-container">
						<button class="add-button" onclick="location.href='/assetmanager/admin/item/form'">+ 제품 추가</button>
						<button class="negative-button">제품 삭제</button>
					</div>
				
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
								<th><input type="checkbox" id="checkAll"></th>
								<th>제품명</th>
								<th>카테고리</th>
								<th>스펙</th>
								<th>가격</th>
								<th>제조사</th>
								<th>거래처</th>					
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="checkbox" class="rowCheck"></td>
								<td>LG 그램</td>
								<td>노트북</td>
								<td>CPU	Ultra 7 255H, 램	16GB, 화면크기	39.6cm(15.6인치), 해상도 1920x1080(FHD)</td> 
	                            <td>₩ 900,000</td>
	                            <td>LG</td>
	                            <td>업체명1</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="rowCheck"></td>
								<td>삼성 갤럭시북</td>
								<td>노트북</td>
								<td>CPU	Ultra 5 226V, 램	16GB, 화면크기	35.6cm(14인치), 해상도	2880x1800(WQXGA)</td>
	                            <td>₩ 1,000,000</td>
	                            <td>삼성</td>
	                            <td>업체명2</td>
							</tr>
							<tr>
								<td><input type="checkbox" class="rowCheck"></td>
								<td>LG 그램</td>
								<td>노트북</td>
								<td>CPU	Ultra 7 255H, 램	16GB, 화면크기	39.6cm(15.6인치), 해상도 1920x1080(FHD)</td> 
	                            <td>₩ 900,000</td>
	                            <td>LG</td>
	                            <td>업체명1</td>
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
</body>
<script>
	const checkAll = document.getElementById('checkAll');
	const checkboxes = document.querySelectorAll('.rowCheck');
	
	// 전체 선택 클릭 시 → 모든 체크박스 변경
	checkAll.addEventListener('change', () => {
	  checkboxes.forEach(cb => cb.checked = checkAll.checked);
	});
	
	// 개별 체크 상태가 바뀔 때 → 전체 선택 여부 갱신
	checkboxes.forEach(cb => {
	  cb.addEventListener('change', () => {
	    const allChecked = Array.from(checkboxes).every(c => c.checked);
	    checkAll.checked = allChecked;
	  });
	});
</script>
</html>