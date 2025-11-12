function setBoardParam(key, value) {
	const url = new URL(window.location.href);
	console.log("url 뭐니??"+ url)
	if (key != 'page'){
		url.search = ""; //모든 쿼리스트링 제거
		console.log("key는 뭐야?"+ key)
	}
	url.searchParams.set(key, value); 
	window.location.href = url.toString(); // url로 이동
}
