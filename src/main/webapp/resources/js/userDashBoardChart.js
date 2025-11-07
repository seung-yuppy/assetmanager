document.addEventListener('DOMContentLoaded', () => {
	
	const dateBox = document.querySelectorAll('.asset-date');
	
	dateBox.forEach((date) => {
		const startDateStr = date.getAttribute("data-rent");
		const endDateStr = date.getAttribute("data-return");
		
		const parseDateString = (str) => {
			if (!str) return null;
			const parts = str.split(' ');
			const rearrangedStr = `${parts[1]} ${parts[2]} ${parts[5]} ${parts[3]}`;
			
			return new Date(rearrangedStr);
		};

		const startDate = parseDateString(startDateStr);
		const endDate = parseDateString(endDateStr);
	    const todayDate = new Date();
	    
	    const MS_PER_DAY = 1000 * 60 * 60 * 24;
	    
	    const totalTime = endDate.getTime() - startDate.getTime();
	    const elapsedTime = todayDate.getTime() - startDate.getTime();

	    const totalDays = Math.round(totalTime / MS_PER_DAY);
	    const elapsedDays = Math.round(elapsedTime / MS_PER_DAY);
	    
	    const todayUtc = Date.UTC(todayDate.getFullYear(), todayDate.getMonth(), todayDate.getDate());
	    const endUtc = Date.UTC(endDate.getFullYear(), endDate.getMonth(), endDate.getDate());

	    const remainingTime = endUtc - todayUtc;
	    const remainingDays = Math.round(remainingTime / MS_PER_DAY);
	    
	    // ⭐️ [수정 1] D-Day 레이블 찾기
        // 현재 <td>(date)의 부모인 <tr>을 찾은 뒤,
        // 그 <tr> 안에서 .d-day-label을 찾습니다.
        const row = date.closest('tr'); // 가장 가까운 부모 <tr>
        const dDayLabel = row.querySelector('.d-day-label'); // ID 대신 class로 검색

        if (dDayLabel) { // dDayLabel이 존재하는지 확인
            if (remainingDays < 0) {
                dDayLabel.textContent = `D+${Math.abs(remainingDays)}`;
                dDayLabel.classList.add('over');
            } else if (remainingDays === 0) {
                dDayLabel.textContent = 'D-DAY';
            } else {
                dDayLabel.textContent = `D-${remainingDays}`;
            }
        }

        // --- (진행률 계산 로직은 그대로 사용) ---
        let progressPercent = 0;
        if (totalDays > 0) {
            progressPercent = (elapsedDays / totalDays) * 100;
        }
        progressPercent = Math.max(0, Math.min(100, progressPercent));

        // ⭐️ [수정 2] 진행률 바(Progress Bar) 찾기
        // document 전체가 아닌, 현재 <td>(date) 내부에서 .progress-bar-inner를 찾습니다.
        const progressBar = date.querySelector('.progress-bar-inner');
        
        // ⭐️ [수정 3] :root 변수 대신, 찾은 요소에 직접 스타일 적용
        if (progressBar) { // progressBar가 존재하는지 확인
            progressBar.style.width = `${progressPercent.toFixed(2)}%`;
        }
		
	});
});