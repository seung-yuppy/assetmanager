document.addEventListener('DOMContentLoaded', function() {
	const tableBody = document.querySelector('.data-table tbody');
	
	if (tableBody) {
        tableBody.addEventListener('click', function(event) { 
        	const row = event.target.closest('tr');
        	if(row){
        		const id = row.getAttribute('data-id');
        		window.location.href=`detail?id=${id}`;
        	}
        });
	}
});
