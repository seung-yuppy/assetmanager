<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자산 등록 상세</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/sideMenu.css" rel="stylesheet">
<link href="/assetmanager/resources/css/rentRequest.css" rel="stylesheet"> 
</head>
<body>
	<%-- 다건 상세요청리스트 들어가야할 것???   1.제품명 2. 등록일자 3.반출일자 4.일련번호--%>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<div class="main-content">
			<div class="content-wrapper">
				<h1 class="content-title">자산 등록</h1>
				<p class="content-description">자산 등록을 위한 세부 내용을 등록합니다.</p>

				<form>
					<div class="form-section">
						<div class="form-grid grid-cols-4">
							<div class="form-group">
								<label for="product-name">제품명</label> <input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<label for="application-date">자산 등록일</label> <input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<label for="return-date">반납 예정일</label> <input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<label for="serial-number">일련번호</label> <input type="text" id="serial-number" class="form-input">
							</div>
							
							
							<div class="form-group">
								<input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="serial-number" class="form-input">
							</div>
							
							
							<div class="form-group">
								<input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="serial-number" class="form-input">
							</div>
							
							
							<div class="form-group">
								<input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="serial-number" class="form-input">
							</div>
							
							
							<div class="form-group">
								<input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="serial-number" class="form-input">
							</div>
							
							
							<div class="form-group">
								<input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="serial-number" class="form-input">
							</div>
							
							
							<div class="form-group">
								<input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="serial-number" class="form-input">
							</div>
							
							
							<div class="form-group">
								<input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="serial-number" class="form-input">
							</div>
							
							<div class="form-group">
								<input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="serial-number" class="form-input">
							</div>
							
							<div class="form-group">
								<input type="text" id="product-name" value="LG 그램 노트북" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="return-date" value="2025-12-31" class="form-input" readonly>
							</div>
							<div class="form-group">
								<input type="text" id="serial-number" class="form-input">
							</div>
						</div>
					</div>
					
					
					

					<div class="button-group">
						<button type="button" class="btn btn-secondary">취소 (Cancel)</button>
						<button type="submit" class="btn btn-primary">등록 (Submit)</button>
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>