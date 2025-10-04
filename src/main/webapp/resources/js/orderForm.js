// 1. 카테고리 선택 시 제품 목록 업데이트
function updateProductOptions() {
    const categorySelect = document.getElementById('category');
    const productNameGroup = document.getElementById('productGroup');
    const productNameSelect = document.getElementById('productName');
    const selectedCategory = categorySelect.value;
    
    // 이전 입력 필드 및 가격 초기화
    document.getElementById('price').value = 0;

}

//제품명 선택 시 호출되는 새로운 함수 (제품명 SELECT의 onchange에 연결)
function handleProductChange(selectedValue) {
    const productInputGroup = document.getElementById('productInputGroup');
    const priceInput = document.getElementById('price');

    // '직접 입력' 옵션 처리
    if (selectedValue === 'other') {
        // 직접 입력 필드를 보이게 설정
        productInputGroup.style.display = 'flex'; 
        
        // 가격 수정 가능하게 변경
        priceInput.readOnly = false;
        priceInput.classList.remove('price-lock');
        priceInput.value = '';
        
        // 사유는 직접 입력이므로 초기화 (선택 사항)
        document.getElementById('reason').value = ''; 
        
    } else {
        // 일반 제품 선택 시 숨기기
        productInputGroup.style.display = 'none';

        // 가격 수정 불가하게 변경 및 자동 입력 로직 호출
        priceInput.readOnly = true;
        priceInput.classList.add('price-lock');
        
        // ... (이전에 정의했던 가격 및 사유 자동 채우는 로직을 여기에 구현) ...
        // 예: updatePriceAndControls(selectedValue);
    }
}

/**
 구매 사유 영역의 글자수를 세고 표시를 업데이트하는 함수
 */
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