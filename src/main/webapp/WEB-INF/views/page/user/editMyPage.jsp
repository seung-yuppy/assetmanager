<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 상세</title>
	<link href="/assetmanager/resources/css/common.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/rentList.css" rel="stylesheet">
	<link href="/assetmanager/resources/css/user.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" >	
</head>
<body>
	<div class="app-layout">
		<%@ include file="/WEB-INF/views/component/sideMenu.jsp"%>
		<div class="main-content">
			<%@ include file="/WEB-INF/views/component/header.jsp"%>
			<div class="dashboard-container">
				<h1>${userInfo.username} ${userInfo.position}님의 수정 페이지</h1>
				<div class="detail-header">
					<span>${userInfo.username} ${userInfo.position}님의 정보를 수정합니다.</span>	
				</div>
				
				<div class="section-card">
					<h2>사용자 수정</h2>
					<form action="/assetmanager/change/userinfo" method="POST" enctype="multipart/form-data" class="profile-edit-form">
						<div class="edit-container">
							<div class="edit-image-box">
								<img src="data:image/png;base64,${userInfo.base64ProfileImage}" class="my-profile-image" id="profilePreview" >
                                <div class="edit-image-button">
                                    <label for="fileInput" class="edit-label">
                                        <span class="btn-label"><i class="fa-solid fa-camera"></i> 사진 변경</span>
                                    </label>
                                    <input type="file" id="fileInput" name="profileImage" accept="image/*" class="file-input">
                                </div>
							</div>
							<div class="profile-wrapper">
								<div class="profile-box">
									<div class="edit-user-info">
										<span class="user-label">사번</span> 
										<input type="text" value="${userInfo.empNo}" class="user-value" readonly>							
									</div>
									<div class="edit-user-info">
										<span class="user-label">부서</span> 
										<input type="text" value="${userInfo.deptName}" class="user-value" readonly>							
									</div>		
									<div class="edit-user-info">
										<span class="user-label">직급</span> 
										<input type="text" value="${userInfo.position}" class="user-value" readonly>							
									</div>
									<div class="edit-user-info">
										<span class="user-label">주소</span> 
										<input type="email" value="${userInfo.deptAddress}" class="user-value" readonly>							
									</div>									
									<div class="edit-user-info">
										<span class="user-label">이메일</span> 
										<input type="text" value="${userInfo.email}" name="email" class="user-value">							
									</div>		
									<div class="edit-user-info">
										<span class="user-label">전화번호</span> 
										<input type="text" value="${userInfo.phone}" name="phone" class="user-value">							
									</div>	
								</div>
							</div>		
						</div>
						<div class="edit-total-button">
							<button type="submit" class="edit-button">수정 완료</button>	
						</div>
					</form>
				</div>
				
			</div>
		</div>
	</div>
	
    <script>
        // DOM 요소 가져오기
        const fileInput = document.getElementById('fileInput');
        const profilePreview = document.getElementById('profilePreview');

        // 파일 입력(fileInput)에 'change' 이벤트 리스너 추가
        fileInput.addEventListener('change', function(event) {
            
            // 사용자가 선택한 파일 가져오기 (첫 번째 파일)
            const file = event.target.files[0];

            // 파일이 선택되었는지 확인
            if (file) {
                // FileReader 객체 생성: 파일을 비동기적으로 읽어들입니다.
                const reader = new FileReader();
                
                // 파일 읽기가 완료되었을 때 실행될 콜백 함수
                reader.onload = function(e) {
                    // 읽어들인 파일 데이터를 이미지 미리보기(profilePreview)의
                    // 'src' 속성에 설정합니다. (e.target.result는 base64 인코딩된 이미지 데이터입니다)
                    profilePreview.src = e.target.result;
                }
                
                // 파일을 Data URL (base64) 형식으로 읽기 시작
                reader.readAsDataURL(file);
            }
        });
    </script>	
</body>
</html>