<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사원 목록</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>사원 전체  목록</h1>
				<span>모든 사원의 목록을 확인하고 관리합니다.</span>
				<div class="section-card">
					<div class="search-card">
						<div class="filter-controls">
							<div class="status-filter">
								<label for="statusFilter">부서:</label>
								<select id="statusFilter" onchange="setBoardParam('deptId', this.value)">
									<option value="0" ${empty param.deptId ? 'selected' : ''}>전체</option>
									<option value="2" ${param.deptId == '2' ? 'selected' : ''}>공공사업1팀</option>
									<option value="3" ${param.deptId == '3' ? 'selected' : ''}>공공사업2팀</option>
									<option value="4" ${param.deptId == '4' ? 'selected' : ''}>공공사업3팀</option>
									<option value="5" ${param.deptId == '5' ? 'selected' : ''}>공공사업4팀</option>
									<option value="6" ${param.deptId == '6' ? 'selected' : ''}>전략사업1팀</option>
									<option value="7" ${param.deptId == '7' ? 'selected' : ''}>전략사업2팀</option>
									<option value="8" ${param.deptId == '8' ? 'selected' : ''}>영업팀</option>
								</select>
							</div>
				            <form onsubmit="setBoardParam('keyword', this.keyword.value); return false;">
								<div class="search-box">
									<input type="text" name="keyword" id="assetSearch" placeholder="사용자명" class="search-field" value="${param.keyword}">
								    <button type="submit"><img src="/assetmanager/resources/image/icon_search.svg"></button>
								</div>
							</form>
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
							<c:choose>
								<c:when test="${empty response.content}">
									<tr>
										<td colspan="4" style="text-align: center;">
											<p>데이터가 없습니다.</p>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="user" items="${response.content}">
										<tr>
											<td><a href="/assetmanager/admin/user/detail/${user.id}">${user.empNo}</a></td>
											<td>${user.username}</td>
											<td>${user.deptName}</td>
											<td>${user.position}</td>
										</tr>
									</c:forEach>								
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>

					<c:if test="${response.totalPages > 0 }">
						<nav class="pagination-container">
							<ul class="pagination-list">
								<c:if test="${response.hasPrev}">
									<li class="page-item prev"><a class="page-link"
										onclick="setBoardParam('page', ${response.start - response.blockSize})"
										style="cursor: pointer;"> ← </a></li>
								</c:if>
				
								<c:forEach var="num" begin="${response.start}" end="${response.end}">
									<c:choose>
										<c:when test="${num == response.page}">
											<li class="page-item active"><a class="page-link"
												onclick="setBoardParam('page', ${num})" style="cursor: pointer;">
													${num} </a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link"
												onclick="setBoardParam('page', ${num})" style="cursor: pointer;">
													${num} </a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
				
								<c:if test="${response.hasNext}">
									<li class="page-item next"><a class="page-link"
										onclick="setBoardParam('page', ${response.end + 1})"
										style="cursor: pointer;"> → </a></li>
								</c:if>
							</ul>
						</nav>
					</c:if>
			
				</div>
			</div>
		</div>	
	</div>
	
	<script src="/assetmanager/resources/js/pageFilter.js"></script>
</body>
</html>