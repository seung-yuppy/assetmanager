<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>직원 구매요청 목록</title>
    <link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/orderList.css" rel="stylesheet">
</head>
<body>
<div class="app-layout">
	<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
	<div class="main-content">
	<div class="dashboard-container">
	        <h1>직원 구매요청 목록</h1>
	        <p>현재 처리 중인 모든 구매 요청의 목록을 확인하고 관리합니다.</p>
	
	        <div class="section-card">
	            <h2>최근 구매 요청</h2>
	            <table class="data-table">
	                <thead>
	                    <tr>
	                        <th>자산명</th>
	                        <th>가격</th>
	                        <th>요청 사유</th>
	                        <th>요청일</th>
	                        <th>상태</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <tr>
	                        <td>Latitude 7420 노트북</td>
	                        <td>100,0000</td>
	                        <td>신입 사원 노트북 배정</td>
	                        <td>2023-01-15</td>
	                        <td><span class="status-badge status-waited">사용중</span></td>
	                    </tr>
	                    <tr>
	                        <td>Latitude 7420 노트북</td>
	                        <td>100,0000</td>
	                        <td>신입 사원 노트북 배정</td>
	                        <td>2023-01-15</td>
	                        <td><span class="status-badge status-waited">사용중</span></td>
	                    </tr>
	                    <tr>
	                        <td>Latitude 7420 노트북</td>
	                        <td>100,0000</td>
	                        <td>신입 사원 노트북 배정</td>
	                        <td>2023-01-15</td>
	                        <td><span class="status-badge status-waited">사용중</span></td>
	                    </tr>
	                    <tr>
	                        <td>Latitude 7420 노트북</td>
	                        <td>100,0000</td>
	                        <td>신입 사원 노트북 배정</td>
	                        <td>2023-01-15</td>
	                        <td><span class="status-badge status-waited">사용중</span></td>
	                    </tr>
	                    <tr>
	                        <td>Latitude 7420 노트북</td>
	                        <td>100,0000</td>
	                        <td>신입 사원 노트북 배정</td>
	                        <td>2023-01-15</td>
	                        <td><span class="status-badge status-waited">사용중</span></td>
	                    </tr>
	                    <tr>
	                        <td>Latitude 7420 노트북</td>
	                        <td>100,0000</td>
	                        <td>신입 사원 노트북 배정</td>
	                        <td>2023-01-15</td>
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