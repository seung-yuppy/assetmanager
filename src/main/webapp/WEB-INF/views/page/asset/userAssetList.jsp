<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>내 자산 목록</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>사용중인 내 자산 목록</h1>
				<span>사용중인 나의 모든 자산 목록을 확인하고 관리합니다.</span>
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
								<th>취득일</th>
								<th>반납일</th>
								<th>분류</th>		
								<th></th>			
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
		                        <td>SRV987654321</td>
		                        <td>2024-11-01</td>
		                        <td>2025-11-01</td>
		                        <td>개인</td>
		                        <td>
		                        	<div class="table-button-container">
		                       			<button class="delay-button" onclick="location.href='/assetmanager/asset/extension/form'">연장</button>
		                       			<button class="return-button">반납</button>
		                       		</div>
		                        </td>
							</tr>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
		                        <td>SRV987654321</td>
		                        <td>2024-11-01</td>
		                        <td>2025-11-01</td>
		                        <td>개인</td>
		                        <td>
		                        	<div class="table-button-container">
		                       			<button class="delay-button" onclick="location.href='/assetmanager/asset/extension/form'">연장</button>
		                       			<button class="return-button">반납</button>
		                       		</div>
		                        </td>
							</tr>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
		                        <td>SRV987654321</td>
		                        <td>2024-11-01</td>
		                        <td>N/A</td>
		                        <td>부서</td>		                        
							</tr>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
		                        <td>SRV987654321</td>
		                        <td>2024-11-01</td>
		                        <td>2025-11-01</td>
		                        <td>개인</td>
		                        <td>
		                        	<div class="table-button-container">
		                       			<button class="delay-button" onclick="location.href='/assetmanager/asset/extension/form'">연장</button>
		                       			<button class="return-button">반납</button>
		                       		</div>
		                        </td>		                        
							</tr>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
		                        <td>SRV987654321</td>
		                        <td>2024-11-01</td>
		                        <td>N/A</td>
		                        <td>개인</td>
		                        <td>
		                        	<div class="table-button-container">
		                       			<button class="return-button">반납</button>
		                       		</div>
		                        </td>		                        
							</tr>
							<tr>
								<td>LG 그램 노트북</td>
								<td>노트북</td>
		                        <td>SRV987654321</td>
		                        <td>2024-11-01</td>
		                        <td>2025-11-01</td>
		                        <td>부서</td>	                        
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