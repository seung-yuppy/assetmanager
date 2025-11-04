<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>반납 상세</title>
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
				<h1>반납 상세</h1>
				<div class="detail-header">
					<span>반납 요청의 상세 정보를 확인하고 관리 합니다.</span>
			        <div class="button-container">
			        	<button id="return-modal" class="adminReturn-button" data-asset-id="">반납</button>
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
		                        <span class="info-label">자산 카테고리</span>
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
		                        <span class="info-label">자산 위치</span>
		                        <span class="info-value">${asset.location}</span>
		                    </div> 
		                    <div class="info-item">
		                        <span class="info-label">등록일자</span>
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
			                        <span class="info-label">자산 상태</span>
			                        <span class="info-value"><span class="status-badge status-used">사용중</span></span>
			                    </div>		                    
			                    <div class="info-item">
			                        <span class="info-label">사용자 이름</span>
			                        <span class="info-value">${asset.username}</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">이메일</span>
			                        <span class="info-value">${asset.email}</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">전화번호</span>
			                        <span class="info-value">${asset.phone}</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">직책</span>
			                        <span class="info-value">${asset.position}</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">부서명</span>
			                        <span class="info-value">${asset.deptName}</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">부서 주소</span>
			                        <span class="info-value">${asset.deptAddress}</span>
			                    </div>
							</c:if>
							<c:if test="${asset.userId == 0}">
								<div class="info-item">
			                        <span class="info-label">자산 상태</span>
			                        <span class="info-value"><span class="status-badge status-waited">대기중</span></span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">사용자 이름</span>
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
			                    <div class="info-item">
			                        <span class="info-label">직책</span>
			                        <span class="info-value">-</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">부서명</span>
			                        <span class="info-value">-</span>
			                    </div>
			                    <div class="info-item">
			                        <span class="info-label">부서 주소</span>
			                        <span class="info-value">-</span>
			                    </div>
							</c:if>
		                </div>
		            </div>
				</div>
				<!-- 자산 & 사용자 상세 정보 끝 -->
				<div class="section-card">
		            <h2>사용 내역</h2> 
		            <table class="data-table">
		                <thead>
		                    <tr>
		                        <th>사용 시작일</th>
		                        <th>반납 예정일</th>
		                        <th>사용기간</th>
		                    </tr>
		                </thead>
		                <tbody>
		                	<c:forEach var="asset" items="${assetHistory}">
		                		<tr>
		                			<td><fmt:formatDate value="${asset.rentDate}" pattern="yyyy-MM-dd"/></td>
		                			<c:if test="${asset.returnDate != null}">
										<td><fmt:formatDate value="${asset.returnDate}" pattern="yyyy-MM-dd"/></td>
									</c:if>
									<c:if test="${asset.returnDate == null}">
										<td>-</td>
									</c:if>
									<td>D+100일</td>									
		                		</tr>		                	
		                	</c:forEach>
		                </tbody>
		            </table>
		        </div>
				
			</div>
			
		</div>
	</div>
	
	<!-- script 영역 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="/assetmanager/resources/js/adminUpdateAsset.js"></script>
</body>
</html>