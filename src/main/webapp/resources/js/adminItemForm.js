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

//구매 요청할 제품 추가하는 함수 
function addProduct(){
	if (!checkProductCnt()){
		alert("요청 품목은 10개까지만 가능합니다.");
		return;
	}
	const currentIndex = ++productRowIndex;
	const targetEl = document.querySelector('#add-product-section');
	const newFormRowHTML = `
							<div class="form-row">
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label>
									<select name="items[${currentIndex}].categoryId" required>
										<option value="" disabled selected>선택하세요</option>
										<option value="1">노트북</option>
										<option value="2">모니터</option>
										<option value="3">태블릿</option>
										<option value="4">스마트폰</option>
										<option value="5">복합기</option>
										<option value="6">데스크탑</option>
										<option value="7">TV</option>
										<option value="8">프로젝터</option>
										<option value="9">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명<span class="required">*</span></label>
									<input type="text" name="items[${currentIndex}].itemName" placeholder="직접 입력">
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">단가 (원) <span class="required">*</span></label>
									<input type="number" name="items[${currentIndex}].price" value="0" min="0" required>
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">제조사 <span class="required">*</span></label>
									<input type="text" name="items[${currentIndex}].seller" required>
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">거래처 <span class="required">*</span></label>
									<input type="text" name="items[${currentIndex}].maker" required>
								</div>
								<div class="form-group fixed-width-xl">
									<label for="price">스펙<span class="required">*</span></label>
									<div class="last-input-group">
										<input type="text" name="items[${currentIndex}].spec" required>
										<img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)"></img>
									</div>							
								</div>
							</div>
	`
		targetEl.insertAdjacentHTML('beforebegin', newFormRowHTML);
}