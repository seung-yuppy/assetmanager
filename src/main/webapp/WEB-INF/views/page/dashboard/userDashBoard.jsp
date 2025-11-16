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
	<link href="/assetmanager/resources/css/userChart.css" rel="stylesheet">
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
	                	<c:if test="${userInfo.role == 'employee'|| userInfo.role == 'department'}">
	                		<a href="/assetmanager/myasset/list">
	                	</c:if>
	                	<c:if test="${userInfo.role == 'manager'}">
	                		<a href="/assetmanager/deptasset/list">
	                	</c:if>
							<div class="card-header">
								<c:if test="${userInfo.role == 'employee'}">
									<p class="card-title">내 자산</p>  
								</c:if>
								<c:if test="${userInfo.role == 'manager' || userInfo.role == 'department'}">
									<p class="card-title">부서 자산</p>
								</c:if>
		                		<div class="card-logo-box back-green">
		                			<img class="card-logo" src="/assetmanager/resources/image/icon_asset.svg">
		                		</div>
		                	</div>                    
		                    <p class="card-value">${usingCount}개</p>
	                    </a>
	                </div>
	                <div class="metric-card border-blue">
	                	<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
							<a href="/assetmanager/order/list?status=PENDING">
						</c:if>
						<c:if test="${userInfo.role == 'manager'}">
							<a href="/assetmanager/manager/order/list?status=FIRST_APPROVAL">
						</c:if>
							<div class="card-header">
								<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
		                			<p class="card-title">구매 대기</p>
		                		</c:if> 
								<c:if test="${userInfo.role == 'manager'}">
		                			<p class="card-title">구매 합의</p>
		                		</c:if>	                		
		                		<div class="card-logo-box back-blue">
		                			<img class="card-logo" src="/assetmanager/resources/image/icon_buy.svg">
		                		</div>
		                	</div>
		                	<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
		                		<p class="card-value">${pendingOrder}건</p>
		                	</c:if>
		                	<c:if test="${userInfo.role == 'manager'}">
		                		<p class="card-value">${firstOrder}건</p>
		                	</c:if>
		                </a>        
	                </div>
	                <div class="metric-card border-blue">
	                	<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
	                		<a href="/assetmanager/order/list?status=FINAL_APPROVAL">	
	                	</c:if>
	                	<c:if test="${userInfo.role == 'manager'}">
	                		<a href="/assetmanager/manager/order/list?status=FINAL_APPROVAL">	                	
	                	</c:if>
							<div class="card-header">
		                		<p class="card-title">구매 승인</p> 
		                		<div class="card-logo-box back-blue">
		                			<img class="card-logo" src="/assetmanager/resources/image/icon_using.svg">
		                		</div>
		                	</div>                    
		                    <p class="card-value">${finalOrder}건</p>
		            	</a>
	                </div>
	                <div class="metric-card border-purple">
	                	<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
	                		<a href="/assetmanager/rent/list?status=PENDING">	                	
	                	</c:if>
	                	<c:if test="${userInfo.role == 'manager'}">
	                		<a href="/assetmanager/manager/rent/list?status=FIRST_APPROVAL">
	                	</c:if>
							<div class="card-header">
								<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
		                			<p class="card-title">반출 대기</p>
		                		</c:if> 
								<c:if test="${userInfo.role == 'manager'}">
		                			<p class="card-title">반출 합의</p>
		                		</c:if>	  						
		                		<div class="card-logo-box back-purple">
		                			<img class="card-logo" src="/assetmanager/resources/image/icon_request.svg">
		                		</div>
		                	</div>
		                	<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
		                		<p class="card-value">${pendingRent}건</p>
		                	</c:if>
		                	<c:if test="${userInfo.role == 'manager'}">
		                		<p class="card-value">${firstRent}건</p>
		                	</c:if>
		                </a>
	                </div>
	                <div class="metric-card border-purple">
	                	<c:if test="${userInfo.role == 'employee' || userInfo.role == 'department'}">
	                		<a href="/assetmanager/rent/list?status=FINAL_APPROVAL">	
	                	</c:if>
	                	<c:if test="${userInfo.role == 'manager'}">
	                		<a href="/assetmanager/manager/rent/list?status=FINAL_APPROVAL">	                	
	                	</c:if>
							<div class="card-header">
								<p class="card-title">반출 승인</p>
		                		<div class="card-logo-box back-purple">
		                			<img class="card-logo" src="/assetmanager/resources/image/icon_using.svg">
		                		</div>
		                	</div>   
		                    <p class="card-value">${finalRent}건</p>
		                </a>
	                </div>
	            </div>
	            
		        <!-- 1. 내 자산 섹션 (상태 컬럼 제거됨) -->
		        <div class="section-card">
        			<c:if test="${userInfo.role == 'employee'}">
						<h2>반출 자산</h2>  
					</c:if>
					<c:if test="${userInfo.role == 'manager' || userInfo.role == 'department'}">
						<h2>부서 반출 자산</h2> 
					</c:if>
		            <table class="data-table">
		                <thead>
		                    <tr>
		                        <th>자산명</th>
		                        <th>카테고리</th>
		                        <th>반납 예정일</th>
		                        <th>사용 진행도</th>
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
				                			<c:if test="${asset.returnDate != null}">
				                				<td>${asset.assetName}</td>
					                			<td>${asset.categoryName}</td>
												<td>
												    <div class="detail-item">
												        <span class="d-day-label detail-value total-days"></span>
												    </div>
												</td>
				                				<td class="asset-date" data-rent="${asset.createDate}" data-return="${asset.returnDate}">
													<div class="progress-section">
											            <div class="progress-bar-bg">
											                <div class="progress-bar-inner"></div>
											            </div>
											           	<div class="date-labels">
										                    <span>
										                    	<fmt:formatDate value="${asset.createDate}" pattern="yyyy-MM-dd"/>
										                    </span>
										                    <span>
										                    	<fmt:formatDate value="${asset.returnDate}" pattern="yyyy-MM-dd"/>
										                    </span>										                    
											            </div>
											        </div>				                				
				                				</td>
											</c:if>
				                		</tr>
				                	</c:forEach>                			
	                			</c:otherwise>
		                	</c:choose>
		                </tbody>
		            </table>
		        </div>
		
		        <div class="request-grid">
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
		                    	<c:choose>
		                    		<c:when test="${empty orderList}">
			                    		<tr>
					                		<td colspan="3" style="text-align: center;">
					               				<p>구매 요청 중인 자산이 존재하지 않습니다.</p>
				                			</td>
				                		</tr>
		                    		</c:when>     	
			                    	<c:otherwise>
			                    		<c:forEach var="order" items="${orderList}">
			                    			<tr>
			                    				<td>${order.title}</td>
			                    				<td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd"/></td>
			                    				<c:choose>									       
											        <c:when test="${userInfo.role == 'manager' && order.status == 'FIRST_APPROVAL'}">
											            <td>
											            	<span class="status-badge status-waited">대기중</span>
											        	</td>
											        </c:when>
											        <c:otherwise>
											        	<td>
											            	<span class="status-badge status-${order.status.badgeType}">${order.status.koreanName}</span>
											        	</td>
											        </c:otherwise>
											    </c:choose>
			                    			</tr>
			                    		</c:forEach>
			                    	</c:otherwise>
		                    	</c:choose>
		                    </tbody>
		                </table>
		            </div>
		
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
		                    	<c:choose>
		                    		<c:when test="${empty rentList}">
			                    		<tr>
					                		<td colspan="3" style="text-align: center;">
					               				<p>구매 요청 중인 자산이 존재하지 않습니다.</p>
				                			</td>
				                		</tr>
		                    		</c:when>
		                    		<c:otherwise>
		                    			<c:forEach var="rent" items="${rentList}">
		                    				<tr>
		                    					<td>${rent.title}</td>
		                    					<td><fmt:formatDate value="${rent.rentDate}" pattern="yyyy-MM-dd"/></td>
												<c:choose>									       
											        <c:when test="${userInfo.role == 'manager' && rent.status == 'FIRST_APPROVAL'}">
											            <td>
											            	<span class="status-badge status-waited">대기중</span>
											        	</td>
											        </c:when>
											        <c:otherwise>
											        	<td>
											            	<span class="status-badge status-${rent.status.badgeType}">${rent.status.koreanName}</span>
											        	</td>
											        </c:otherwise>
											    </c:choose>
		                    				</tr>
		                    			</c:forEach>
		                    		</c:otherwise>
		                    	</c:choose>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/component/chatbot.jsp"%>
	
	<script src="/assetmanager/resources/js/userDashBoardChart.js"></script>
	<script src="/assetmanager/resources/js/notice.js"></script>
</body>
</html>