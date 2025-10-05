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
			<div class="dashboard-container">
				<!-- 0. 페이지 & 사용자 설명 -->
				<div class="home-head">
					<span>경영 지원팀</span>
					<h1>관리자님, 안녕하세요!</h1>
				</div>
			
			
				<!-- 1. 총 통계 section -->
				<div class="metric-grid">
	                <div class="metric-card border-green">
	                	<div class="card-header">
	                		<p class="card-title">총 자산 수</p>
	                		<div class="card-logo-box back-green">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_total.svg">
	                		</div>
	                	</div>
	                    <p class="card-value">1200</p>
	                </div>
	                <div class="metric-card border-yellow">
						<div class="card-header">
	                		<p class="card-title">사용 중</p>   
	                		<div class="card-logo-box back-yellow">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_using.svg">
	                		</div>
	                	</div>                    
	                    <p class="card-value">1170</p>
	                </div>
	                <div class="metric-card border-gray">
						<div class="card-header">
	                		<p class="card-title">창고 보관 중</p>  
	                		<div class="card-logo-box back-gray">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_repair.svg">
	                		</div>
	                	</div>    
	                    <p class="card-value">20</p>
	                </div>
					<div class="metric-card border-red">
						<div class="card-header">
	                		<p class="card-title">반납 / 불용</p>
	                		<div class="card-logo-box back-red">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_delete.svg">
	                		</div>
	                	</div>
	                    <p class="card-value">10</p>
	                </div>
	                <div class="metric-card border-purple">
						<div class="card-header">
							<p class="card-title">반출 요청</p>
	                		<div class="card-logo-box back-purple">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_alarm.svg">
	                		</div>
	                	</div>   
	                    <p class="card-value">13</p>
	                </div>
	                <div class="metric-card border-blue">
						<div class="card-header">
	                		<p class="card-title">구매 요청</p> 
	                		<div class="card-logo-box back-blue">
	                			<img class="card-logo" src="/assetmanager/resources/image/icon_alarm.svg">
	                		</div>
	                	</div>                    
	                    <p class="card-value">15</p>
	                </div>
	            </div>
            
	            <!-- 2. 요청 리스트 section -->
		        <div class="request-grid">
		        	<!-- 2-1. 반출 요청 -->
		            <div class="section-card">
		                <h3>반출 요청</h3>
		                <table class="data-table">
		                    <thead>
		                        <tr>
		                            <th>자산명</th>
		                            <th>요청일</th>
		                            <th>상태</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <tr>
		                            <td>iPad Pro</td>
		                            <td>2024-06-10</td>
		                            <td><span class="status-badge status-waited">대기중</span></td>
		                        </tr>
		                        <tr>
		                            <td>웹캠 C920</td>
		                            <td>2024-05-20</td>
		                            <td><span class="status-badge status-rejected">거절됨</span></td>
		                        </tr>
		                        <tr>
		                            <td>외장 SSD</td>
		                            <td>2024-05-05</td>
		                            <td><span class="status-badge status-approved">승인됨</span></td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
	
		            <!-- 2-2. 구매 요청 -->
		            <div class="section-card">
		                <h3>구매 요청</h3>
		                <table class="data-table">
		                    <thead>
		                        <tr>
		                            <th>자산명</th>
		                            <th>요청일</th>
		                            <th>상태</th>
		                        </tr>
		                    </thead>
		                    <tbody>
		                        <tr>
		                            <td>에르고 휴먼 의자</td>
		                            <td>2024-06-12</td>
		                            <td><span class="status-badge status-waited">대기중</span></td>
		                        </tr>
		                        <tr>
		                            <td>Adobe Creative Cloud</td>
		                            <td>2024-05-25</td>
		                            <td><span class="status-badge status-rejected">거절됨</span></td>
		                        </tr>
		                        <tr>
		                            <td>초고속 무선 마우스</td>
		                            <td>2024-05-15</td>
		                            <td><span class="status-badge status-approved">승인됨</span></td>
		                        </tr>
		                    </tbody>
		                </table>
		            </div>
	        	</div>

	            <!-- 3. 통계 자료 section -->
	            <div class="request-grid">
		            <!-- 부서별 자산 현황 - Bar Chart (Chart.js) -->
		            <div class="section-card">
		                <h3>부서별 자산 보유 현황</h3>
		                <div class="chart-container">
		                    <!-- 캔버스 ID: departmentChart -->
		                    <canvas id="departmentChart"></canvas>
		                </div>         
		            </div>
		            
			        <!-- 창고 자산 유무 - Donut Chart (Chart.js) -->
		            <div class="section-card">
		                <h3>창고 자산 보유 현황</h3>
		                <div class="chart-legend-wrapper">
		                    <!-- 캔버스 ID: inventoryChart -->
		                    <div style="position: relative; width: 10rem; height: 10rem;">
		                        <canvas id="inventoryChart"></canvas>
		                    </div>
		
		                    <!-- 범례 (Legend) - Chart.js 범례를 덮어쓰기 위해 수동 구현 -->
		                    <div style="margin-top: 1rem; margin-left: 2rem;">
		                        <div class="legend-item">
		                            <span class="legend-color back-green"></span>
		                            <span>사용 가능 재고 (65%)</span>
		                        </div>
		                        <div class="legend-item">
		                            <span class="legend-color back-blue"></span>
		                            <span>사용 중인 재고(20%)</span>
		                        </div>
		                        <div class="legend-item">
		                            <span class="legend-color back-red"></span>
		                            <span>불용 처리 재고 (15%)</span>
		                        </div>  
		                    </div>
		                </div>
		            </div>         
	            </div>	        	
	        	            
            </div>			
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>	
	<script src="/assetmanager/resources/js/adminChart.js"></script>
</body>
</html>