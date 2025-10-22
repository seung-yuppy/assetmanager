<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 상세</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminAssetDetail.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>배고파 사원님의 상세정보</h1>
				<div class="detail-header">
					<span>개발팀(진천)</span>
				</div>
		        <!-- 자산 정보 시작 -->
				<div class="section-card">
	                <h2>사용자 자산 히스토리</h2>
		            <table class="data-table">
		                <thead>
		                    <tr>
		                    	<th>자산명</th>
		                        <th>카테고리</th>
		                        <th>사용 시작</th>
		                        <th>사용 끝</th>
		                        <th>분류</th>
		                        <th>상태</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr>
		                        <td>LG그램</td>
		                        <td>노트북</td>
		                        <td>2025-10-10</td>
		                        <td>현재</td>
		                        <td><span class="status-badge status-approved">개인</span></td>                        
		                        <td><span class="status-badge status-used">사용중</span></td>
		                    </tr>
		                    <tr>
		                        <td>LG그램</td>
		                        <td>노트북</td>
		                        <td>2025-10-10</td>
		                        <td>현재</td>
		                        <td><span class="status-badge status-approved">개인</span></td>                        
		                        <td><span class="status-badge status-rejected">반납</span></td>
		                    </tr>
		                    <tr>
		                        <td>LG그램</td>
		                        <td>노트북</td>
		                        <td>2025-10-10</td>
		                        <td>현재</td>
		                        <td><span class="status-badge status-approved">개인</span></td>                        
		                        <td><span class="status-badge status-rejected">반납</span></td>
		                    </tr>
		                    <tr>
		                        <td>LG그램</td>
		                        <td>노트북</td>
		                        <td>2025-10-10</td>
		                        <td>현재</td>
		                        <td><span class="status-badge status-approved">개인</span></td>                        
		                        <td><span class="status-badge status-rejected">반납</span></td>
		                    </tr>
		                    <tr>
		                        <td>LG그램</td>
		                        <td>노트북</td>
		                        <td>2025-10-10</td>
		                        <td>현재</td>
		                        <td><span class="status-badge status-approved">개인</span></td>                        
		                        <td><span class="status-badge status-rejected">반납</span></td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        <!-- 자산 정보 끝 -->
			</div>
		</div>
	</div>
</body>
</html>