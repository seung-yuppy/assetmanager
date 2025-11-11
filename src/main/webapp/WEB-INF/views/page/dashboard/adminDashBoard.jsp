<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/dashboard.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<!-- 0. 페이지 & 사용자 설명 -->
				<div class="home-head">
					<span>${userInfo.deptName}</span>
					<h1>${userInfo.username} ${userInfo.position}님, 안녕하세요!</h1>
				</div>
				<!-- 1. 총 통계 section -->
				<div class="metric-grid">
	                <div class="metric-card border-yellow">
	                	<div class="card-header">
	                		<p class="card-title">총 자산 수</p>
	                		<div class="card-logo-box back-yellow">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_total.svg">
	                		</div>
	                	</div>
	                    <p class="card-value">${totalAsset}개</p>
	                </div>
	                <div class="metric-card border-green">
						<div class="card-header">
	                		<p class="card-title">사용 중</p>   
	                		<div class="card-logo-box back-green">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_using.svg">
	                		</div>
	                	</div>                    
	                    <p class="card-value">${usingAsset}개</p>
	                </div>
	                <div class="metric-card border-gray">
						<div class="card-header">
	                		<p class="card-title">대기 중</p>  
	                		<div class="card-logo-box back-gray">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_repair.svg">
	                		</div>
	                	</div>    
	                    <p class="card-value">${pendingAsset}개</p>
	                </div>
					<div class="metric-card border-red">
						<div class="card-header">
	                		<p class="card-title">불용</p>
	                		<div class="card-logo-box back-red">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_delete.svg">
	                		</div>
	                	</div>
	                    <p class="card-value">${invalidAsset}개</p>
	                </div>
	                <div class="metric-card border-purple">
						<div class="card-header">
							<p class="card-title">추천 제품</p>
	                		<div class="card-logo-box back-purple">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_item.svg">
	                		</div>
	                	</div>   
	                    <p class="card-value">${totalItem}개</p>
	                </div>
	            </div>
				
				<div class="request-grid">
					<div class="section-card">
						<h3>카테고리별 자산 보유 현황</h3>
						<div class="chart-container" style="height: 300px;">
		                    <canvas id="categoryChart"></canvas>
		                </div>
					</div>
		            <div class="section-card">
		                <h3>회사 자산 보유 현황</h3>
		                <div class="doughnut-layout">
		                    <div class="chart-container doughnut-chart-container" style="height: 300px;">
		                        <canvas id="inventoryChart"></canvas>
		                    </div>
		                    <div class="doughnut-summary-container">
		                        <div id="inventory-summary" class="summary-data"></div>
		                        <div id="custom-legend" class="legend-container"></div>
		                    </div>
		                </div>
		            </div> 
				</div>

	            <div class="request-grid">
		            <div class="section-card">
		                <h3>부서별 자산 보유 현황</h3>
		                <div class="chart-container">
		                    <canvas id="departmentChart"></canvas>
		                </div>         
		            </div>
		            <div class="section-card">
				    	<h3>관리자 승인 대기 현황</h3>
				    	<div class="chart-container">
				    		<canvas id="approvalHorizontalBarChart"></canvas>
				    	</div>
					</div>         
	            </div>	        	
	        	            
            </div>			
		</div>
	</div>
	
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>	
	<script src="/assetmanager/resources/js/adminChart.js"></script>
	<script src="/assetmanager/resources/js/notice.js"></script>
</body>
</html>