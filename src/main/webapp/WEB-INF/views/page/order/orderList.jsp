<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 구매요청 목록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/modal.css" rel="stylesheet">
<link href="/assetmanager/resources/css/orderList.css" rel="stylesheet">
<%-- 반출 자산 등록 모달 --%>
<link href="/assetmanager/resources/css/assetEntry.css" rel="stylesheet">
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
				                    <option value="all">전체</option>
				                    <option value="PENDING">대기중</option>
				                    <option value="APPROVAL">승인됨</option>
				                    <option value="REJECT">거절됨</option>
				                </select>
				            </div>
				            <div class="search-box">
				                <input type="text" id="assetSearch" placeholder="자산명 검색..." class="search-field">
				                <button onclick="setBoardParam('keyword', document.getElementById('assetSearch').value)"><img src="/assetmanager/resources/image/icon_search.svg"></button>
				            </div>
				        </div>
				    </div>

					<table class="data-table">
						<thead>
							<tr>
								<th>요청 내용</th>
								<th>총액</th>
								<th>요청일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${response.content}">
								<tr data-id="${item.id}">
									<td>${item.title}</td>
									<td>${item.totalPrice}</td>
									<td><fmt:formatDate value="${item.orderDate}" pattern="yyyy-MM-dd" /></td>
									<td>
									  <c:choose>
									    <c:when test="${fn:contains(item.status, 'APPROVED')}">
									      <span class="status-badge status-approved">승인됨</span>
									    </c:when>
									    <c:when test="${fn:contains(item.status, 'REJECT')}">
									      <span class="status-badge status-rejected">반려됨</span>
									    </c:when>
									    <c:otherwise>
									      <span class="status-badge status-waited">대기중</span>
									    </c:otherwise>
									  </c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<c:if test="${response.totalPages > 0 }">
						<nav aria-label="Page navigation example" class="pagination-container">
							<ul class="pagination-list">
								<c:if test="${response.hasPrev}">
									<li class="page-item prev"><a class="page-link"
										onclick="setBoardParam('page', ${response.start - response.blockSize})"
										style="cursor: pointer;"> Previous </a></li>
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
										style="cursor: pointer;"> Next </a></li>
								</c:if>
							</ul>
						</nav>
					</c:if>
				</div>
			</div>
		</div>
	</div>
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
<script src="/assetmanager/resources/js/toDetail.js"></script>
</body>
</html>