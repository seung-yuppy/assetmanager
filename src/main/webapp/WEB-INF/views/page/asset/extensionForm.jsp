<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
<fmt:formatDate value="${returning.returnDate}" pattern="yyyy-MM-dd" var="returnDate" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반출 연장</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/modal.css" rel="stylesheet">
<link href="/assetmanager/resources/css/requestForm.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script src="https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"></script>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp" %>
			<div class="dashboard-container">
				<h1 class="content-title">연장 요청서</h1>
				<span class="page-description">새로운 연장 요청을 위해서 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</span>
				<div class="section-card">
					<form action="/assetmanager/asset/extension/form" method="post">
						<div class="form-section">
							<!-- 결재라인 전체 컨테이너 -->
							<%@ include file="/WEB-INF/views/component/approver.jsp" %>
						</div>
						<h2 class="form-section-title">요청 정보</h2>
					<div id="formInputArea" class="inputArea">
						<div class="form-date">
							<div class="form-application-date">
								<label for="application-date">반출 요청일</label> <input type="date" id="application-date" value="${currentDate}" class="form-input rent-input" readonly>
							</div>
							<div class="form-return-date">
									<label for="return-date">반납 예정일 <span class="required">*</span></label> 
									<input type="date" name="returnDate" id="return-date" placeholder="반납 예정일 선택" class="form-input rent-input" min="${returnDate}" required>
							</div>
						</div>
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 </label> 
									<input id="category" name="categoryName" type="text" value="${asset.categoryName}" class="locked-input" readonly>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명</label> 
									<input list="productOptions" name="assetName" id="productNameSelect" type="text" value="${asset.assetName}" class="locked-input" readonly>
									<input type="hidden" name="assetId" value="${asset.id}" />
								</div>
								<div class="form-group">
									<label for="spec">스펙</label>
									<div class="last-input-group">
										<input type="text" id="spec" value="${asset.spec}" class="locked-input" readonly>
									</div>
								</div>
							</div>

						<div class="form-group">
							<div class="form-reason">
								<label for="reason">연장 요청 사유 <span class="required">*</span></label>
								<textarea id="reason" name="requestMsg" rows="5" cols="81" maxlength="200" placeholder="연장 요청이 필요한 구체적인 사유를 입력해주세요." required></textarea>
								<div class="char-count-display text-align-right"></div>
							</div>
						</div>
					</div>
						<div class="form-actions">
							<button type="submit" class="primary-action">제출</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
 	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>	
	<c:if test="${not empty delaySuccess}">
    	<script>
	    	Swal.fire({
	            icon: 'success',
	            title: '연장 성공',
	            text: '${delaySuccess}',
	            preConfirm: () => {
	            	location.href = "/assetmanager/myasset/list";
	            }
	        });    	
    	</script>
    </c:if>
    
    <c:if test="${not empty delayFail}">
    	<script>
    	Swal.fire({
            icon: 'error',
            title: '연장 실패',
            text: '${delayFail}'
        });    
    	</script>
    </c:if>
	
</body>
</html>