<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자산 통계</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/dashboard.css" rel="stylesheet">
	<style>
		/* 차트와 테이블을 담는 컨테이너 스타일 */
		.chart-table-container {
			display: flex;
			flex-wrap: wrap; /* 모바일 화면 등에서 줄바꿈 지원 */
			gap: 24px; /* 컴포넌트 사이 간격 */
			width: 100%;
		}
		
		/* 차트와 테이블이 동일한 비율을 갖도록 설정 */
		.chart-container,
		.table-container {
			flex: 1;
			min-width: 300px; /* 최소 너비 보장 */
		}
		
		/* 차트 컨테이너는 position: relative가 필수 */
		.chart-container {
			position: relative;
			/* 레이아웃 시프트를 막기 위해 고정 높이를 주거나,
			  JS에서 maintainAspectRatio: false 를 설정해야 합니다.
			  여기서는 JS에서 설정하는 방식을 택합니다.
			*/
		}

		/* 여러 섹션 카드를 보기 좋게 배치하기 위한 그리드 (선택 사항) */
		.dashboard-grid {
			display: grid;
			grid-template-columns: 1fr; /* 기본 1열 */
			gap: 24px;
		}

		/* 더 큰 화면에서는 2열로 배치 */
		@media (min-width: 1024px) {
			.dashboard-grid {
				/* 두 개의 카드가 나란히 배치되도록 수정 */
				grid-template-columns: 1fr 1fr;
			}
			/* 1열 전체를 사용하는 카드를 위한 클래스 */
			.full-width-card {
				grid-column: 1 / -1;
			}
		}

		/* 새로운 컨트롤 영역 스타일 */
		.dashboard-header-controls {
			display: flex;
			justify-content: space-between; /* 양 끝 정렬 */
			align-items: center;
			margin-bottom: 20px; /* 아래쪽 여백 */
		}
		
		.year-selector {
			display: flex;
			align-items: center;
		}

		.year-selector label {
			font-weight: 600;
			color: #333;
			margin-right: 8px;
		}
		
		.styled-select {
			padding: 8px 12px;
			border: 1px solid #ddd;
			border-radius: 8px;
			font-size: 14px;
			cursor: pointer;
			transition: border-color 0.2s;
		}
		
		.styled-select:focus {
			border-color: #4CAF50; /* 예시 색상, 실제 CSS 변수 사용 권장 */
			outline: none;
		}
		
		.report-action-area {
			display: flex;
			align-items: center;
			gap: 10px;
		}
		
		.primary-button {
			padding: 8px 16px;
			background-color: #007bff; /* 예시 색상 */
			color: white;
			border: none;
			border-radius: 8px;
			cursor: pointer;
			font-weight: 500;
			transition: background-color 0.2s;
			white-space: nowrap; /* 버튼 내용이 줄바꿈되지 않도록 */
		}
		
		.primary-button:hover {
			background-color: #0056b3;
		}
		
		/* 보고서 생성 상태 메시지 스타일 */
		#reportStatusMessage {
			font-size: 14px;
			color: #007bff;
			opacity: 0;
			transition: opacity 0.3s ease-in-out;
		}

	</style>
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			
			<!-- 대시보드 컨테이너 -->
			<div class="dashboard-container">
				<h1 class="content-title" style="font-size:30px;">구매 통계</h1>
				<!-- 새로운 컨트롤 영역: 년도 선택 및 보고서 생성 버튼 -->
				<div class="dashboard-header-controls">
					<div class="year-selector">
						<label for="yearSelect">년도 선택:</label>
						<select id="yearSelect" class="styled-select">
							<option value="2025">2025년</option>
							<option value="2024" selected>2024년</option>
							<option value="2023">2023년</option>
						</select>
					</div>
					<div class="report-action-area">
						<span id="reportStatusMessage"></span>
						<button id="reportGenerateBtn" class="primary-button">보고서 생성</button>
					</div>
				</div>
				<!-- 기존 섹션: 분기별 구매 추이 (전체 너비 사용) -->
				<div class="section-card full-width-card">
					<h2>분기별 구매 추이</h2>
					<div class="chart-table-container">
						<!-- 차트 컨테이너 (Layout Shift 방지: position: relative) -->
						<div class="chart-container">
							<canvas id="totalPurchaseLineChart"></canvas>
						</div>
						<!-- 테이블 컨테이너 -->
						<div class="table-container">
				            <table class="data-table" id="purchaseTable">
								<thead>
									<tr>
										<th>자산명</th>
										<th>카테고리</th>
										<th>반납예정일</th>
										<th>사용 진행도</th>
									</tr>
								</thead>
								<tbody></tbody>	
							</table>
						</div>
					</div>
		        </div>

				<!-- 새로운 섹션들을 담을 그리드 -->
				<div class="dashboard-grid">
					
					<!-- 새로운 섹션 1: 자산 유형별 현황 (Doughnut Chart) -->
					<div class="section-card">
						<h2>자산 유형별 현황</h2>
						<div class="chart-table-container">
							<!-- 차트 컨테이너 -->
							<div class="chart-container">
								<canvas id="assetTypeDoughnutChart"></canvas>
							</div>
							<!-- 테이블 컨테이너 -->
							<div class="table-container">
								<table class="data-table" id="assetTypeTable">
									<thead>
										<tr> <th>유형</th> <th>수량</th> <th>비율</th> </tr>
									</thead>
									<tbody>
										<!-- 데이터는 statsChart.js에서 동적으로 채워집니다. -->
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<!-- 새로운 섹션 2: 월별 자산 변동 (Bar Chart) -->
					<div class="section-card">
						<h2>월별 자산 변동</h2>
						<div class="chart-table-container">
							<!-- 차트 컨테이너 -->
							<div class="chart-container">
								<canvas id="monthlyFluctuationBarChart"></canvas>
							</div>
							<!-- 테이블 컨테이너 -->
							<div class="table-container">
								<table class="data-table" id="monthlyFluctuationTable">
									<thead>
										<tr> <th>월</th> <th>입고</th> <th>폐기</th> <th>순증</th> </tr>
									</thead>
									<tbody>
										<!-- 데이터는 statsChart.js에서 동적으로 채워집니다. -->
									</tbody>
								</table>
							</div>
						</div>
					</div>

				</div> <!-- .dashboard-grid 끝 -->

		    </div> <!-- .dashboard-container 끝 -->
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/component/chatbot.jsp"%>
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>	
	<script src="/assetmanager/resources/js/statsChart.js"></script>
</body>
</html>