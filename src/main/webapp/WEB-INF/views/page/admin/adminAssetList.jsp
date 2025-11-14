<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자산 목록</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminRentList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>자산 목록</h1>
				<span>모든 자산의 목록을 확인하고 관리합니다.</span>
				<div class="section-card">
					<div class="search-card">
						<div class="filter-controls">
							<div class="status-filter">
								<label for="statusFilter">카테고리:</label>
								<select id="statusFilter" onchange="setBoardParam('categoryId', this.value)">
									<option value="0" ${empty param.categoryId ? 'selected' : ''}>전체</option>
									<option value="1" ${param.categoryId == '1' ? 'selected' : ''}>노트북</option>
									<option value="2" ${param.categoryId == '2' ? 'selected' : ''}>모니터</option>
									<option value="3" ${param.categoryId == '3' ? 'selected' : ''}>태블릿</option>
									<option value="4" ${param.categoryId == '4' ? 'selected' : ''}>스마트폰</option>
									<option value="5" ${param.categoryId == '5' ? 'selected' : ''}>복합기</option>
									<option value="6" ${param.categoryId == '6' ? 'selected' : ''}>데스크탑</option>
									<option value="7" ${param.categoryId == '7' ? 'selected' : ''}>TV</option>
									<option value="8" ${param.categoryId == '8' ? 'selected' : ''}>프로젝터</option>
									<option value="9" ${param.categoryId == '9' ? 'selected' : ''}>기타</option>
								</select>
							</div>
				            <form onsubmit="setBoardParam('keyword', this.keyword.value); return false;">
								<div class="search-box">
									<input type="text" name="keyword" id="assetSearch" placeholder="자산명" class="search-field" value="${param.keyword}">
								    <button type="submit"><img src="/assetmanager/resources/image/icon_search.svg"></button>
								</div>
							</form>
						</div>
					</div>
				
					<table class="data-table">
						<thead>
							<tr>
								<th>자산명</th>
								<th>카테고리</th>
								<th>일련번호</th>
								<th>등록일</th>
								<th>상태</th>						
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty response.content}">
									<tr>
										<td colspan="5" style="text-align: center;">
											<p>데이터가 없습니다.</p>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="asset" items="${response.content}">
										<tr>
											<td><a href="/assetmanager/admin/asset/detail/${asset.id}">${asset.assetName}</a></td>
											<td>${asset.categoryName}</td>
											<td>${asset.serialNumber}</td>
											<td><fmt:formatDate value="${asset.registerDate}" pattern="yyyy-MM-dd"/></td>
											<c:if test="${asset.userId == 0}">
												<td><span class="status-badge status-waited">대기중</span></td>
											</c:if>
											<c:if test="${asset.userId != 0}">
												<td><span class="status-badge status-used">사용중</span></td>
											</c:if>
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