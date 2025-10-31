<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반출 요청 목록</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/sideMenu.css" rel="stylesheet">
<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
<%-- 반출 자산 등록 모달 --%>
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
				<h1>반출 요청 목록</h1>
				<span>현재 처리 중인 모든 반출 요청의 목록을 확인하고 관리합니다.</span>

				<div class="section-card">
					<div class="header-controls">
						<div class="filter-controls">
							<div class="status-filter">
								<label for="statusFilter">상태:</label>
				                <select id="statusFilter" onchange="setBoardParam('status', this.value)">
				                    <option value="" ${empty param.status ? 'selected' : ''}>전체</option>
								    <option value="PENDING" ${param.status == 'PENDING' ? 'selected' : ''}>대기중</option>
								    <option value="FIRST_APPROVAL" ${param.status == 'FIRST_APPROVAL' ? 'selected' : ''}>처리중</option>
								    <option value="FINAL_APPROVAL" ${param.status == 'FINAL_APPROVAL' ? 'selected' : ''}>승인됨</option>
								    <option value="REJECT" ${param.status == 'REJECT' ? 'selected' : ''}>거절됨</option>
				                </select>
							</div>
							<div class="search-box">
								<input type="text" id="assetSearch" placeholder="품목명 검색" class="search-field">
								<button>
									<img src="/assetmanager/resources/image/icon_search.svg" alt="검색">
								</button>
							</div>
						</div>
					</div>

					<table class="data-table">
						<thead>
							<tr>
								<th>요청  내용</th>
								<th>요청일</th>
								<th>반납 예정일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
                                <c:when test="${empty rentList}">
                                    <tr>
                                        <td colspan="4" style="text-align: center; padding: 20px;">요청 내역이 존재하지 않습니다.</td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="rent" items="${rentList}">
                                        <tr data-id="${rent.id}"> 
                                        <td>${rent.title}</td>                                           
                                            <td><fmt:formatDate value="${rent.rentDate}" pattern="yyyy-MM-dd" /></td>
                                            <td><fmt:formatDate value="${rent.returnDate}" pattern="yyyy-MM-dd" /></td>                            
                                            <td><span class="status-badge status-${rent.status.badgeType}">${rent.status.koreanName}</span></td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
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
	<script src="/assetmanager/resources/js/rent.js"></script>
	<script src="/assetmanager/resources/js/toDetail.js"></script>
</body>
</html>