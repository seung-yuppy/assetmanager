<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="currentDate" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원 반출 요청</title>
<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
<link href="/assetmanager/resources/css/rentRequest.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>
<body>
	<div class="app-layout">
		<!-- 사이드바 불러오기 -->
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>

		<!-- 반출 요청 폼 -->
		<div class="main-content">
			<div class="content-wrapper">
				<h1 class="content-title">반출 신청</h1>
				<p class="content-description">새로운 반출 요청을 생성하려면 아래 양식을 작성하세요. 모든 필수 필드를 정확하게 기입해야 합니다.</p>

				<form>
					<h2 class="form-section-title">결제라인</h2>
					<!-- 결재라인 전체 컨테이너 -->
					<div id="approval-line-container">

						<!-- 첫 번째 : 신청자 -->
						<div class="approver-item">
							<div class="approval-type-box">요청자</div>
							<div class="approver-image-container">
								<img class="approver-image" src="https://placehold.co/100x100/f6d5de/31343C?text=KYN" alt="강예나">
								<div class="approval-badge">
									<div class="approval-badge-icon">
										<i class="fas fa-check"></i>
									</div>
								</div>
							</div>
							<div class="approver-info">
								<div class="name-title">
									강예나 <span class="title">사원</span>
								</div>
								<div class="team">(개발팀)</div>
							</div>
						</div>

						<!-- 화살표 -->
						<div class="arrow-separator">
							<i class="fas fa-chevron-right"></i>
						</div>

						<!-- 중간 결재자(협의) -->
						<div class="approver-item">
							<div class="approval-type-box">일반결재</div>
							<div class="approver-image-container">
								<img class="approver-image" src="https://placehold.co/100x100/d5e4f6/31343C?text=LYH" alt="이영호">
								<div class="approval-badge">
									<div class="approval-badge-icon">
										<i class="fas fa-check"></i>
									</div>
								</div>
							</div>
							<div class="approver-info">
								<div class="name-title">														
									<select id="category" class="form-input rent-input">									
										<option>이영호 팀장</option>
										<option>송승엽 과장</option>
										<option>김성배 과장</option>
										<option>홍길동 대리</option>
										<option>김둘리 대리</option>
									</select>									
								</div>
								<div class="team">(경영팀)</div>
							</div>
						</div>

						<!-- 화살표 -->
						<div class="arrow-separator">
							<i class="fas fa-chevron-right"></i>
						</div>

						<!-- 최종 결재자 -->
						<div class="approver-item">
							<div class="approval-type-box">최종결재</div>
							<div class="approver-image-container">
								<img class="approver-image" src="https://placehold.co/100x100/d5f6e4/31343C?text=SAY" alt="신아영">
								<div class="approval-badge">
									<div class="approval-badge-icon">
										<i class="fas fa-check"></i>
									</div>
								</div>
							</div>
							<div class="approver-info">
								<div class="name-title">						
									<select id="category" class="form-input rent-input">									
										<option>신아영 부장</option>
										<option>송승엽 과장</option>
										<option>김성배 과장</option>
										<option>홍길동 대리</option>
										<option>김둘리 대리</option>
									</select>								
								</div>
								<div class="team">(사업본부)</div>
							</div>
						</div>

					</div>























					<h2 class="form-section-title">요청 세부 정보</h2>
					<div class="form-row" style="margin-bottom: 20px;">
						<div class="form-group radio-input-group">
							<div class="radio-input">
								<input type="radio" id="inputMethodForm" name="inputMethod" value="form" checked onclick="showInputForm('form')"> <label for="inputMethodForm">폼 직접 입력 </label>
							</div>
							<div class="radio-input">
								<input type="radio" id="inputMethodExcel" name="inputMethod" value="excel" onclick="showInputForm('excel')"> <label for="inputMethodExcel">엑셀 파일 업로드</label>
							</div>
						</div>
					</div>

					<div id="formInputArea">
						<div class="form-section">
							<h2 class="form-section-title">제품 정보</h2>
							<div class="form-grid grid-cols-3">
								<div class="form-group">
									<label for="category">제품 카테고리</label> <select id="category" class="form-input rent-input">
										<option>카테고리 선택</option>
										<option>노트북</option>
										<option>모니터</option>
										<option>키보드/마우스</option>
										<option>소프트웨어</option>
									</select>
								</div>
								<div class="form-group">
									<label for="product-name">제품명</label> <input type="text" id="product-name" placeholder="초고속 무선 충전기" class="form-input rent-input">
								</div>
								<div class="form-group">
									<label for="count">수량</label> <input type="number" id="count" placeholder="1" class="form-input rent-input">
								</div>
							</div>
						</div>

						<div class="form-section">
							<h2 class="form-section-title">반출 신청 세부 정보</h2>
							<div class="form-grid grid-cols-2">
								<div class="form-group">
									<label for="application-date">반출 신청일</label> <input type="date" id="application-date" value="${currentDate}" class="form-input rent-input" readonly>
								</div>
								<div class="form-group">
									<label for="return-date">반납 예정일</label> <input type="date" id="return-date" placeholder="반납 예정일 선택" class="form-input rent-input">
								</div>
								<div class="form-group col-span-full">
									<label for="reason">반출 요청 사유 <span class="required">*</span></label>
									<textarea id="reason" name="reason" rows="4" required placeholder="반출 요청이 필요한 구체적인 구체적인 사유를 입력해주세요." maxlength="200" onkeyup="updateCharCount(this, 200)" class="rent-input"></textarea>
									<div class="char-count-display text-align-right">
										(<span id="currentLength">0</span> / 200)
									</div>
								</div>
							</div>
						</div>

						<div class="form-group checkbox-group">
							<input type="checkbox" id="isDepartmentUse" name="isDepartmentUse"> <label for="isDepartmentUse">부서 공동 사용 자산입니다.</label>
							<p class="description">체크 시, 해당 자산은 특정 개인 소유가 아닌 부서 공동 자산으로 등록됩니다.</p>
						</div>
					</div>

					<div id="excelUploadArea" style="display: none;">
						<div class="form-group file-upload-group">
							<span>다음 양식 파일을 다운로드하여 요청 세부 사항을 기입하고 업로드하세요.</span>
							<button type="button" style="margin-bottom: 20px;" onclick="downloadExcelTemplate()">⬇️ 템플릿 다운로드</button>
							<label for="excelFile">엑셀 파일 선택 <span class="required">*</span></label> <input type="file" id="excelFile" name="excelFile" accept=".xlsx, .xls">
						</div>
					</div>


					<div class="button-group">
						<button type="button" class="btn btn-secondary">취소 (Cancel)</button>
						<button type="submit" class="btn btn-primary">신청 (Submit)</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="/assetmanager/resources/js/rent.js"></script>
</body>
</html>