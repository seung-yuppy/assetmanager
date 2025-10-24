<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
								<th>스펙</th>
								<th>가격</th>
								<th>제조사</th>
								<th>거래처</th>	
								<th>삭제</th>				
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${list}">
								<tr>
									<td>${item.itemName}</td>
									<td>${item.category}</td>
									<td>${item.spec}</td> 
		                            <td>₩ ${item.price}</td>
		                            <td>${item.maker}</td>
		                            <td>${item.seller}</td>
		                            <td><img src="/assetmanager/resources/image/icon_delete.svg" class="icon-delete"></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>			
					<nav class="pagination-container">
						<ul class="pagination-list">
							<c:choose>
					            <c:when test="${hasPrev}">
					                <li class="page-item prev">
					                    <a class="page-link" href="<c:url value='/admin/item/list?page=${startPage - 1}'/>">
					                        &lt; 이전
					                    </a>
					                </li>
					            </c:when>
					            <c:otherwise>
					                <li class="page-item prev disabled">
					                    <span class="page-link">&lt; 이전</span>
					                </li>
					            </c:otherwise>
					        </c:choose>
					
					        <c:forEach var="i" begin="${startPage}" end="${endPage}">
					            <c:choose>
					                <c:when test="${i == currentPage}">
					                    <li class="page-item active">
					                        <span class="page-link">${i}</span>
					                    </li>
					                </c:when>
					                <c:otherwise>
					                    <li class="page-item">
					                        <a class="page-link" href="<c:url value='/admin/item/list?page=${i}'/>">
					                            ${i}
					                        </a>
										</li>
					                </c:otherwise>
					            </c:choose>
							</c:forEach>			
					        <c:choose>
							<c:when test="${hasNext}">
					            	<li class="page-item next">
					                    <a class="page-link" href="<c:url value='/admin/item/list?page=${endPage + 1}'/>">
					                         다음 &gt;
					                    </a>
					                </li>
					            </c:when>
					            <c:otherwise>
					                <li class="page-item next disabled">
					                    <span class="page-link">다음 &gt;</span>
					                </li>
					            </c:otherwise>
					        </c:choose>
						</ul>	
					</nav>
					
							
				</div>
			</div>
		</div>
	</div>
</body>
</html>