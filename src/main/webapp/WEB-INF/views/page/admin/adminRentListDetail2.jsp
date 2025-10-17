<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/approver.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminAssetDetail.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/adminRentDetail.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/adminSideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1 class="content-title">반출 요청 상세</h1>
				<span>반출 요청의 상세 내역을 확인하고 관리하세요.</span>
				
				<!-- 신청자 정보 & 결재 정보 시작 -->
				<div class="detail-grid">
					<!-- 신청자 정보 시작 -->
					<div class="section-card">
						<h2 class="form-section-title">신청자 정보</h2>
						<div class="registerInfo-container">
							<div class="registerInfo-item">
								<label for="name">요청ID(사번)</label> 
								<span>ams1001</span>
							</div>
							<div class="registerInfo-item">
								<label for="name">신청자 이름</label> 
								<span>홍길동</span>
							</div>
							<div class="registerInfo-item">
								<label for="department">부서명</label> 
								<span>영업팀</span>
							</div>
							<div class="registerInfo-item">
								<label for="role">직책</label> 
								<span>팀장</span>
							</div>
							<div class="registerInfo-item">
								<label for="address">주소</label> 
								<span>서울 종로구 대명길 28 대학로</span>
							</div>
						</div>
					</div>
					<!-- 신청자 정보 끝 -->
					<!-- 결재 정보 시작 -->
					<div class="section-card">
						<div class="form-section">
							<%@ include file="/WEB-INF/views/component/approverReadonly.jsp"%>
						</div>
					</div>
					<!-- 결재 정보 끝 -->
				</div>
				<!-- 신청자 정보 & 결재 정보 끝 -->
				<!-- 요청 상세 정보 시작 -->
				<div class="section-card">
					<h2 class="form-section-title">요청 내용</h2>
					<div id="formInputArea" class="inputArea">
						<div class="form-row">
							<div class="form-group fixed-width-sm">
								<label for="isDepartmentUse">부서 자산</label> <input type="checkbox" id="isDepartmentUse" name="isDepartmentUse" checked onclick="return false">
							</div>
							<div class="form-group category-group fixed-width-med">
								<label for="category">카테고리 </label> <input id="category" name="category" type="text" value="기타" class="locked-input" readonly>
							</div>
							<div class="form-group product-select-group fixed-width-lg">
								<label for="productNameSelect">제품명</label> <input list="productOptions" name="productNameSelect" id="productNameSelect" type="text" value="복합기" class="locked-input" readonly>
							</div>
							<div class="form-group">
								<label for="spec">스펙</label>
								<div class="last-input-group">
									<input type="text" id="spec" value="cpu~~~~~" class="locked-input" readonly>
								</div>
							</div>
						</div>

						<div class="form-row">
							<div class="form-group fixed-width-sm">
								<label for="isDepartmentUse">부서 자산</label> <input type="checkbox" id="isDepartmentUse" name="isDepartmentUse" checked onclick="return false">
							</div>
							<div class="form-group category-group fixed-width-med">
								<label for="category">카테고리 </label> <input id="category" name="category" type="text" value="기타" class="locked-input" readonly>
							</div>
							<div class="form-group product-select-group fixed-width-lg">
								<label for="productNameSelect">제품명</label> <input list="productOptions" name="productNameSelect" id="productNameSelect" type="text" value="복합기" class="locked-input" readonly>
							</div>
							<div class="form-group">
								<label for="spec">스펙</label>
								<div class="last-input-group">
									<input type="text" id="spec" value="cpu~~~~~" class="locked-input" readonly>
								</div>
							</div>
						</div>

						<div class="form-footer">
							<div class="form-reason">
								<label for="reason">반출 요청 사유 </label>
								<textarea id="reason" name="reason" rows="6" required placeholder="프로젝트 시작하여 새로운 기기 필요." cols="81" maxlength="200" onkeyup="updateCharCount(this, 200)" readonly></textarea>
								<div class="char-count-display text-align-right"></div>
							</div>

							<div class="form-date">
								<div class="form-application-date">
									<label for="application-date">반출 신청일</label> <input type="date" id="application-date" value="${currentDate}" class="locked-input" readonly>
								</div>
								<div class="form-return-date">
									<label for="return-date">반납 예정일</label> <input type="date" id="return-date" placeholder="반납 예정일 선택" class="locked-input" readonly>
								</div>
							</div>
						</div>
					</div>

					<div class="form-actions">
						<button type="submit" class="primary-action">승인</button>
						<button type="button" class="cancel-action">반려</button>
					</div>				
				</div>
				<!-- 요청 상세 정보 끝 -->
			</div>
		</div>
	</div>
</body>
</html>