<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 구매요청 목록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/adminList.css" rel="stylesheet">
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>

		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>구매 요청 목록</h1>
				<span style="font-size: 1rem; color: var(--gray-color);">현재 처리 중인 모든 구매 요청의 목록을 확인하고 관리합니다.</span>

				<div class="section-card">
					<div class="header-controls" style="margin-bottom:20px;">
				        <div class="filter-controls">
				            <div class="status-filter">
				                <label for="statusFilter">상태:</label>
				                <select id="statusFilter" onchange="applyFilter()">
				                    <option value="all">전체</option>
				                    <option value="waited">승인 대기</option>
				                    <option value="approved">승인 완료</option>
				                    <option value="rejected">반려</option>
				                    <option value="using">등록 완료</option>
				                </select>
				            </div>
				            <div class="search-box">
				                <input type="text" id="assetSearch" placeholder="요청자 검색" class="search-field">
				                <button onclick="applySearch()"><img src="/assetmanager/resources/image/icon_search.svg"></button>
				            </div>
				        </div>
				    </div>

					<table class="data-table">
						<thead>
							<tr>
								<th>품목명</th>
								<th>부서</th>
								<th>요청자</th>
								<th>요청일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Latitude 7420 노트북 등 2개</td>
								<td>공공사업1팀</td>
								<td>김성배</td>
								<td>2023-01-27</td>
								<td><span class="status-badge status-waited">대기중</span></td>
							</tr>
							<tr>
								<td>Latitude 7420 노트북 등 2개</td>
								<td>공공사업1팀</td>
								<td>강예나</td>
								<td>2023-01-27</td>
								<td><span class="status-badge status-rejected">거부됨</span></td>
							</tr>

							<tr>
								<td>Latitude 7420 노트북 등 2개</td>
								<td>공공사업1팀</td>
								<td>강예나</td>
								<td>2023-01-15</td>
								<td><span class="status-badge status-approved">승인됨</span></td>
							</tr>
							
							<tr>
								<td>Latitude 7420 노트북 등 2개</td>
								<td>공공사업1팀</td>
								<td>강예나</td>
								<td>2023-01-15</td>
								<td><span class="status-badge status-approved">승인됨</span></td>
							</tr>
							
							<tr>
								<td>Latitude 7420 노트북 등 2개</td>
								<td>공공사업1팀</td>
								<td>강예나</td>
								<td>2023-01-15</td>
								<td><span class="status-badge status-approved">승인됨</span></td>
							</tr>
						</tbody>
					</table>
					<nav class="pagination-container">
						<ul class="pagination-list">
							<li class="page-item prev">
								<a class="page-link" onclick="setBoardParam('page', '이전_페이지_번호')" style="cursor: pointer;"> <span style="font-size: 14px;">&lt;</span>이전</a>
							</li>
				
							<li class="page-item active"><a class="page-link"
								onclick="setBoardParam('page', 1)" style="cursor: pointer;"> 1
							</a></li>
				
							<li class="page-item">
								<a class="page-link" onclick="setBoardParam('page', 2)" style="cursor: pointer;"> 2</a>
							</li>
				
							<li class="page-item"><a class="page-link"
								onclick="setBoardParam('page', 3)" style="cursor: pointer;"> 3
							</a></li>
				
							<li class="page-item next"><a class="page-link"
								onclick="setBoardParam('page', '다음_페이지_번호')"
								style="cursor: pointer;"> 다음 <span style="font-size: 14px;">&gt;</span>
							</a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
<script src="/assetmanager/resources/js/toDetail.js"></script>
<script>
	function setBoardParam(key, value) {
		  const url = new URL(window.location.href); 
		  url.searchParams.delete('page');
		  if (value != null){
			  url.searchParams.set(key, value);  // 기존 query 유지하면서 order만 세팅
		  }else{
			  url.searchParams.delete(key);
		  }
		  window.location.href = url.toString(); // url로 이동
	}
</script>
</body>
</html>