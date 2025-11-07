<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자산 목록</title>
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
				<c:if test="${userInfo.role == 'employee'}">
					<h1>사용중인 내 자산 목록</h1>		
					<span>사용중인 나의 모든 자산 목록을 확인하고 관리합니다.</span>
				</c:if>
				<c:if test="${userInfo.role == 'department'}">
					<h1>사용중인 내 부서 자산 목록</h1>		
					<span>사용중인 나의 모든 부서 자산 목록을 확인하고 관리합니다.</span>
				</c:if>
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
							<div class="search-box">
								<input type="text" id="assetSearch" placeholder="품목명 검색" class="search-field">
								<button onclick="setBoardParam('keyword', document.getElementById('assetSearch').value)"><img src="/assetmanager/resources/image/icon_search.svg" alt="검색"></button>
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
								<th></th>			
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty response.content}">
				                	<tr>
				                		<td colspan="6" style="text-align: center;">
				               				<p>데이터가 없습니다.</p>
			                			</td>
			                		</tr>	                	
	                			</c:when>
	                			<c:otherwise>
									<c:forEach var="asset" items="${response.content}">
										<tr class="asset-box" data-id="${asset.assetId}">
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
											<td>
					                        	<div class="table-button-container">
					                        		<c:if test="${asset.activeBtn == false}">
						                        		<c:if test="${asset.returnDate != null}">
						                       				<button class="delay-button" onclick="location.href='/assetmanager/asset/extension/form'">연장</button>
						                       			</c:if>
						                       			<button class="return-button">반납</button>					                        		
					                        		</c:if>
					                       		</div>
					                       		<div class="table-button-container">
					                        		<c:if test="${asset.activeBtn == true}">
						                        		반납처리중                        		
					                        		</c:if>
					                       		</div>
					                        </td>
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
	
	<script src="/assetmanager/resources/js/pageFilter.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="/assetmanager/resources/js/returnAsset.js"></script>
</body>
</html>