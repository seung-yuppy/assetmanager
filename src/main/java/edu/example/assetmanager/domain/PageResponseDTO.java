package edu.example.assetmanager.domain;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class PageResponseDTO<T> {
    private List<T> content;   // 현재 페이지 데이터
    private int page;          // 현재 페이지 번호
    private int size = 10;          // 페이지 크기
    private int totalCount;    // 전체 결과 개수
    private int totalPages;    // 전체 페이지 수
    private int blockSize = 5;	//한번에 표시할 페이지 개수
    private int start; // 블럭 시작 페이지 번호
    private int end; // 블럭의 마지막 페이지 번호
    private boolean hasPrev;   // 이전 block 존재 여부
    private boolean hasNext;   // 다음 block 존재 여부
    
	public PageResponseDTO(int page, int totalCount, int totalPages, boolean hasPrev,
		boolean hasNext, int start, int end) {
		this.page = page;
		this.totalCount = totalCount;
		this.totalPages = totalPages;
		this.hasPrev = hasPrev;
		this.hasNext = hasNext;
		this.start = start;
		this.end = end;
	}
    
    
}
