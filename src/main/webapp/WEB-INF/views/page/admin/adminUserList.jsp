<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 목록</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>사용자 전체  목록</h1>
				<span>모든 사용자의 목록을 확인하고 관리합니다.</span>
				<div class="section-card">
					<div class="search-card">
						<div class="filter-controls">
							<div class="status-filter">
								<label for="statusFilter">카테고리:</label>
								<select id="statusFilter">
									<option value="all">전체</option>
									<option value="1">개발팀</option>
									<option value="2">마케팅팀</option>
									<option value="3">인사팀</option>
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
								<th>사번</th>
								<th>사용자명</th>
								<th>부서</th>
								<th>직급</th>						
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>AMS1001</td>
								<td>배고파</td>
		                        <td>개발팀</td>
		                        <td>사원</td>
							</tr>
							<tr>
								<td>AMS1002</td>
								<td>힘들다</td>
		                        <td>마케팅팀</td>
		                        <td>사원</td>
							</tr>
							<tr>
								<td>AMS1003</td>
								<td>집가자</td>
		                        <td>인사팀</td>
		                        <td>사원</td>
							</tr>
							<tr>
								<td>AMS1004</td>
								<td>집가자</td>
		                        <td>인사팀</td>
		                        <td>사원</td>
							</tr>
							<tr>
								<td>AMS1005</td>
								<td>집가자</td>
		                        <td>인사팀</td>
		                        <td>사원</td>
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
	<script src="/assetmanager/resources/js/toDetail.js"></script>
</body>
</html>