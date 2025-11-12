<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>자산 상세</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminAssetDetail.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminUpdateAsset.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1>${asset.assetName} 상세</h1>
				<div class="detail-header">
					<span>${asset.assetName}의 상세 정보를 확인하고 관리 합니다.</span>
			        <div class="button-container">
			        	<button id="edit-modal" class="edit-button" data-asset-id="${asset.id}">수정</button>
						<button id="delete-modal" class="cancel-button" data-asset-id="${asset.id}">불용</button>
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
		                        <span class="info-value">${asset.assetName}</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">카테고리</span>
		                        <span class="info-value">${asset.categoryName}</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">일련번호</span>
		                        <span class="info-value">${asset.serialNumber}</span>
		                    </div>
		                    <div class="info-item">
		                        <span class="info-label">스펙</span>
		                        <span class="info-value">${asset.spec}</span>
		                    </div> 
		                    <div class="info-item">
		                        <span class="info-label">위치</span>
		                        <span class="info-value">${asset.location}</span>
		                    </div> 
		                    <div class="info-item">
		                        <span class="info-label">등록일</span>
		                        <span class="info-value"><fmt:formatDate value="${asset.registerDate}" pattern="yyyy-MM-dd"/></span>
		                    </div>
		                </div>
					</div>
					<!-- 사용자 상세 정보 -->
					<div class="section-card">
		                <h2>현재 사용자 정보</h2>
		                <div class="info-list">
		                    <c:if test="${asset.userId != 0}">
								<div class="info-item">
			                        <span class="info-label">상태</span>
			                        <span class="info-value"><span class="status-badge status-used">사용중</span></span>
			                    </div>		                    
			                    <div class="info-item">
			                        <span class="info-label">사용자명</span>
			                        <span class="info-value">${asset.username}</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">직급</span>
			                        <span class="info-value">${asset.position}</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">부서</span>
			                        <span class="info-value">${asset.deptName}</span>
			                    </div>			                    
			                    <div class="info-item">
			                        <span class="info-label">이메일</span>
			                        <span class="info-value">${asset.email}</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">전화번호</span>
			                        <span class="info-value">${asset.phone}</span>
			                    </div>
							</c:if>
							<c:if test="${asset.userId == 0}">
								<div class="info-item">
			                        <span class="info-label">상태</span>
			                        <span class="info-value"><span class="status-badge status-waited">대기중</span></span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">사용자명</span>
			                        <span class="info-value">-</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">직급</span>
			                        <span class="info-value">-</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">부서</span>
			                        <span class="info-value">-</span>
			                    </div>			                    
			                    <div class="info-item">
			                        <span class="info-label">이메일</span>
			                        <span class="info-value">-</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">전화번호</span>
			                        <span class="info-value">-</span>
			                    </div>
							</c:if>
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
		                        <th>사번</th>
		                        <th>사용자명</th> 
		                        <th>직급</th>		                        
		                        <th>부서</th>
		                        <th>사용 시작일</th>
		                        <th>반납일</th>
		                        <th>상태</th>
		                    </tr>
		                </thead>
		                <tbody>
		                	<c:choose>
		                		<c:when test="${empty assetHistory}">
		                			<tr>
		                				<td colspan="7" style="text-align: center;">데이터가 없습니다.</td>
		                			</tr>
		                		</c:when>
		                		<c:otherwise>
				                	<c:forEach var="asset" items="${assetHistory}">
				                		<tr>
											<td>${asset.empNo}</td>
											<td>${asset.username}</td>
											<td>${asset.position}</td>											
											<td>${asset.deptName}</td>
				                			<td><fmt:formatDate value="${asset.rentDate}" pattern="yyyy-MM-dd"/></td>
				                			<c:if test="${asset.returnDate != null}">
												<td><fmt:formatDate value="${asset.returnDate}" pattern="yyyy-MM-dd"/></td>
											</c:if>
											<c:if test="${asset.returnDate == null}">
												<td>-</td>
											</c:if>											
											<c:if test="${asset.returnDate != null}">
												<td><span class="status-badge status-rejected">반납됨</span></td>
											</c:if>
											<c:if test="${asset.returnDate == null}">
												<td><span class="status-badge status-used">사용중</span></td>
											</c:if>
				                		</tr>		                	
				                	</c:forEach>		                		
		                		</c:otherwise>
		                	</c:choose>

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