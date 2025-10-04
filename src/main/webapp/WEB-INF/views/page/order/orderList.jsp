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
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<div class="main-content">
			<div class="dashboard-container">
				<h1>직원 구매요청 목록</h1>
				<span>현재 처리 중인 모든 구매 요청의 목록을 확인하고 관리합니다.</span>

				<div class="section-card">
					<div class="header-controls">
				        <h2>최근 구매 요청</h2>
				
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
				                <input type="text" id="assetSearch" placeholder="자산명 검색..." class="search-field">
				                <button onclick="applySearch()"><img src="/assetmanager/resources/image/icon_search.svg"></button>
				            </div>
				        </div>
				    </div>

					<table class="data-table">
						<thead>
							<tr>
								<th>자산명</th>
								<th>가격</th>
								<th>요청 사유</th>
								<th>요청일</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Latitude 7420 노트북</td>
								<td>100,0000</td>
								<td>신입 사원 노트북 배정</td>
								<td>2023-01-15</td>
								<td><span class="status-badge status-waited">승인 대기</span></td>
							</tr>
							<tr>
								<td>Latitude 7420 노트북</td>
								<td>100,0000</td>
								<td>신입 사원 노트북 배정</td>
								<td>2023-01-15</td>
								<td><span class="status-badge status-waited">승인 대기</span></td>
							</tr>
							<tr>
								<td>Latitude 7420 노트북</td>
								<td>100,0000</td>
								<td>신입 사원 노트북 배정</td>
								<td>2023-01-15</td>
								<td><span class="status-badge status-rejected" data-toggle="modal" data-target="rejectDetailModal">반려</span></td>
							</tr>
							<tr>
								<td>Latitude 7420 노트북</td>
								<td>100,0000</td>
								<td>신입 사원 노트북 배정</td>
								<td>2023-01-15</td>
								<td><span class="status-badge status-approved" data-toggle="modal" data-target="serialRegisterModal" >승인 완료</span></td>
							</tr>
							<tr>
								<td>Latitude 7420 노트북</td>
								<td>100,0000</td>
								<td>신입 사원 노트북 배정</td>
								<td>2023-01-15</td>
								<td><span class="status-badge status-waited">등록 완료</span></td>
							</tr>
							<tr>
								<td>Latitude 7420 노트북</td>
								<td>100,0000</td>
								<td>신입 사원 노트북 배정</td>
								<td>2023-01-15</td>
								<td><span class="status-badge status-waited">등록 완료</span></td>
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
	<!-- 모달 -->
	<div id="serialRegisterModal" class="custom-modal-backdrop">
	    <div class="custom-modal-content">
	        <div class="modal-header">
	            <h3>일련번호 등록</h3>
	            <button class="modal-close-btn">&times;</button> 
	        </div>
	        <div class="modal-body">
	            </div>
	        <div class="modal-footer">
	            <button class="secondary-action">취소</button>
	            <button class="primary-action" onclick="registerSerial()">등록하기</button>
	        </div>
	    </div>
	</div>
	
	<div id="rejectDetailModal" class="custom-modal-backdrop">
	    <div class="custom-modal-content">
	        <div class="modal-header">
	            <h3>반려 사유</h3>
	            <button class="modal-close-btn">&times;</button> 
	        </div>
	        <div class="modal-body">
	            </div>
	        <div class="modal-footer">
	            <button class="secondary-action">닫기</button>
	        </div>
	    </div>
	</div>

	<!-- JSTL 적용
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
	
	 -->
<script src="/assetmanager/resources/js/modal.js"></script>
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