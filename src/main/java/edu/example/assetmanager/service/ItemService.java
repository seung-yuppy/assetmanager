package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ItemDAO;
import edu.example.assetmanager.domain.ItemDTO;

@Service
public class ItemService {

	@Autowired
	ItemDAO dao;
	
	// 카테고리 전처리
	public void processCategory(ItemDTO dto) {
		switch(dto.getCategoryId()) {
			case 1:
				dto.setCategory("노트북");
				break;
			case 2:
				dto.setCategory("모니터");
				break;
			case 3:
				dto.setCategory("태블릿");
				break;
			case 4:
				dto.setCategory("스마트폰");
				break;
			case 5:
				dto.setCategory("복합기");
				break;
			case 6:
				dto.setCategory("데스크탑");
				break;
			case 7:
				dto.setCategory("TV");
				break;
			case 8:
				dto.setCategory("프로젝터");
				break;
			default:
				dto.setCategory("기타");
				break;
		}
	}
	
	// 목록 데이터 가공
	public List<ItemDTO> refactorList(List<ItemDTO> list) {
		if (list != null) {
			for (ItemDTO dto : list) 
				processCategory(dto);
		}
		return list;
	}
	
	// 페이징 처리된 목록을 가져오는 메서드
	public List<ItemDTO> getPagedList(int page) {
		int pageSize = 10;
		int start = (page - 1) * pageSize + 1;
		int end = start + pageSize - 1;
		List<ItemDTO> list = dao.listAll(start, end);
		return refactorList(list);
	}
	
	// 총 페이지 수를 계산하는 메서드
	public int getTotalPages() {
		int pageSize = 10;
		int totalItems = dao.countAll();
		return (int)Math.ceil((double) totalItems / pageSize);
	}
	
	// 제품 추가 메서드
	public boolean addItem(List<ItemDTO> items) {
		if (items == null || items.isEmpty())
			return false;
		
		for (ItemDTO item : items)
			dao.addItem(item);
		
		return true;
	}
	
	// 제품 삭제 메서드
	public boolean removeItem(int id) {
		if (dao.removeItem(id))
			return true;
		else
			return false;
	}
}
