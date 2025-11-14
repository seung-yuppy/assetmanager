<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연장 승인 목록</title>
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
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>		
			<div class="dashboard-container">
				<h1>연장 요청 목록</h1>
				<span>현재 처리 중인 모든 연장 요청의 목록을 확인하고 관리합니다.</span>

				<div class="section-card">
					<div class="search-card">
						<div class="filter-controls">
							<div class="status-filter">
								<label for="statusFilter">상태:</label>
				                <select id="statusFilter" onchange="setBoardParam('status', this.value)">
				                    <option value="" ${empty param.status ? 'selected' : ''}>전체</option>
				                    <c:if test="${userInfo.role == 'admin'}">
				                    	<option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>대기중</option>
				                    </c:if>				
								    <option value="FIRST_APPROVAL" ${param.status == 'FIRST_APPROVAL' ? 'selected' : ''}>처리중</option>
								    <option value="FINAL_APPROVAL" ${param.status == 'FINAL_APPROVAL' ? 'selected' : ''}>승인됨</option>
								    <option value="REJECT" ${param.status == 'REJECT' ? 'selected' : ''}>반려됨</option>
				                </select>
							</div>
							<form onsubmit="setBoardParam('keyword', this.keyword.value); return false;">
								<div class="search-box">
									<input type="text" name="keyword" id="assetSearch" placeholder="요청자" class="search-field" value="${param.keyword}">
									<button>
										<img src="/assetmanager/resources/image/icon_search.svg" alt="검색">
									</button>
								</div>
							</form>
						</div>
					</div>
					<table class="data-table">
						<thead>
							<tr>
								<th>요청 내용</th>	
								<th>요청자</th>	
								<th>부서</th>													
								<th>요청일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty response.content}">
						        <tr>
						            <td colspan="5" style="text-align: center; padding: 20px;">데이터가 없습니다.</td>
						        </tr>
						    </c:if>
							<c:forEach var="item" items="${response.content}">
								<tr data-id="${item.id}">
									<td><a href="detail/${item.id}">${item.title}</a></td>
									<td><a href="/assetmanager/admin/user/detail/${item.userId}">${item.username}</a></td>
									<td>${item.deptName}</td>									
									<td><fmt:formatDate value="${item.rentDate}" pattern="yyyy-MM-dd" /></td>
									<c:if test="${userInfo.role == 'admin'}">
										<td>
											<span class="status-badge status-${item.status.badgeType}">${item.status.koreanName}</span>
										</td>
									</c:if>
									<c:if test="${userInfo.role == 'manager' && item.status == 'FIRST_APPROVAL'}">
										<td>
											<span class="status-badge status-waited">대기중</span>
										</td>
									</c:if>
									<c:if test="${userInfo.role == 'manager' && item.status == 'FINAL_APPROVAL'}">
										<td>
											<span class="status-badge status-approved">승인됨</span>
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:if test="${response.totalPages > 0 }">
						<nav class="pagination-container">
							<ul class="pagination-list">
								<c:if test="${response.hasPrev}">
									<li class="page-item prev">
									<a class="page-link" onclick="setBoardParam('page', ${response.start - response.blockSize})" style="cursor: pointer;"> ← </a></li>
								</c:if>

								<c:forEach var="num" begin="${response.start}" end="${response.end}">
									<c:choose>
										<c:when test="${num == response.page}">
											<li class="page-item active">
											<a class="page-link" onclick="setBoardParam('page', ${num})" style="cursor: pointer;"> ${num} </a></li>
										</c:when>
										<c:otherwise>
											<li class="page-item">
											<a class="page-link" onclick="setBoardParam('page', ${num})" style="cursor: pointer;"> ${num} </a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>

								<c:if test="${response.hasNext}">
									<li class="page-item next">
									<a class="page-link" onclick="setBoardParam('page', ${response.end + 1})" style="cursor: pointer;"> → </a></li>
								</c:if>
							</ul>
						</nav>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<script src="/assetmanager/resources/js/notice.js"></script>
	<script src="/assetmanager/resources/js/pageFilter.js"></script>
</body>
</html>