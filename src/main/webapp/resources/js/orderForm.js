// 총액 자동 계산을 위한 이벤트 부착
const inputArea = document.getElementById('formInputArea');
inputArea.addEventListener('change',function(e){
	if (e.target && e.target.tagName === 'INPUT' && e.target.type === 'number'){
		calculateTotalPrice(e.target);
	}
})

function calculateTotalPrice(el){
	const row = el.closest('.form-row');
	const price = row.querySelector('input[name^="price"]').value;
	const quantity = row.querySelector('input[name^="quantity"]').value;
	const targetEl = row.querySelector('input[name^="totalPrice"]');
	
	targetEl.value = price * quantity;
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
								<div class="form-group fixed-width-sm">
									<label for="isDepartmentUse-${currentIndex}">부서 자산</label>
									<div>
										<input type="checkbox" id="isDepartmentUse-${currentIndex}" name="isDepartmentUse-${currentIndex}"> 
									</div>
								</div>
								<div class="form-group category-group fixed-width-med">
									<label for="category">카테고리 <span class="required">*</span></label>
									<select id="category" name="category-${currentIndex}" required onchange="updateProductOptions()">
										<option value="" disabled selected>선택하세요</option>
										<option value="notebook">노트북</option>
										<option value="monitor">모니터</option>
										<option value="software">소프트웨어</option>
										<option value="other">기타</option>
									</select>
								</div>
								<div class="form-group product-select-group fixed-width-lg">
									<label for="productNameSelect">제품명<span class="required">*</span></label>
									<input list="productOptions" name="productNameSelect-${currentIndex}" id="productNameSelect" placeholder="선택  또는 직접 입력">
									<datalist id="productOptions">
									    <option value="LG그램">
									    <option value="macbook 10">
									    <option value="직접 입력">
									</datalist>
								</div>
								<div class="form-group fixed-width-med">
									<label for="price">단가 (원) <span class="required">*</span></label>
									<input type="number" id="price" name="price-${currentIndex}" value="0" min="0" required>
								</div>

								<div class="form-group fixed-width-sm">
									<label for="quantity">수량 <span class="required">*</span></label>
									<input type="number" id="quantity" name="quantity-${currentIndex}" min="1" value="1" required>
								</div>
								<div class="form-group fixed-width-med">
									<label for="totalPrice">총액 (원)</label>
									<div class="last-input-group">
										<input type="text" id="totalPrice" name="totalPrice-${currentIndex}" value="0" class="locked-input" readonly>
										<img class="form-icon" src="/assetmanager/resources/image/icon_dash_circle.svg" onclick="removeProduct(this)"></img>
									</div>
								</div>
							</div>
	`
		targetEl.insertAdjacentHTML('beforebegin', newFormRowHTML);
}