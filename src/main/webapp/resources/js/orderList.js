function setBoardParam(key, value) {
	const url = new URL(window.location.href);
	url.searchParams.delete('page');
	if (value != null){
		url.searchParams.set(key, value);  // 기존 query 유지하면서 order만 세팅
	}else{
		url.searchParams.delete(key);
	}
	window.location.href = url.toString(); // url로 이동
}



