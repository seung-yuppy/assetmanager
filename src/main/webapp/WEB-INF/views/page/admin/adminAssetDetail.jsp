<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자산 상세</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminAssetDetail.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminUpdateAsset.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>LG그램 노트북 상세</h1>
				<div class="detail-header">
					<span>LG그램 노트북의 상세 정보를 확인하고 관리 합니다.</span>
			        <div class="button-container">
			        	<button id="edit-modal" class="edit-button">수정</button>
						<button class="cancel-button">불용</button>
					</div>	
				</div>
				<!-- 자산 & 사용자 상세 정보 시작 -->
				<div class="request-grid">
					<!-- 자산 상세 정보 -->
					<div class="section-card">
						<h2>자산 상세정보</h2>
						<div class="info-list">
		                    <div class="info-item">
		                        <span class="info-label">자산명</span>
		                        <span class="info-value">Latitude 7420 노트북</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">자산 카테고리</span>
		                        <span class="info-value">노트북</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">일련번호</span>
		                        <span class="info-value">L7420-SN-AB12345</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">등록일자</span>
		                        <span class="info-value">2023-01-05</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">분류</span>
		                        <span class="info-value">개인 할당</span>
		                    </div>
		                </div>
					</div>
					<!-- 사용자 상세 정보 -->
					<div class="section-card">
		                <h2>현재 사용자 정보</h2>
		                <div class="info-list">
		                    <div class="info-item">
		                        <span class="info-label">자산 상태</span>
		                        <span class="info-value"><span class="status-badge status-used">사용중</span></span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">사용자 이름</span>
		                        <span class="info-value">김지원 사원</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">부서명</span>
		                        <span class="info-value">개발팀</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">부서 주소</span>
		                        <span class="info-value">B동 5층 개발팀 사무실</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">할당일</span>
		                        <span class="info-value">2023-01-15</span>
		                    </div>
		                </div>
		            </div>
				</div>
				<!-- 자산 & 사용자 상세 정보 끝 -->
				<!-- 자산 내역 시작 -->
				<div class="section-card">
		            <h2>자산 내역</h2> 
		            <table class="data-table">
		                <thead>
		                    <tr>
		                        <th>사용 시작</th>
		                        <th>사용 끝</th>
		                        <th>사용자 이름</th>
		                        <th>부서</th>
		                        <th>직급</th>
		                        <th>상태</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <tr>
		                        <td>2025-01-15</td>
		                        <td>현재</td>
		                        <td>김지원</td>
		                        <td>개발팀</td>
		                        <td>사원</td>	                        
		                        <td><span class="status-badge status-used">사용중</span></td>
		                    </tr>
		                    <tr>
		                        <td>2023-03-22</td>
		                        <td>2025-01-14</td>
		                        <td>배고파</td>
		                        <td>개발팀</td>
		                        <td>사원</td>	  
		                        <td><span class="status-badge status-rejected">반납</span></td>
		                    </tr>
		                    <tr>
		                        <td>2023-01-21</td>
		                        <td>2023-03-21</td>
		                        <td>힘들어</td>
		                        <td>개발팀</td>
		                        <td>사원</td>	  		                        
		                        <td><span class="status-badge status-rejected">반납</span></td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        <!-- 자산 히스토리 끝 -->		
	
			</div>
			
		</div>
		
		
	</div>
	
	<!-- script 영역 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="/assetmanager/resources/js/adminUpdateAsset.js"></script>
</body>
</html>