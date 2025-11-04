function setBoardParam(key, value) {
	const url = new URL(window.location.href);
	if (key != 'page'){
		url.search = ""; //모든 쿼리스트링 제거
	}
	url.searchParams.set(key, value); 
	window.location.href = url.toString(); // url로 이동
}
