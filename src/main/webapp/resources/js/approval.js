 document.addEventListener("DOMContentLoaded", function() {
    const approvalInfo = document.querySelectorAll(".approver-container.select-info");

    // 정보 반복해서 찾기
    approvalInfo.forEach(function(userInfo) {
        const select = userInfo.querySelector(".approver-select");
        const image = userInfo.querySelector(".approver-image");
        const dept = userInfo.querySelector(".approver-dept");

        // 정보 업데이트
        function updateInfo() {
            if (!select) return;
            const selectedOption = select.options[select.selectedIndex];
            if (!selectedOption) return;

            // data 속성값 가져오기
            const deptValue = selectedOption.dataset.dept;
            const altValue = selectedOption.dataset.alt;
            
            // Base64 문자열과 이미지 타입 읽기
            const base64String = selectedOption.dataset.imageBase64;
            const imageType = selectedOption.dataset.imageType; 

            // image.src를 데이터 URL 형식으로 설정
            if (base64String) {
                image.src = `data:${imageType};base64,${base64String}`;
            } else {
                image.src = "/assetmanager/resources/image/img_profile.png"; // 이미지 없는 경우
            }
            
            image.alt = altValue;
            dept.textContent = deptValue;
        }
        
        // 이미지 바꾸는 이벤트 
        if (select) {
            select.addEventListener("change", updateInfo);
        }

        updateInfo();
    });
});