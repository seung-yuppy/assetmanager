<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>자산 관리 시스템 - 로그인</title>
    <link href="resources/css/common.css" rel="stylesheet">    
	<link href="resources/css/user.css" rel="stylesheet"> 
</head>
<body>
    <div class="split-wrapper">
        <!-- 왼쪽 패널: 시스템 설명 -->
        <div class="splash-panel">
            <h2>자산 관리 시스템 (AMS)</h2>
            <p>
            	귀사의 모든 자산을 효율적으로 등록, 추적, 관리할 수 있는 통합 솔루션입니다.
            </p>
            <ul>
                <li>실시간 자산 현황 모니터링</li>
                <li>자산 위치 및 담당자 추적</li>
                <li>자산 요청 및 등록 관리</li>
            </ul>
        </div>
        
        <!-- 오른쪽 패널: 로그인 폼 -->
        <div class="login-container">
            <!-- 헤더 및 로고 -->
            <div class="login-header">
                <div class="icon-box">
					<img class="icon-item" src="resources/image/icon_main.svg" />
                </div>
                <h1>AMS 로그인</h1>
            </div>

            <!-- 로그인 폼 -->
            <form action="/assetmanager/login" method="post" class="join-form">
                <div class="form-group">
                    <label for="username">사용자 ID</label>
                    <input type="text" name="empNo" placeholder="사번을 입력하세요" required>
                </div>
                
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" name="password" placeholder="비밀번호를 입력하세요" required>
                </div>

                <button type="submit" class="main-button">로그인</button>
            </form>

            <!-- 추가 링크 (비밀번호 찾기, 회원가입 등) -->
            <div class="extra-links">
                <a href="/assetmanager/join" onclick="transitionPage(event, this)">계정 생성</a>
            </div>
        </div>
    </div>
        
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script src="resources/js/user.js"></script>
	<script src="resources/js/userNotice.js"></script>
	
	<c:if test="${not empty loginAdminSuccess}">
    	<script>
	    	Swal.fire({
	            icon: 'success',
	            title: '로그인 성공',
	            text: '${loginAdminSuccess}',
	            preConfirm: () => {
	            	location.href = '/assetmanager/admin/home'
	            }
	        });    	
    	</script>
    </c:if>
    
    <c:if test="${not empty loginUserSuccess}">
    	<script>
	    	Swal.fire({
	            icon: 'success',
	            title: '로그인 성공',
	            text: '${loginUserSuccess}',
	            preConfirm: function() {
	            	location.href = '/assetmanager/home';
	            }
	        });    	
    	</script>    
    </c:if>
	
    <c:if test="${not empty loginError}">
    	<script>
	    	Swal.fire({
	            icon: 'error',
	            title: '로그인 실패',
	            text: '${loginError}'
	        });    	
    	</script>
    </c:if>
</body>
</body>
</html>