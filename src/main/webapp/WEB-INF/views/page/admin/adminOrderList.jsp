<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 구매요청 목록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>구매 요청 목록</h1>
				<span>현재 처리 중인 모든 구매 요청의 목록을 확인하고 관리합니다.</span>
				<div class="section-card">
					<div class="header-controls">
				        <div class="filter-controls">
				            <div class="status-filter">
				                <label for="statusFilter">상태:</label>
				                <select id="statusFilter" onchange="setBoardParam('status', this.value)">
				                    <option value="" ${empty param.status ? 'selected' : ''}>전체</option>
								    <c:if test="${userInfo.role != 'manager'}">
									    <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>대기중</option>
								    </c:if>
								    <option value="FIRST_APPROVAL" ${param.status == 'FIRST_APPROVAL' ? 'selected' : ''}>${userInfo.role == 'manager' ? '대기중':'처리중'}</option>
								    <option value="FINAL_APPROVAL" ${param.status == 'FINAL_APPROVAL' ? 'selected' : ''}>승인됨</option>
								    <option value="REJECT" ${param.status == 'REJECT' ? 'selected' : ''}>거절됨</option>
				                </select>
				            </div>
				            <div class="search-box">
				                <input type="text" id="assetSearch" placeholder="요청자" class="search-field">
				                <button onclick="setBoardParam('keyword', document.getElementById('assetSearch').value)"><img src="/assetmanager/resources/image/icon_search.svg"></button>
				            </div>
				        </div>
				    </div>

					<table class="data-table">
						<thead>
							<tr>
								<th>요청 내용</th>
								<th>요청자</th>
								<th>부서</th>
								<th>요청일</th>
								<th>총액(₩)</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty response.content}">
									<tr>
                                        <td colspan="6" style="text-align: center; padding: 20px;">데이터가 없습니다.</td>
                                    </tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="item" items="${response.content}">
										<tr data-id="${item.id}">
											<td><a href="detail/${item.id}">${item.title}</a></td>
											<td><a href="/assetmanager/admin/user/detail/${item.userId}">${item.username}</a></td>
											<td>${item.deptName}</td>
											<td><fmt:formatDate value="${item.orderDate}" pattern="yyyy-MM-dd" /></td>
											<td><fmt:formatNumber value="${item.totalPrice}" type="number"/></td>
											<td><span class="status-badge status-${item.status.badgeType}">${userInfo.role == 'manager' ? '대기중':item.status.koreanName}</span></td>
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