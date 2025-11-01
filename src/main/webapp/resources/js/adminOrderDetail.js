document.querySelectorAll(".form-row").forEach(row => calculateTotalPrice(row));

function calculateTotalPrice(row){
	const price = row.querySelector('input[name*="price"]').getAttribute("data-value");
	const quantity = row.querySelector('input[name*="count"]').value;
	const targetEl = row.querySelector('input[name*="totalPrice"]');
	
	targetEl.value = (price * quantity).toLocaleString();
}