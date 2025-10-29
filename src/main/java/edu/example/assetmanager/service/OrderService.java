package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ApprovalDAO;
import edu.example.assetmanager.dao.OrderDAO;
import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.dao.UserDAO;
import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApproverInfoDTO;
import edu.example.assetmanager.domain.OrderContentDTO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.OrderDetailRESP;
import edu.example.assetmanager.domain.OrderFormDTO;
import edu.example.assetmanager.domain.OrderParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class OrderService {
	private final OrderDAO orderDAO;
	private final ApprovalDAO approvalDAO;
	private final UserDAO userDAO;
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

		PageResponseDTO<OrderDTO> response = new PageResponseDTO<>(list, page, totalCount, totalPages, hasPrev, hasNext,
				blockStart, blockEnd);
		return response;
	}

	public void save(OrderFormDTO orderFormDTO) {
		// 결재 정보 저장
		ApprovalDTO approvalDTO = new ApprovalDTO();
		approvalDTO.setApproverId(orderFormDTO.getApproverId());
		approvalDTO.setManagerId(orderFormDTO.getManagerId());
		approvalDAO.insertApproval(approvalDTO);
		orderFormDTO.setApprovalId(approvalDTO.getId());

		// 구매 정보 저장
		orderDAO.insertOrder(orderFormDTO);
		for (OrderContentDTO content : orderFormDTO.getProducts()) {
			content.setOrderId(orderFormDTO.getId());
			orderDAO.insertOrderContent(content);
		}
	}

	public OrderDetailRESP getOrderDetail(int id) {
		// 주문 정보
		OrderDTO orderDTO = orderDAO.getOrderById(id);
		List<OrderContentDTO> products = orderDAO.getContentsByOrderId(id);
		// 결재 및 결재자 정보
		ApprovalDTO approvalDTO = approvalDAO.getApprovalById(orderDTO.getApprovalId());
		UserInfoDTO userInfo = userDAO.getUserInfo(orderDTO.getUserId());
		UserInfoDTO approverInfo = userDAO.getUserInfo(approvalDTO.getApproverId());
		UserInfoDTO managerInfo = userDAO.getUserInfo(approvalDTO.getManagerId());
		ApproverInfoDTO approverInfoDTO = new ApproverInfoDTO(userInfo,approverInfo,managerInfo);
		
		System.out.println("서비스 내부 : approval id 와 이유 : " + approvalDTO.getId() + " 이유 : " + approvalDTO.getRejectReason());
		OrderDetailRESP response = new OrderDetailRESP(orderDTO, approvalDTO, products, approverInfoDTO);
		return response;
	}

}
