// 알림 더보기용 offset
let notificationOffset = 0;

function timeAgo(dateString) {
	const date = new Date(dateString);
	const now = new Date();
	const diff = (now - date) / 1000; // 초 단위 차이
	
	const minute = 60;
	const hour = 60 * minute;
	const day = 24 * hour;
	
	if (diff < minute) {
		return '방금 전';
	} else if (diff < hour) {
		const m = Math.floor(diff / minute);
		return `${m}분 전`;
	} else if (diff < day) {
		const h = Math.floor(diff / hour);
		return `${h}시간 전`;
	} else if (diff < day * 7) {
		const d = Math.floor(diff / day);
		return `${d}일 전`;
	} else {
		// 7일 이상이면 날짜 그대로 표시
		return date.toLocaleDateString();
	}
}

document.addEventListener('DOMContentLoaded', () => {
	// 알림 토글을 위한 요소 선택 (이미지 자체가 토글 버튼 역할을 하도록 설정)
	const bellImage = document.getElementById('bell-icon-button-img');
	const dropdown = document.getElementById('notification-dropdown');
	const bellWrapper = document.getElementById('notification-toggle');
	const notificationSection = document.querySelector('.notification-list');
	const getMoreBtn =  document.querySelector('.dropdown-footer');
	
	// 안읽은 알림 갯수 구하기
	getUnreadCount();
	
	// 알림 드롭다운 토글 함수
	function toggleDropdown() {
	    dropdown.classList.toggle('show'); 
	}
	
	// 종 아이콘 이미지 클릭 이벤트 리스너
	bellImage.addEventListener('click', (event) => {
		if(!isLoggedIn){
			alert("로그인이 필요합니다.");
			location.href = "/assetmanager/login";
		}
	    event.stopPropagation(); // 버튼 클릭이 body 클릭으로 전파되는 것을 방지
	    toggleDropdown();
	    initNotifications();
	});
	
	// 드롭다운 외부 클릭 시 닫기
	document.addEventListener('click', (event) => {
	    const isClickInside = bellWrapper.contains(event.target);
	    
	    // 드롭다운이 열려있고, 클릭이 알림 영역 전체 (toggle wrapper) 외부일 경우 닫기
	    if (dropdown.classList.contains('show') && !isClickInside) {
	        dropdown.classList.remove('show');
	    }
	});
	
	// Esc 키 입력 시 닫기
	document.addEventListener('keydown', (event) => {
	    if (event.key === 'Escape' && dropdown.classList.contains('show')) {
	        dropdown.classList.remove('show');
	    }
	});
	
	// 알림 항목 클릭 -> 알림 읽기 처리
	notificationSection.addEventListener('click', async (e) => {
		const item = e.target.closest('.notification-item');
		if (item){
			const targetId = item.getAttribute("data-target-id");
			const targetType = item.getAttribute("data-target-type");
			
			if(item.classList.contains('unread-notification')) // 안읽은 아이템 클릭 시
				read(item);
			// 이미 반납된 건은 페이지 이동 대신 모달경고.
			if (targetType == "return") {
			    try {
			        const res = await fetch(`/assetmanager/notification/return/check/${targetId}`);
			        const data = await res.json();

			        if (data) {
			            await Swal.fire('오류', '이미 반납 확인이 완료됐습니다.', 'warning');
			            return;
			        }
			    } catch (err) {
			        console.error("알림 읽기 실패:", err);
			    }
			}
			
			// 하이퍼링크 설정 및 이동
			let user_path;
			if(loginUser.role!=="employee"){
				user_path = "/" + loginUser.role; 
			}else{
				user_path="";
			}
			let path = `/assetmanager${user_path}/${targetType}/detail/${targetId}`; 
			
			location.href = path;
		}
	});
	
	// 알림 더보기 버튼 이벤트 리스너
	getMoreBtn.addEventListener('click', () =>  getNotifications(notificationOffset));
});

//읽은 알림의 표시 변화
function toReadUi(el){
	el.classList.remove("unread-notification");
	el.classList.add("read-notification");
	el.querySelector(".unread-dot").classList.add("spacer");
	el.querySelector(".unread-dot").classList.remove("unread-dot");
}

function read(el){
	const id = el.getAttribute('data-id');
	fetch(`/assetmanager/notification/read/${id}`)
		.then(() => {
			getUnreadCount();
			toReadUi(el);
		})
		.catch(err => console.error("알림 읽기 실패:", err));
}

function getUnreadCount(){
	fetch('/assetmanager/notification/unread/count')
		.then(res => res.text())
		.then(data => {
			const count = Number(data);
			if (count >= 1){
				const badge = document.getElementById('notification-badge');
			    badge.textContent = count;
			    badge.style.display='inline-flex';
			}else{
				document.getElementById('notification-badge').style.display='none';
			}
		})
		.catch(err => console.error("읽지 않은 알림 개수 불러오기 실패:", err));
}

function initNotifications(){
	notificationOffset = 0; 
	const notificationSection = document.querySelector('.notification-list');
	notificationSection.innerHTML = "";
	getNotifications(notificationOffset);
}

function getNotifications(offset){
	const container = document.querySelector('.notification-list');
	fetch(`/assetmanager/notification/list?offset=${offset}`)
    .then(res => res.json())
    .then(list => {
    	const getMoreBtn =  document.querySelector('.dropdown-footer');
    	// 새로 불러온 알림이 없고, offset이 0이면 -> 처음부터 없음
        if (list.length === 0 && offset === 0) {
            container.innerHTML = '<div class="no-notification">알림이 없습니다.</div>';
            getMoreBtn.style.display = 'none';
            return;
        }

        // 10개 미만이면 더보기 버튼 숨기기
        if (list.length < 10) {
            getMoreBtn.style.display = 'none';
        } else {
            getMoreBtn.style.display = 'block';
        }
    	
    	list.forEach((e) => {
    		const time = timeAgo(e.createDate);
    		let readClass;
    		let readDot;
    		if (e.read){
    			readClass = "read-notification"
    			readDot = "spacer";
    		}else{
    			readClass = "unread-notification"
    			readDot = "unread-dot";
    		}
    		const html = `
    			<div class="notification-item ${readClass}" data-id="${e.id}" data-target-id="${e.targetId}" data-target-type="${e.targetType}">
    				<div class="${readDot}"></div>
				    <div class="content">
				        <p> ${e.message}</p>
				        <p>${time}</p>
				    </div>
				</div>
    			`
			container.insertAdjacentHTML('beforeend', html);
        });
    	notificationOffset = offset + 10;
    })
    .catch(err => console.error("알림 불러오기 실패:", err));
}

