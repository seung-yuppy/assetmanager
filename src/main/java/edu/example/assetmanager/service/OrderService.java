package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.OrderDAO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.OrderParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class OrderService {
	private final OrderDAO orderDAO ;
	private final int PAGE_SIZE = 10;
	private final int BLOCK_SIZE = 5;
	
	public PageResponseDTO<OrderDTO> listAll(OrderParamDTO orderParamDTO) {
		int page = orderParamDTO.getPage();
		int offset = page > 0 ? (page - 1) * PAGE_SIZE : 0;
		orderParamDTO.setOffset(offset);
		int totalCount = orderDAO.countAll(orderParamDTO);
		List<OrderDTO> list = orderDAO.listAll(orderParamDTO);
		int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
		int totalBlocks = (int) Math.ceil((double) totalPages / BLOCK_SIZE);
		int block = (int) Math.ceil((double) page / BLOCK_SIZE);
		if (totalBlocks < 0)
			totalBlocks = 0;
		int blockStart = (block - 1) * BLOCK_SIZE + 1;
		int blockEnd = block < totalBlocks ? block * BLOCK_SIZE : totalPages;
		boolean hasPrev = block > 1 ? true : false;
		boolean hasNext = totalBlocks > block ? true : false;
		
		PageResponseDTO<OrderDTO> response = new PageResponseDTO<>(list, page, totalCount, totalPages, hasPrev, hasNext, blockStart, blockEnd);
		return response;
	}
	
	
}
