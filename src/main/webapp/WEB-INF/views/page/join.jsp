<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <title>자산 관리 시스템 - 회원가입</title>
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
                <li>자동 감가상각 및 보고서 생성</li>
                <li>위치 및 담당자 추적</li>
                <li>유지보수 일정 관리</li>
            </ul>
        </div>
        
        <!-- 오른쪽 패널: 회원가입 폼 -->
        <div class="login-container">
            <!-- 헤더 및 로고 -->
            <div class="login-header">
                <div class="icon-box">
					<img class="icon-item" src="resources/image/icon_main.svg" />
                </div>
                <h1>AMS 회원가입</h1>
            </div>

            <!-- 회원가입 폼 -->
            <form action="" method="post">
                <div class="form-group">
                    <label for="username">사용자 이름</label>
                    <input type="text" id="username" name="username" placeholder="성함 또는 닉네임" required>
                </div>
                
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호 설정" required>
                </div>

                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="user@example.com" required>
                </div>
                
                <div class="form-group">
                    <label for="phone">전화번호</label>
                    <input type="tel" id="phone" name="phone" placeholder="010-1234-5678" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" required>
                </div>

                <button type="submit" class="main-button">가입 완료</button>
            </form>

            <!-- 추가 링크 (로그인으로 돌아가기) -->
            <div class="extra-links">
                <a href="/assetmanager/login" onclick="transitionPage(event, this)">이미 계정이 있으신가요?</a>
            </div>
        </div>
    </div>
	<script src="resources/js/user.js"></script>
</body>
</html>