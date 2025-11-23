package edu.example.assetmanager.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.example.assetmanager.dao.ApprovalDAO;
import edu.example.assetmanager.dao.OrderDAO;
import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApproverInfoDTO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.NotificationDTO;
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
	private final UserService userService;
	private final AssetService assetService;
	private final NotificationService notificationService;
	
	public OrderDTO getOrderById(int id) {
		return orderDAO.getOrderById(id);
	}
	
	public OrderDTO getOrderByApprovalId(int id) {
		return orderDAO.getOrderByApprovalId(id);
	}

	public PageResponseDTO<OrderDTO> listAll(OrderParamDTO orderParamDTO) {
		int totalCount = orderDAO.countAll(orderParamDTO);
		PageResponseDTO<OrderDTO> response = paging(orderParamDTO, totalCount); 
		List<OrderDTO> list = orderDAO.listAll(orderParamDTO);
		response.setContent(list);
		return response;
	}
	
	public PageResponseDTO<OrderDTO> listAllForAdmin(OrderParamDTO orderParamDTO) {
		int totalCount = orderDAO.countAllForAdmin(orderParamDTO);
		PageResponseDTO<OrderDTO> response = paging(orderParamDTO, totalCount); 
		List<OrderDTO> list = orderDAO.listAllForAdmin(orderParamDTO);
		response.setContent(list);
		return response;
	}
	
	public PageResponseDTO<OrderDTO> listAllForManager(OrderParamDTO orderParamDTO) {
		int totalCount = orderDAO.countAllForManager(orderParamDTO);
		PageResponseDTO<OrderDTO> response = paging(orderParamDTO, totalCount); 
		List<OrderDTO> list = orderDAO.listAllForManager(orderParamDTO);
		response.setContent(list);
		return response;
	}
	
	private PageResponseDTO<OrderDTO> paging(OrderParamDTO orderParamDTO, int totalCount){
		final int PAGE_SIZE = 10;
		final int BLOCK_SIZE = 5;
		int page = orderParamDTO.getPage();
		int offset = page > 0 ? (page - 1) * PAGE_SIZE : 0;
		orderParamDTO.setOffset(offset);
		int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
		int totalBlocks = (int) Math.ceil((double) totalPages / BLOCK_SIZE);
		int block = (int) Math.ceil((double) page / BLOCK_SIZE);
		if (totalBlocks < 0)
			totalBlocks = 0;
		int blockStart = (block - 1) * BLOCK_SIZE + 1;
		int blockEnd = block < totalBlocks ? block * BLOCK_SIZE : totalPages;
		boolean hasPrev = block > 1 ? true : false;
		boolean hasNext = totalBlocks > block ? true : false;
		
		return new PageResponseDTO<OrderDTO>(page, totalCount, totalPages, hasPrev, hasNext, blockStart, blockEnd);
	}
	
	@Transactional
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
		// 알림 생성
		insertNotification(orderFormDTO);
	}
	
	private boolean insertNotification(OrderFormDTO orderFormDTO) {
		String targetType = "order";
		NotificationDTO notificationDTO = new NotificationDTO();
		notificationDTO.setTargetId(orderFormDTO.getId().intValue());
		notificationDTO.setTargetType(targetType);
		notificationDTO.setUserId(orderFormDTO.getApproverId());
		System.out.println("새 요청시 admin 아이디 : " + orderFormDTO.getApproverId());
		String msg = String.format("새 구매 요청(%s %s) : %s", orderFormDTO.getUsername(), orderFormDTO.getPosition(), orderFormDTO.getTitle());
		notificationDTO.setMessage(msg);
		return notificationService.insert(notificationDTO);
	}
	
	public OrderDetailRESP getOrderDetail(int id) {
		// 주문 정보
		OrderDTO orderDTO = getOrderById(id);
		List<OrderContentDTO> products = orderDAO.getContentsByOrderId(id);
		// 결재 및 결재자 정보
		ApprovalDTO approvalDTO = approvalDAO.getApprovalById(orderDTO.getApprovalId());
		UserInfoDTO userInfo = userService.getUser(orderDTO.getUserId());
		UserInfoDTO approverInfo = userService.getUser(approvalDTO.getApproverId());
		UserInfoDTO managerInfo = userService.getUser(approvalDTO.getManagerId());
		ApproverInfoDTO approverInfoDTO = new ApproverInfoDTO(userInfo,approverInfo,managerInfo);
		OrderDetailRESP response = new OrderDetailRESP(orderDTO, approvalDTO, products, approverInfoDTO);
		return response;
	}
	
	// 구매 자산 등록
	@Transactional
	public boolean registerAsset(AssetDTO assetDTO, int orderContentId) {
		boolean isAssetInserted =  assetService.insertAsset(assetDTO);
		boolean isContentUpdated = updateContentRegisterCount(orderContentId);
		
		AssetHistoryDTO assetHistoryDTO = new AssetHistoryDTO();
		assetHistoryDTO.setAssetId(assetDTO.getId());
		assetHistoryDTO.setUserId(assetDTO.getUserId());
		boolean isHistoryUpdated =  assetService.insertAssetHistory(assetHistoryDTO, "rent");
		
		return isAssetInserted && isContentUpdated && isHistoryUpdated;
	}
	
	public boolean updateContentRegisterCount(int id) {
		return orderDAO.updateContentRegisterCount(id);
	}
	
	// 구매 요청 취소
	@Transactional
	public boolean cancelOrder(int id) {
		return orderDAO.cancelOrder(id);
	}
	
	// 사용자 대시보드 - 구매 대기 개수
	public int countPendingOrder(int userId) {
		return orderDAO.getPendingOrder(userId);
	}
	
	// 사용자 대시보드 - 구매 승인 개수
	public int countApprovalOrder(int userId) {
		return orderDAO.getApprovalOrder(userId);
	}

	public List<OrderDTO> getOrderTop3(int userId) {
		return orderDAO.getOrderTop3(userId);
	}
	
	@Transactional
	public void updateOrder(OrderFormDTO orderFormDTO) {
		// 결재 정보 수정
		ApprovalDTO approvalDTO = approvalDAO.getApprovalById(orderFormDTO.getApprovalId().intValue());
		approvalDAO.updateApproval(approvalDTO);
		// 기존 주문 물품 삭제
		orderDAO.deleteOrderContentsByOrderId(orderFormDTO.getId().intValue());
		
		// 새 구매 정보 저장
		orderDAO.insertOrder(orderFormDTO);
		for (OrderContentDTO content : orderFormDTO.getProducts()) {
			content.setOrderId(orderFormDTO.getId());
			orderDAO.insertOrderContent(content);
		}
		// 알림 생성
		insertNotification(orderFormDTO);
	}
}
