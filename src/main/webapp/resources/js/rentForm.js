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
		alert("요청 품목은 10개까지만 가능합니다.");
		return;
	}
	const currentIndex = ++productRowIndex;
	const targetEl = document.querySelector('#add-product-section'); 
	const newFormRowHTML = `
							<div class="form-row">
								<div class="form-group fixed-width-sm">
									<label for="isDepartmentUse">부서 자산</label> <input type="checkbox" id="isDepartmentUse" name="isDepartmentUse">
								</div>
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label> <select id="category" name="category" required onchange="updateProductOptions()">
										<option value="" disabled selected>선택하세요</option>
										<option value="notebook">노트북</option>
										<option value="monitor">모니터</option>
										<option value="software">소프트웨어</option>
										<option value="other">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명<span class="required">*</span></label> <input list="productOptions" name="productNameSelect" id="productNameSelect" placeholder="선택  또는 직접 입력">
									<datalist id="productOptions">
										<option value="LG그램">
										<option value="macbook 10">
										<option value="직접 입력">
									</datalist>
								</div>
								<div class="form-group fixed-width-sm">
									<label for="quantity">수량 <span class="required">*</span></label>
									<div class="last-input-group">
										<input type="number" id="quantity" name="quantity" min="1" value="1" required> <img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)"></img>
									</div>
								</div>

							</div>
	`
		targetEl.insertAdjacentHTML('beforebegin', newFormRowHTML);
}




