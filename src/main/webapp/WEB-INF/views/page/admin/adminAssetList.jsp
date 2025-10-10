<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자산 목록</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/dashboard.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminRentList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<div class="dashboard-container">
				<h1>자산 전체  목록</h1>
				<span>모든 자산의 목록을 확인하고 관리합니다.</span>
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
								<th>자산명</th>
								<th>카테고리</th>
								<th>일련번호</th>
								<th>등록일자</th>
								<th>분류</th>
								<th>상태</th>
								<th>상세정보</th>							
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
		                        <td>SRV987654321</td>
		                        <td>2022-11-01</td>
		                        <td><span class="status-badge status-approved">개인</span></td>
								<td><span class="status-badge status-used">사용중</span></td>
								<td><a href="/assetmanager/admin/asset/detail" class="detail-button">상세</a></td>
							</tr>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
	                            <td>SRV987654321</td>
	                            <td>2022-11-01</td>
	                            <td><span class="status-badge status-approved">부서</span></td>
								<td><span class="status-badge status-waited">대기중</span></td>
								<td><a href="/assetmanager/admin/asset/detail" class="detail-button">상세</a></td>
							</tr>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
	                            <td>SRV987654321</td>
	                            <td>2022-11-01</td>
	                            <td><span class="status-badge status-approved">개인</span></td>
								<td><span class="status-badge status-rejected">불용</span></td>
								<td><a href="/assetmanager/admin/asset/detail" class="detail-button">상세</a></td>
							</tr>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
	                            <td>SRV987654321</td>
	                            <td>2022-11-01</td>
	                            <td><span class="status-badge status-approved">부서</span></td>
								<td><span class="status-badge status-used">사용중</span></td>
								<td><a href="/assetmanager/admin/asset/detail" class="detail-button">상세</a></td>
							</tr>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
	                            <td>SRV987654321</td>
	                            <td>2022-11-01</td>
	                            <td><span class="status-badge status-approved">개인</span></td>
								<td><span class="status-badge status-used">사용중</span></td>
								<td><a href="/assetmanager/admin/asset/detail" class="detail-button">상세</a></td>
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