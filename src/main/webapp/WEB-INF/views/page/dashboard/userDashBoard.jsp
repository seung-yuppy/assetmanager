<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>사원 대시보드</title>
    <link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/dashboard.css" rel="stylesheet">
</head>
<body>
<div class="app-layout">
	<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
	<div class="main-content">
		<%@ include file="/WEB-INF/views/component/header.jsp" %>
		<div class="dashboard-container">
			<div class="home-head">
				<span>${userInfo.deptName}</span>
				<h1>${userInfo.username} ${userInfo.position}님, 안녕하세요!</h1>
			</div>
			
			<div class="metric-grid">
                <div class="metric-card border-green">
					<div class="card-header">
                		<p class="card-title">내 자산</p>   
                		<div class="card-logo-box back-green">
                			<img class="card-logo" src="/assetmanager/resources/image/icon_asset.svg">
                		</div>
                	</div>                    
                    <p class="card-value">${usingCount}</p>
                </div>
                <div class="metric-card border-blue">
					<div class="card-header">
                		<p class="card-title">구매 대기</p>   
                		<div class="card-logo-box back-blue">
                			<img class="card-logo" src="/assetmanager/resources/image/icon_buy.svg">
                		</div>
                	</div>                    
                    <p class="card-value">${deptCount}</p>
                </div>
                <div class="metric-card border-blue">
					<div class="card-header">
                		<p class="card-title">구매 승인</p> 
                		<div class="card-logo-box back-blue">
                			<img class="card-logo" src="/assetmanager/resources/image/icon_using.svg">
                		</div>
                	</div>                    
                    <p class="card-value">${orderCount}</p>
                </div>
                <div class="metric-card border-purple">
					<div class="card-header">
						<p class="card-title">반출 대기</p>
                		<div class="card-logo-box back-purple">
                			<img class="card-logo" src="/assetmanager/resources/image/icon_request.svg">
                		</div>
                	</div>   
                    <p class="card-value">${rentCount}</p>
                </div>
                <div class="metric-card border-purple">
					<div class="card-header">
						<p class="card-title">반출 승인</p>
                		<div class="card-logo-box back-purple">
                			<img class="card-logo" src="/assetmanager/resources/image/icon_using.svg">
                		</div>
                	</div>   
                    <p class="card-value">${rentCount}</p>
                </div>
            </div>
            
	        <!-- 1. 내 자산 섹션 (상태 컬럼 제거됨) -->
	        <div class="section-card">
	            <h2>내 자산</h2> 
	            <table class="data-table">
	                <thead>
	                    <tr>
	                        <th>자산명</th>
	                        <th>카테고리</th>
	                        <th>일련번호</th>
	                        <th>취득일</th>
	                        <th>반납예정일</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:choose>
	                		<c:when test="${empty list}">
			                	<tr>
			                		<td colspan="5" style="text-align: center;">
			               				<p>사용 중인 내 자산이 존재하지 않습니다.</p>
		                			</td>
		                		</tr>	                	
                			</c:when>
                			<c:otherwise>
			                	<c:forEach var="asset" items="${list}">
			                		<tr>
			                			<td>${asset.assetName}</td>
			                			<td>${asset.categoryName}</td>
			                			<td>${asset.serialNumber}</td>
			                			<td><fmt:formatDate value="${asset.createDate}" pattern="yyyy-MM-dd"/></td>
			                			<c:if test="${asset.returnDate != null}">
											<td><fmt:formatDate value="${asset.returnDate}" pattern="yyyy-MM-dd"/></td>
										</c:if>
										<c:if test="${asset.returnDate == null}">
											<td>-</td>
										</c:if>
			                		</tr>
			                	</c:forEach>                			
                			</c:otherwise>
	                	</c:choose>

	                </tbody>
	            </table>
	        </div>
	
	        <!-- 2. 요청 관리 섹션 -->
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
	
	            <!-- 2-2. 구매 요청 (취소 버튼 추가됨) -->
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
	    </div>
	</div>
</div>

<%@ include file="/WEB-INF/views/component/chatbot.jsp"%>
</body>
</html>