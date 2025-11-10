// 제품 추가/제거 관련
let productRowIndex  = 0;

function removeProduct(btn){
	btn.closest(".form-row").remove();
}

function checkProductCnt(){
	const rows =  document.querySelectorAll(".form-row");
	const cnt = rows.length;
	if (cnt <10){
		return true;
	}else{
		return false
	}
}


//반출 요청할 제품 추가하는 함수 
function addProduct(){
	if (!checkProductCnt()){
		Swal.fire('입력 초과', '최대 10개까지 입력가능합니다.', 'warning');
		return;
	}
	const currentIndex = ++productRowIndex;
	const targetEl = document.querySelector('#add-product-section'); 
	const newFormRowHTML = `
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label> 
									<select class="category" name="category" required>
										<option value="" disabled selected>선택하세요</option>
										<option value="notebook">노트북</option>
										<option value="monitor">모니터</option>
										<option value="tablet">태블릿</option>
										<option value="smartphone">스마트폰</option>
										<option value="multiprinter">복합기</option>
										<option value="desktop">데스크탑</option>
										<option value="tv">TV</option>
										<option value="projector">프로젝터</option>
										<option value="other">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label>제품명<span class="required">*</span></label> 
									<input list="productOptions" name="items[${currentIndex}].assetName" class="productSelect" placeholder="선택  또는 직접 입력" data-target="product-modal" required>
								</div>
								<div class="form-group fixed-width-sm">
									<label for="quantity">수량 <span class="required">*</span></label>
									<div class="last-input-group">
										<input type="number" id="quantity" name="items[${currentIndex}].count"  class="numberSelect" min="1" value="1" required> <img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)"></img>
									</div>
								</div>							
							</div>  
	`
		targetEl.insertAdjacentHTML('beforebegin', newFormRowHTML);
} 

//사유 영역의 글자수를 세고 표시를 업데이트하는 함수
function updateCharCount(textarea, maxLength) {
    const currentLength = textarea.value.length;
    const displayElement = document.getElementById('currentLength');
    
    if (displayElement) {
        // 현재 글자수를 업데이트
        displayElement.textContent = currentLength;
        
        // (선택 사항) 최대 길이에 도달했을 때 색상 변경
        if (currentLength >= maxLength) {
            displayElement.style.color = '#dc3545'; // 경고색 (빨간색)
        } else {
            displayElement.style.color = '#6c757d'; // 기본색 (회색)
        }
    }
}

//이벤트 부착 : 제목 추가용 
const requestForm = document.getElementById('requestForm');
requestForm.addEventListener('submit', openSubmitModal);

// 체출 확인 모달
function openSubmitModal(e){
    e.preventDefault(); // 폼 제출 막기
    Swal.fire({
      title: "성공",
      text: "반출 요청이 완료되었습니다.",
      icon: "success",
      confirmButtonColor: "#a5dc86",
      confirmButtonText: "확인",
   }).then(() =>{
      e.target.submit();
   });
}


