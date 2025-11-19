package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ItemDAO;
import edu.example.assetmanager.domain.ItemDTO;
import edu.example.assetmanager.domain.ItemParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ItemService {

	private final ItemDAO dao;
	
	private PageResponseDTO<ItemDTO> paging(ItemParamDTO dto, int totalCount) {
		final int PAGE_SIZE = 10;
		final int BLOCK_SIZE = 5;
		int page = dto.getPage();
		int offset = page > 0 ? (page - 1) * PAGE_SIZE : 0;
		dto.setOffset(offset);
		int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
		int totalBlocks = (int) Math.ceil((double) totalPages / BLOCK_SIZE);
		int block = (int) Math.ceil((double) page / BLOCK_SIZE);
		if (totalBlocks < 0)
			totalBlocks = 0;
		int blockStart = (block - 1) * BLOCK_SIZE + 1;
		int blockEnd = block < totalBlocks ? block * BLOCK_SIZE : totalPages;
		boolean hasPrev = block > 1 ? true : false;
		boolean hasNext = totalBlocks > block ? true : false;
		return new PageResponseDTO<ItemDTO>(page, totalCount, totalPages, hasPrev, hasNext, blockStart, blockEnd);
	}
	
	public int getTotalPages(ItemParamDTO dto) {
		int pageSize = 10;
		int totalItems = dao.countAll(dto);
		return (int) Math.ceil((double) totalItems / pageSize);
	}
	
	public PageResponseDTO<ItemDTO> listAll(ItemParamDTO dto) {
		int totalCount = dao.countAll(dto);
		PageResponseDTO<ItemDTO> response = paging(dto, totalCount);
		List<ItemDTO> list = dao.listAll(dto);
		response.setContent(list);
		return response;
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
	
	public List<ItemDTO> getItemsByCategory(int id){
		return dao.getItemsByCategory(id);
	}
	
	// 제품 id로 제품 정보 가져오기
	public ItemDTO getItem(int id) {
		return dao.getItem(id);
	}
}
