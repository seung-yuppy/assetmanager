document.addEventListener("DOMContentLoaded", function() {
	const productModal = document.querySelector('#product-modal');  
	
	const addBtn = document.querySelector('.add-product-button');
	const category = document.querySelector('.category');
    const productNameSelect = document.querySelector('.productSelect');
    const numberSelect = document.querySelector('.numberSelect');
    
    function initCat() {
        if (category.value === '' || category.value === null) { 
            productNameSelect.disabled = true;    
        } else {
            productNameSelect.disabled = false;
        }
    }
    
    initCat();

    function checkCategory() {
    	productNameSelect.value = '';
    	numberSelect.value = 1;
        if (category.value === '' || category.value === null) {
            productNameSelect.disabled = true;    
        } else {
            productNameSelect.disabled = false;
      
        }
    }
    category.addEventListener('change', checkCategory);
    
	
	addBtn.addEventListener('click', () => {
		const categories = document.querySelectorAll('.category');
	    const productNameSelects = document.querySelectorAll('.productSelect');
	    const numberSelects = document.querySelectorAll('.numberSelect');
	    
	    function initCategory(category, productNameSelect) {
	        if (category.value === '' || category.value === null) { 
	            productNameSelect.disabled = true;    
	        } else {
	            productNameSelect.disabled = false;
	        }
	    }

	    function checkCategoryValue(category,productNameSelect, numberSelect) {
	    	productNameSelect.value = '';
	    	numberSelect.value = 1;
	        if (category.value === '' || category.value === null) {
	            productNameSelect.disabled = true;    
	        } else {
	            productNameSelect.disabled = false;
	        }
	    }
	    
	    categories.forEach((category, index)=> {
	    	const productName = productNameSelects[index];
	    	const selectNumber = numberSelects[index];
	    	
	    	category.addEventListener('change', () => {
	    		checkCategoryValue(category, productName, selectNumber)
	    	});
	    	initCategory(category, productName);
	    });
	})
	
    
    

	// 모달이 이 페이지에 없으면, JS가 더 이상 실행되지 않도록 막음
	if (!productModal) {
        return; 
    }
	
	const closeModalBtn = document.querySelector('.close-modal-btn');
	const searchInput = document.getElementById('product-search-input');
	const listBody = document.getElementById('asset-list-body');
	const formInputArea = document.getElementById('formInputArea');
		
	let activeProductNameInput = null;
	let currentFetchedAssets = [];
	
	const closeModal = () => {
    	productModal.classList.add('hidden');
    };
		
    function collectRequestedCounts() {
        const requestedMap = new Map();
        const rows = document.querySelectorAll('#formInputArea .form-row'); 
        
        rows.forEach(row => {
            const nameInput = row.querySelector('.productSelect');
            const quantityInput = row.querySelector('input[name*=".count"]');
            
            if (nameInput && quantityInput && nameInput.value.trim()) {
                const assetName = nameInput.value.trim();
                const quantity = parseInt(quantityInput.value) || 0; 
                
                if (nameInput === activeProductNameInput) {
                    return;
                }
                
                requestedMap.set(assetName, (requestedMap.get(assetName) || 0) + quantity);
            }
        });
        return requestedMap;
    }
		
	const renderAssetList = (filter = '') => {
		listBody.innerHTML = '';
        
        const requestedCounts = collectRequestedCounts();
        const lowercasedFilter = filter.toLowerCase();
        
        const filteredData = currentFetchedAssets.filter(asset =>
        asset.assetName.toLowerCase().includes(lowercasedFilter) || 
        (asset.spec && asset.spec.toLowerCase().includes(lowercasedFilter)) ||
        String(asset.count).includes(lowercasedFilter)
    );
 
        if (filteredData.length === 0) {
        	listBody.innerHTML = '<tr><td colspan="3" style="text-align: center; padding: 1rem;">검색 결과가 없습니다.</td></tr>';
            return;
        }

        filteredData.forEach(asset => {
            const assetName = asset.assetName;
            let availableCount = asset.count;
            const requested = requestedCounts.get(assetName) || 0;
            
            // 총 재고
            availableCount = availableCount - requested;
            const AssetCount = Math.max(0, availableCount); 
            
            const tr = document.createElement('tr');

			// 0 이면 선택 불가능
			if (AssetCount === 0) {
			    tr.classList.add('disabled-asset');
			}
            tr.innerHTML = `<td>${assetName}</td><td>${asset.spec || ''}</td><td>${AssetCount || '0'}</td>`;
            
			if (AssetCount > 0) {
	            tr.addEventListener('click', () => {
	            	const assetId = asset.id; 
	                const assetName = asset.assetName;
	                const maxCount = AssetCount; 
	            	
	                if (activeProductNameInput) {
	                    activeProductNameInput.value = assetName;
	                    
	                    // 숨겨진 assetId 값 찾기
	                    const parentRow = activeProductNameInput.closest('.form-row');
	                    if (parentRow) {
	                    	const quantityInput = parentRow.querySelector('input[type="number"][name*=".count"]');
	                    	const hiddenInput = parentRow.querySelector('input[name="items[0].assetId"], input[name*="items["][name*="].assetId"]');
	                        
	                        if (quantityInput) {
	                            const finalMaxCount = parseInt(maxCount);
	                            
	                            // max 속성 설정 
	                            quantityInput.setAttribute('max', finalMaxCount);
	
	                            // max를 초과하면 조정
	                            if (parseInt(quantityInput.value) > finalMaxCount || parseInt(quantityInput.value) < 1) {
	                                quantityInput.value = finalMaxCount > 0 ? 1 : 0;
	                            }                          
	                            quantityInput.disabled = false;
	                        }
	                        
	                        if(hiddenInput) {                 
	                            hiddenInput.value = assetId;
	                        }
	                    }
	                }
	                closeModal();
	            });
			}
            listBody.appendChild(tr);
        });
	};
        if (formInputArea) {
            formInputArea.addEventListener('click', (e) => {
                if (e.target.classList.contains('productSelect')) {
     
                    // 클릭한 입력창 저장
                    activeProductNameInput = e.target;

                    // 현재 카테고리 값에서 가까운 부모
                    const parentRow = e.target.closest('.form-row');
                    
                    // select 찾기
                    const categorySelect = parentRow.querySelector('select[name="category"]');
                    
    				if (!categorySelect) {
    					return;
    				}
    				
    				// 현재 category 값 찾기
                    const selectedCategory = categorySelect.value;

                    // 카테고리 값
                    let categoryId = 0;
                    switch (selectedCategory) {
                        case "notebook":categoryId = 1; break;
                        case "monitor":categoryId = 2; break; 
                        case "tablet":categoryId = 3; break; 
                        case "smartphone":categoryId = 4; break; 
                        case "multiprinter":categoryId = 5; break; 
                        case "desktop":categoryId = 6; break; 
                        case "tv":categoryId = 7; break; 
                        case "projector":categoryId = 8; break;                   
                        case "other":categoryId = 9; break;                   
                        default: 
                            categoryId = 0;
                    }
                    
                    // 자산 데이터 요청
                    fetch(`/assetmanager/rent/assets?categoryId=${categoryId}`)
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('서버 응답 오류');
                            }
                            return response.json(); 
                        })
                        .then(assets => {
                            // 받아온 데이터 저장
                            currentFetchedAssets = assets; 
                            
                         // 전체 불러오기
                            renderAssetList(); 
                            
                            // 모달 열기
                            productModal.classList.remove('hidden');
                            searchInput.value = '';
                            searchInput.focus();
                        })
                        .catch(error => {                      
                            listBody.innerHTML = '<tr><td colspan="2">자산을 불러오는 데 실패했습니다.</td></tr>';
                            productModal.classList.remove('hidden'); 
                        });
                }
            });
        }
		
        if(closeModalBtn) { 
        	closeModalBtn.addEventListener('click', closeModal);
        }
		
        if(searchInput) {
        	searchInput.addEventListener('input', (e) => renderAssetList(e.target.value));
        }
        
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && !productModal.classList.contains('hidden')) {
            	closeModal();
            }
        });
});