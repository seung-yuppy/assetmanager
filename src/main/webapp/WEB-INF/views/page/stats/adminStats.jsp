<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>구매 리포트</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- jsPDF CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <!-- html2canvas CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script src="https://unpkg.com/lucide@latest" data-lucide-package="lucide"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <link href="/assetmanager/resources/css/common.css" rel="stylesheet">
    
    <style>
 	     /* 공통 섹션 스타일 */
		.dashboard-container h1 {
			font-size: 30px;
		    font-weight: 700; 
		    margin: 0 0 5px 0;
		}
		
		section{
	    	margin-bottom: 3rem;
		}
		.section-card h2 {
		    font-size: 1.5rem;
		    font-weight: 600;
		    margin-bottom: 15px;
		}
		
		/* 대시보드 레이아웃 */
		.dashboard-container {
			display: flex;
			flex-direction: column;
		  	margin: 0 auto;
		}
		
	    /* 공통 섹션 스타일 */
		.section-card {
		    background-color: var(--white-color); /* 흰색 카드 배경 */
		    padding: 20px;
		    border-radius: 12px;
		    box-shadow: var(--card-shadow); /* 밝은 배경에 맞는 옅은 그림자 */
		    margin-top: 25px;
		}
        /* PDF 생성 시 로더 스타일 */
        #loader {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            display: none; /* 기본 숨김 */
        }
        .spinner {
            border: 8px solid #f3f3f3;
            border-top: 8px solid #3498db;
            border-radius: 50%;
            width: 60px;
            height: 60px;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        textarea{
 			resize: none;
		}

        .report-comment-text{
        	display: none;
        }
        
        .page-description{
        	color: var(--gray-color);
        }
            
    </style>
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
		    <!-- PDF 생성 시 로더 -->
		    <div id="loader">
		        <div class="spinner"></div>
		        <span class="text-white text-xl ml-4">PDF 보고서를 생성 중입니다...</span>
		    </div>
		
		    <div class="dashboard-container">
		        <!-- 보고서 콘텐츠 영역 (이 부분이 PDF로 변환됨) -->
		        <div class="flex justify-between">
			        <div>
				    	<h1>구매 리포트</h1>
			            <span class="page-description">구매 통계를 확인하고 보고서를 생성합니다.</span>
			        </div>
			        <div class="flex flex-col justify-end items-center">
			            <div class="flex items-center space-x-2 mt-4 sm:mt-0">
			                <button id="export-pdf-btn" class="bg-blue-600 text-white px-4 py-2 rounded-md font-semibold shadow-md hover:bg-blue-700 transition duration-200"
			                style="background-color: var(--primary-button-color);">보고서 저장</button>
			            </div>
			        </div>
		        </div>
		        
		        <main id="report-content" class="section-card">
					<select onchange="setBoardParam('year', this.value)"
					    class="no-pdf rounded-md border-gray-300 bg-white shadow-sm px-3 py-2 text-sm
					           focus:border-blue-400 focus:ring focus:ring-blue-200 focus:ring-opacity-50">
					    <option value="2025" ${empty param.year ? 'selected' : ''}>2025년</option>
					    <option value="2024" ${param.year == '2024' ? 'selected' : ''}>2024년</option>
					    <option value="2023" ${param.year == '2023' ? 'selected' : ''}>2023년</option>
					</select>
					<div class="border-b pb-6 mb-10 bg-gray-50 p-6 rounded-lg shadow-sm">
						<div class="flex justify-center items-center mb-9">
						    <h1 class="text-8xl text-gray-900 tracking-tight">구매 리포트</h1>
						</div>
					    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 text-sm text-gray-800 leading-relaxed">
					        <div class="bg-white p-3 rounded-md border">
					            <strong class="block text-gray-600 text-base mb-1">작성자</strong>
					            <span class="font-medium text-base">${sessionScope.userInfo.username}</span>
					        </div>
					        <div class="bg-white p-3 rounded-md border">
					        	<c:set var="now" value="<%= new java.util.Date() %>" />
					            <strong class="block text-gray-600 text-base mb-1">작성일</strong>
					            <span class="font-medium text-base"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></span>
					        </div>
					        <div class="bg-white p-3 rounded-md border">
					            <strong class="block text-gray-600 text-base mb-1">보고 대상 년도</strong>
					            <fmt:formatDate value="${now}" pattern="yyyy" var="currentYear"/>
					            <span class="font-medium text-base">${empty param.year ? currentYear: param.year}</span>
					        </div>
					        <div class="bg-white p-3 rounded-md border">
					            <strong class="block text-gray-600 text-base mb-1">보고 목적</strong>
					            <input id="report-purpose" class="font-medium text-base w-full border border-gray-300 rounded-md ps-1" placeholder="보고 목적을 입력하세요">
					        </div>
					    </div>
					</div>
		            <section>
		                <h3 class="text-2xl font-semibold text-gray-800 mb-4">연간 구매 금액</h3>
		                <div class="grid grid-cols-1 lg:grid-cols-5 gap-6">
		                    <!-- 차트 -->
		                    <div class="lg:col-span-3 bg-gray-50 p-4 rounded-lg shadow-inner flex justify-center">
		                        <canvas id="annualLineChart"></canvas>
		                    </div>
		                    <!-- 표 -->
		                    <div class="lg:col-span-2">
		                        <table class="min-w-full divide-y divide-gray-200 border-b border-gray-200">
		                            <thead class="bg-gray-100">
		                                <tr>
		                                    <th class="px-4 py-3 text-left text-sm font-bold text-gray-600 uppercase tracking-wider">년</th>
		                                    <th class="px-4 py-3 text-right text-sm font-bold text-gray-600 uppercase tracking-wider">구매 금액 (원)</th>
		                                    <th class="px-4 py-3 text-right text-sm font-bold text-gray-600 uppercase tracking-wider">전년 대비</th>
		                                </tr>
		                            </thead>
		                            <tbody id="annualTableBody" class="bg-white divide-y divide-gray-200">
		                                <!-- JS로 데이터 채우기 -->
		                            </tbody>
		                        </table>
		                    </div>
		                </div>
		                <div class="comment-area">
	                    	<button class="report-comment no-pdf no-print flex items-center space-x-2 transition duration-150 p-2 rounded-lg -ml-2">
	                    		<i class="bi bi-chevron-down text-blue-600"></i>
	                    		<span class="ms-1 text-blue-600 font-medium hover:text-blue-700">설명 추가</span>
                    		</button>
	                    	<textarea class="report-comment-text text-base w-full border border-gray-300 rounded-md p-3 bg-white shadow-sm focus:ring-2 focus:ring-blue-300 focus:border-blue-400 transition outline-none"
									    placeholder="해당 통계에 대한 설명을 추가할 수 있습니다." style="resize: none;"></textarea>
		                </div>
		            </section>
		            <section>
		                <h3 class="text-2xl font-semibold text-gray-800 mb-4">카테고리별 구매 비율</h3>
		                <div class="grid grid-cols-1 lg:grid-cols-5 gap-6">
		                    <!-- 차트 -->
		                    <div class="lg:col-span-3 bg-gray-50 p-4 rounded-lg shadow-inner flex justify-center items-center" style="max-height: 300px;">
		                        <canvas id="categoryDonutChart"></canvas>
		                    </div>
		                    <!-- 표 -->
		                    <div class="lg:col-span-2">
		                        <table class="min-w-full divide-y divide-gray-200 border-b border-gray-200">
		                            <thead class="bg-gray-100">
		                                <tr>
		                                    <th class="px-4 py-3 text-left text-sm font-bold text-gray-600 uppercase tracking-wider">카테고리</th>
		                                    <th class="px-4 py-3 text-right text-sm font-bold text-gray-600 uppercase tracking-wider">구매 금액 (원)</th>
		                                    <th class="px-4 py-3 text-right text-sm font-bold text-gray-600 uppercase tracking-wider">비율 (%)</th>
		                                </tr>
		                            </thead>
		                            <tbody id="categoryTableBody" class="bg-white divide-y divide-gray-200">
		                                <!-- JS로 데이터 채우기 -->
		                            </tbody>
		                        </table>
		                    </div>
		                </div>
		                <div class="comment-area">
	                    	<button class="report-comment no-pdf no-print flex items-center space-x-2 transition duration-150 p-2 rounded-lg -ml-2">
	                    		<i class="bi bi-chevron-down text-blue-600"></i>
	                    		<span class="ms-1 text-blue-600 font-medium hover:text-blue-700">설명 추가</span>
                    		</button>
	                    	<textarea class="report-comment-text w-full border border-gray-300 rounded-md p-3 text-base bg-white shadow-sm focus:ring-2 focus:ring-blue-300 focus:border-blue-400 transition outline-none"
									    placeholder="해당 통계에 대한 설명을 추가할 수 있습니다." style="resize: none;"></textarea>
		                </div>
		            </section>
		            <section>
		                <h3 class="text-2xl font-semibold text-gray-800 mb-4">부서별 구매 금액</h3>
		                <div class="grid grid-cols-1 lg:grid-cols-5 gap-6">
		                    <!-- 차트 -->
		                    <div class="lg:col-span-3 bg-gray-50 p-4 rounded-lg shadow-inner flex justify-center">
		                        <canvas id="deptBarChart"></canvas>
		                    </div>
		                    <!-- 표 -->
		                    <div class="lg:col-span-2">
		                        <table class="min-w-full divide-y divide-gray-200 border-b border-gray-200">
		                            <thead class="bg-gray-100">
		                                <tr>
		                                    <th class="px-4 py-3 text-left text-sm font-bold text-gray-600 uppercase tracking-wider">부서</th>
		                                    <th class="px-4 py-3 text-right text-sm font-bold text-gray-600 uppercase tracking-wider">구매 금액 (원)</th>
		                                    <th class="px-4 py-3 text-right text-sm font-bold text-gray-600 uppercase tracking-wider">비율 (%)</th>
		                                </tr>
		                            </thead>
		                            <tbody id="deptTableBody" class="bg-white divide-y divide-gray-200">
		                                <!-- JS로 데이터 채우기 -->
		                            </tbody>
		                        </table>
		                    </div>
		                </div>
		                <div class="comment-area">
	                    	<button class="report-comment no-pdf no-print flex items-center space-x-2 transition duration-150 p-2 rounded-lg -ml-2">
	                    		<i class="bi bi-chevron-down text-blue-600"></i>
	                    		<span class="ms-1 text-blue-600 font-medium hover:text-blue-700">설명 추가</span>
                    		</button>
	                    	<textarea class="report-comment-text w-full border border-gray-300 rounded-md p-3 text-base bg-white shadow-sm focus:ring-2 focus:ring-blue-300 focus:border-blue-400 transition outline-none"
									    placeholder="해당 통계에 대한 설명을 추가할 수 있습니다." style="resize: none;"></textarea>
		                </div>
		            </section>
		        </main>
		    </div>
	    </div>
	</div>
 <script src="/assetmanager/resources/js/statsChart.js"></script>
 <script src="/assetmanager/resources/js/pageFilter.js"></script>
</body>
</html>