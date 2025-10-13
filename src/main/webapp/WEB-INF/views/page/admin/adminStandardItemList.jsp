<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>권장 제품 목록</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/dashboard.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>
		<div class="main-content">
			<div class="dashboard-container">
				<h1>권장 제품 목록</h1>
				<span>모든 권장 제품의 목록을 확인하고 관리합니다.</span>
				
				<div class="section-card">
					<div class="button-container">
						<button class="add-button">+ 제품 추가</button>
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
								<th>제품명</th>
								<th>카테고리</th>
								<th>가격</th>
								<th>제조사</th>						
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>LG 그램</td>
								<td>노트북</td>
	                            <td>₩ 900,000</td>
	                            <td>LG</td>
							</tr>
							<tr>
								<td>삼성 갤럭시북</td>
								<td>노트북</td>
	                            <td>₩ 1,000,000</td>
	                            <td>삼성</td>
							</tr>
							<tr>
								<td>LG 그램</td>
								<td>노트북</td>
	                            <td>₩ 900,000</td>
	                            <td>LG</td>
							</tr>
							<tr>
								<td>삼성 갤럭시북</td>
								<td>노트북</td>
	                            <td>₩ 1,000,000</td>
	                            <td>삼성</td>
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
</html>