<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 반출 요청</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/sideMenu.css" rel="stylesheet"> 
	<link href="/assetmanager/resources/css/rentRequest.css" rel="stylesheet">
</head>
<body>
	<div class="app-layout">
		<!-- 사이드바 불러오기 -->
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<!-- 반출 요청 폼 -->
		<div class="main-content"> 
			<div class="content-wrapper">
				<h1 class="content-title">반출 신청</h1>
				<p class="content-description">새로운 반출 요청을 생성하려면 아래 양식을 작성하세요. 모든
					필수 필드를 정확하게 기입해야 합니다.</p>

				<form>
					<div class="form-section">
						<h2 class="form-section-title">신청자 정보</h2>
						<div class="form-grid grid-cols-3">
							<div class="form-group">
								<label for="name">이름</label> <input type="text" id="name"
									value="홍길동" class="form-input">
							</div>
							<div class="form-group">
								<label for="department">부서명</label> <input
									type="text" id="department" value="마케팅팀" class="form-input">
							</div>
							<div class="form-group">
								<label for="position">직위</label> <input type="text"
									id="position" value="팀장" class="form-input">
							</div>
							<div class="form-group col-span-full">
								<label for="address">주소</label>
								<textarea id="address" rows="3" class="form-input">서울특별시 강남구 테헤란로 123</textarea>
							</div>
						</div>
					</div>

					<div class="form-section">
						<h2 class="form-section-title">제품 정보</h2>
						<div class="form-grid grid-cols-2">
							<div class="form-group">
								<label for="category">제품 카테고리</label> <select
									id="category" class="form-input">
									<option>카테고리 선택</option>
									<option>노트북</option>
									<option>모니터</option>
									<option>키보드/마우스</option>
									<option>소프트웨어</option>
								</select>
							</div>
							<div class="form-group">
								<label for="product-name">제품명</label> <input
									type="text" id="product-name" placeholder="초고속 무선 충전기"
									class="form-input">
							</div>
						</div>
					</div>

					<div class="form-section">
						<h2 class="form-section-title">반출 신청 세부 정보</h2>
						<div class="form-grid grid-cols-2">
							<div class="form-group col-span-full">
								<label for="reason">반출 사유</label>
								<textarea id="reason" rows="4" class="form-input">프로젝트를 위한 임시 사용</textarea>
							</div>
							<div class="form-group">
                                <label for="application-date">반출 신청일</label>
                                <input type="date" id="application-date" value="${currentDate}" class="form-input" readonly>
                            </div>
							<div class="form-group">  
								<label for="return-date">반납 예정일</label> <input
									type="date" id="return-date" placeholder="반납 예정일 선택"
									class="form-input">
							</div>
						</div>
					</div>

					<div class="button-group">
						<button type="button" class="btn btn-secondary">취소
							(Cancel)</button>
						<button type="submit" class="btn btn-primary">신청 (Submit)
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>