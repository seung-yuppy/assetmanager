<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반출요청 상세</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestDetail.css" rel="stylesheet">

</head>
<body>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<div class="main-content">
			<div class="dashboard-container">
				<div class="content-wrapper">
					<div class="request-title">
						<h2>둘리님의 반출 요청</h2>
						<h2 class="status-badge status-waited">승인 대기</h2>
					</div>
					<div class="request-description">
						<span>입사로 인한 업무 장비 구매</span>
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
					
				</div>
			</div>
		</div>
	</div>
<script src="/assetmanager/resources/js/modal.js"></script>

</body>
</html>