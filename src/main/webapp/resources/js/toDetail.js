document.addEventListener('DOMContentLoaded', function() {
	const tableBody = document.querySelector('.data-table tbody');
	
	if (tableBody) {
        tableBody.addEventListener('click', function(event) { 
        	window.location.href="detail"
        });
	}
});
