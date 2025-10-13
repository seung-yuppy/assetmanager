<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매요청 상세</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestDetail.css" rel="stylesheet">
</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>

		<div class="main-content">
			<div class="dashboard-container">
				<div class="content-wrapper">
					<div class="request-title">
						<h2>김성배님의 구매 요청</h2>
						<h2 class="status-badge status-waited">승인 대기</h2>
					</div>
					<div class="request-description">
						<span>입사로 인한 업무 장비 구매</span> /
						<span>2025-10-11</span>
					</div>
					<table class="data-table">
						<thead>
							<tr>
								<th>분류</th>
								<th>품명</th>
								<th>단가</th>
								<th>수량</th>
								<th>총액</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>노트북</td>
								<td>Latitude 7420 노트북</td>
								<td>1,000,000</td>
								<td>2</td>
								<td>2,000,000</td>
							</tr>
							<tr>
								<td>노트북</td>
								<td>Latitude 7420 노트북</td>
								<td>1,000,000</td>
								<td>1</td>
								<td>1,000,000</td>
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
					<div class="action-buttons">
						<button id="rejectBtn" class="btn btn-reject" >거부</button>
						<button id="approveBtn" class="btn btn-approve" >승인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	 -->
<script src="/assetmanager/resources/js/modal.js"></script>

</body>
</html>