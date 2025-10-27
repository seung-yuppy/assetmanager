<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
								<th>반납예정일</th>
								<th>분류</th>		
								<th></th>			
							</tr>
						</thead>
						<tbody>
							<c:forEach var="asset" items="${list}">
								<tr>
									<td>${asset.assetName}</td>
									<td>${asset.categoryName}</td>
									<td>${asset.serialNumber}</td>
									<td><fmt:formatDate value="${asset.createDate}" pattern="yyyy-MM-dd"/></td>
									<c:if test="${asset.returnDate != null}">
										<td><fmt:formatDate value="${asset.returnDate}" pattern="yyyy-MM-dd"/></td>
									</c:if>
									<c:if test="${asset.returnDate == null}">
										<td>-</td>
									</c:if>				
									<td>개인</td>
									<td>
			                        	<div class="table-button-container">
			                        		<c:if test="${asset.returnDate != null}">
			                       				<button class="delay-button" onclick="location.href='/assetmanager/asset/extension/form'">연장</button>
			                       			</c:if>
			                       			<button class="return-button">반납</button>
			                       		</div>
			                        </td>
								</tr>
							</c:forEach>
						</tbody>
					</table>

					<nav class="pagination-container">
						<ul class="pagination-list">
							<c:choose>
					            <c:when test="${hasPrev}">
					                <li class="page-item prev">
					                    <a class="page-link" href="<c:url value='/admin/asset/list?page=${startPage - 1}'/>">
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
					                        <a class="page-link" href="<c:url value='/admin/asset/list?page=${i}'/>">
					                            ${i}
					                        </a>
					                    </li>
					                </c:otherwise>
					            </c:choose>
					        </c:forEach>
					
					        <c:choose>
					            <c:when test="${hasNext}">
					                <li class="page-item next">
					                    <a class="page-link" href="<c:url value='/admin/asset/list?page=${endPage + 1}'/>">
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