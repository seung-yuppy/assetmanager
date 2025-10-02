<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>직원 구매요청 목록</title>
    <link href="resources/css/common.css" rel="stylesheet">
	<link href="resources/css/order-list.css" rel="stylesheet">
</head>
<body>
<div class="app-layout">
	<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
	<div class="main-content">
	<div class="dashboard-container">
	        <h1>직원 구매요청 목록</h1>
	        <p>현재 처리 중인 모든 구매 요청의 목록을 확인하고 관리합니다.</p>
	
	        <div class="section-card">
	            <h2>내 자산</h2>
	            <table class="data-table">
	                <thead>
	                    <tr>
	                        <th>자산명</th>
	                        <th>카테고리</th>
	                        <th>취득일</th>
	                        <th>반납 예정일</th>
	                        <th>상태</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td>Latitude 7420 노트북</td>
	                        <td>전자기기</td>
	                        <td>2023-01-15</td>
	                        <td>N/A</td>
	                        <td><span class="status-badge status-waited">사용중</span></td>
	                    </tr>
	                    <tr>
	                    	
	                        <td>Dell U2721DE 모니터</td>
	                        <td>전자기기</td>
	                        <td>2023-03-22</td>
	                        <td>N/A</td>
	                        <td><span class="status-badge status-waited">사용중</span></td>
	                    </tr>
	                    <tr>
	                    	
	                        <td>로지텍 MX Keys 키보드</td>
	                        <td>전자기기</td>
	                        <td>2023-04-10</td>
	                        <td>N/A</td>
	                        <td><span class="status-badge status-waited">사용중</span></td>
	                    </tr>
	                    <tr>
	                    	
	                        <td>Microsoft Office 365 라이선스</td>
	                        <td>전자기기</td>
	                        <td>2023-01-01</td>
	                        <td>2024-01-01</td>
	                        <td><span class="status-badge status-rejected">반납됨</span></td>
	                    </tr>
	                    <tr>
	                    	<td>노트북 충전기</td>
	                        <td>전자기기</td>
	                        <td>2023-05-01</td>
	                        <td>N/A</td>
	                        <td><span class="status-badge status-waited">사용중</span></td>
	                    </tr>
	                </tbody>
	            </table>
	        </div>

	    </div>
	    </div>
	</div>
</body>
</html>