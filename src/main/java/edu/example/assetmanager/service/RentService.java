package edu.example.assetmanager.service;

import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ApprovalDAO;
import edu.example.assetmanager.dao.AssetDAO;
import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.dao.UserDAO;
import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApproverInfoDTO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.AssetReturnDTO;
import edu.example.assetmanager.domain.NotificationDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.domain.RentParamDTO;
import edu.example.assetmanager.domain.RentShowDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import lombok.RequiredArgsConstructor;
@RequiredArgsConstructor
@Service
public class RentService {
	private final RentDAO rentDAO;
	private final ApprovalDAO approvalDAO;
	private final UserDAO userDAO;
	private final AssetDAO assetDAO;
	private final AssetService assetService;
	private final NotificationService notificationService;
	private final UserService userService;
	
	private PageResponseDTO<RentListDTO> paging(RentParamDTO rentParamDTO, int totalCount){
		final int PAGE_SIZE = 10;
		final int BLOCK_SIZE = 5;
		int page = rentParamDTO.getPage();
		int offset = page > 0 ? (page - 1) * PAGE_SIZE : 0;
		rentParamDTO.setOffset(offset);
		int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
		int totalBlocks = (int) Math.ceil((double) totalPages / BLOCK_SIZE);
		int block = (int) Math.ceil((double) page / BLOCK_SIZE);
		if (totalBlocks < 0)
			totalBlocks = 0;
		int blockStart = (block - 1) * BLOCK_SIZE + 1;
		int blockEnd = block < totalBlocks ? block * BLOCK_SIZE : totalPages;
		boolean hasPrev = block > 1 ? true : false;
		boolean hasNext = totalBlocks > block ? true : false;
		
		return new PageResponseDTO<RentListDTO>(page, totalCount, totalPages, hasPrev, hasNext, blockStart, blockEnd);
	}
	
	private PageResponseDTO<AssetReturnDTO> returnPaging(RentParamDTO rentParamDTO, int totalCount){
		final int PAGE_SIZE = 10;
		final int BLOCK_SIZE = 5;
		int page = rentParamDTO.getPage();
		int offset = page > 0 ? (page - 1) * PAGE_SIZE : 0;
		rentParamDTO.setOffset(offset);
		int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
		int totalBlocks = (int) Math.ceil((double) totalPages / BLOCK_SIZE);
		int block = (int) Math.ceil((double) page / BLOCK_SIZE);
		if (totalBlocks < 0)
			totalBlocks = 0;
		int blockStart = (block - 1) * BLOCK_SIZE + 1;
		int blockEnd = block < totalBlocks ? block * BLOCK_SIZE : totalPages;
		boolean hasPrev = block > 1 ? true : false;
		boolean hasNext = totalBlocks > block ? true : false;
		
		return new PageResponseDTO<AssetReturnDTO>(page, totalCount, totalPages, hasPrev, hasNext, blockStart, blockEnd);
	}

	// dept가 경영지원팀인 user 가지고 오기
	public List<UserInfoDTO> findByAdminUser() {
		List<UserInfoDTO> admin = rentDAO.findByAdminUser();

		// Base64 변환
		if (admin != null) {
			for (UserInfoDTO user : admin) {
				if (user.getProfileImage() != null) {
					String base64String = Base64.getEncoder().encodeToString(user.getProfileImage());
					user.setBase64ProfileImage(base64String);
				}
			}
		}
		return admin;
	}

	// role이 부장인 user 가지고 오기
	public List<UserInfoDTO> findByManagerUser() {
		List<UserInfoDTO> manager = rentDAO.findByManagerUser();

		// Base64 변환
		if (manager != null) {
			for (UserInfoDTO user : manager) {
				if (user.getProfileImage() != null) {
					String base64String = Base64.getEncoder().encodeToString(user.getProfileImage());
					user.setBase64ProfileImage(base64String);
				}
			}
		}
		return manager;
	}

	// categoryId로 자산 목록 조회
	public List<AssetDTO> findByAsset(int categoryId) {
		List<AssetDTO> asset = rentDAO.findByAsset(categoryId);

		return asset;
	}

	// approvalId, managerId를 insert하기 ,rent insert 하기
	@Transactional
	public boolean insertApproval(ApprovalDTO approvalDTO, RentDTO rentDTO, int userId) {
		// Approval 테이블 insert
		approvalDAO.insertApproval(approvalDTO);
		rentDTO.setApprovalId(approvalDTO.getId());
		
		// items 가지고 오기 
		List<RentContentDTO> items = rentDTO.getItems();
		if (rentDTO.getItems() == null || rentDTO.getItems().isEmpty()) {
			return false;
		}
		
		// items의 첫번째를 가지고 와서 title 만들기
		RentContentDTO itemName = items.get(0);
        String title = itemName.getAssetName(); 
    
        if (items.size() > 1) {
            title += " 등 " + (items.size()) + "개";
        }
        rentDTO.setTitle(title);
        rentDTO.setIsDelay(0);
			
		// rent 테이블 insert
		if (rentDAO.insertRent(rentDTO, userId)) {	
			
			
			// 제품 목록 가져오기
			for (RentContentDTO item : items) {
				String assetName = item.getAssetName();
				int count = item.getCount();

				// count해서 assetId 찾기
				List<RentContentDTO> list = rentDAO.selectCount(assetName, count);
				list.stream().map(s -> s.getAssetId()).forEach(assetId -> System.out.println("assetID : " + assetId));

				// assetId를 RentContent에 insert
				for (RentContentDTO dto : list) {
					dto.setRentId(rentDTO.getId());
					rentDAO.insertRentContent(dto);
					assetDAO.requestAsset(dto.getAssetId());
				}
			}
			insertRentNotification(approvalDTO, rentDTO, userId);
			return true;
		} else {
			return false;
		}
	}
	private boolean insertRentNotification(ApprovalDTO approvalDTO, RentDTO rentDTO, int userId) {
		String targetType = "rent";
		NotificationDTO notificationDTO = new NotificationDTO();
		notificationDTO.setTargetId(rentDTO.getId().intValue());
		notificationDTO.setTargetType(targetType);
		notificationDTO.setUserId(approvalDTO.getApproverId());
		UserInfoDTO user = userService.getUser(userId);
		String msg = String.format("새 반출 요청(%s %s) : %s", user.getUsername(), user.getPosition(), rentDTO.getTitle());
		notificationDTO.setMessage(msg);
		return notificationService.insert(notificationDTO);
	}
	
	// 사용자 RentList 찾기
	public PageResponseDTO<RentListDTO> findRentList(RentParamDTO rentParamDTO){
		int totalCount = rentDAO.countAll(rentParamDTO);
		PageResponseDTO<RentListDTO> response = paging(rentParamDTO, totalCount);
		List<RentListDTO> list = rentDAO.findRentList(rentParamDTO);
		response.setContent(list);
		return response;
	}
	
	// adminRentList 찾기
	public PageResponseDTO<RentListDTO> adminList(RentParamDTO rentParamDTO){ 
		int totalCount = rentDAO.countAllForAdmin(rentParamDTO);
		PageResponseDTO<RentListDTO> response = paging(rentParamDTO, totalCount);
		List<RentListDTO> list = rentDAO.findAdminList(rentParamDTO);
		response.setContent(list);
		return response;
	}
	
	// adminDelayList 찾기
		public PageResponseDTO<RentListDTO> adminDelayList(RentParamDTO rentParamDTO){ 
			int totalCount = rentDAO.countAllForAdminDelay(rentParamDTO);
			PageResponseDTO<RentListDTO> response = paging(rentParamDTO, totalCount);
			List<RentListDTO> list = rentDAO.findAdminDelayList(rentParamDTO);
			response.setContent(list);
			return response;
		}
	
	// managerRentList 찾기
	public PageResponseDTO<RentListDTO> managerList(RentParamDTO rentParamDTO){ 
		int totalCount = rentDAO.countAllForManager(rentParamDTO);
		PageResponseDTO<RentListDTO> response = paging(rentParamDTO, totalCount);
		List<RentListDTO> list = rentDAO.findManagerList(rentParamDTO);
		response.setContent(list);
		return response;
	}
	
	// managerDelayList 찾기
	public PageResponseDTO<RentListDTO> managerDelayList(RentParamDTO rentParamDTO){ 
		int totalCount = rentDAO.countAllForManagerDelay(rentParamDTO);
		PageResponseDTO<RentListDTO> response = paging(rentParamDTO, totalCount);
		List<RentListDTO> list = rentDAO.findManagerDelayList(rentParamDTO);
		response.setContent(list);
		return response;
	}
	
	// rentId로 detail 결재 정보 불러오기 
	public ApproverInfoDTO getRentApprovalDetail(Long id) {
		// rentId 로 rentApprovalId 가져오기 
		RentDTO rentDTO = rentDAO.getRentApprovalId(id);
		// approverId로 approval 가져오기 
		ApprovalDTO approvalDTO = approvalDAO.getApprovalById(rentDTO.getApprovalId().intValue());	
		UserInfoDTO adminInfoDTO = userDAO.getUserInfo(approvalDTO.getApproverId());
		UserInfoDTO managerInfoDTO = userDAO.getUserInfo(approvalDTO.getManagerId());
		UserInfoDTO userInfoDTO = userDAO.getUserInfo(rentDTO.getUserId());
		
		ApproverInfoDTO approverInfoDTO = new ApproverInfoDTO(userInfoDTO,adminInfoDTO,managerInfoDTO);
		System.out.println("approverInfoDTO 뭐뭐 있음?? " + approverInfoDTO);
 
		return approverInfoDTO;
	}
	
	// rent 정보 가져오기
	public RentShowDTO getRentDetail(Long id) {
		RentShowDTO rentDTO = rentDAO.getRent(id);

		return rentDTO;
	}
	
	// rentContent 찾기 
	public List<RentContentDTO> getRentContentDetail(Long id){
		List<RentContentDTO> rentContentDTO = rentDAO.getRentContent(id);
		
		for (RentContentDTO rent : rentContentDTO) {
			int userCount= assetDAO.findUserIdByAsset(rent.getAssetId());
			if (userCount == 0) {
				rent.setRegister(true);
			} else {
				rent.setRegister(false);
			}
		}
		
		return rentContentDTO;
	}
	
	// rentId로 ApprovalDTO 정보 가져오기
	public ApprovalDTO getApprovalByRentId(Long rentId) {
        RentDTO rentDTO = rentDAO.getRentApprovalId(rentId);
        if (rentDTO != null && rentDTO.getApprovalId() != null) {
            
            return approvalDAO.getApprovalById(rentDTO.getApprovalId().intValue());
        }
        return null;
    }
	
	// rentDTO 가져오기
	public RentDTO getRentDTO(int userId, Long id) {
		return rentDAO.getRentIdWithUserId(userId, id);
	}
	
	// rentId로 요청 취소
	public boolean cancelRent(int id) {
		if (rentDAO.cancelRent(id)) {
			if (rentDAO.cancelApproval(id))
				return true;
			else 
				return false;
		} else {
			return false;
		}
	}
	
	// 사용자 대시보드 - 반출 대기 개수
	public int countPendingRent(int userId) {
		return rentDAO.getPendingRent(userId);
	}
	
	// 사용자 대시보드 - 반출 승인 개수
	public int countingApprovalRent(int userId) {
		return rentDAO.getApprovalRent(userId);
	}
	
	// return 요청
	public boolean assetReturn(AssetReturnDTO assetReturnDTO) {
		boolean isInserted = rentDAO.insertAssetReturn(assetReturnDTO);
		if (isInserted)
			insertReturnNotification(assetReturnDTO);
		return isInserted;
	}
	
	private void insertReturnNotification(AssetReturnDTO assetReturnDTO) {
		String targetType = "return";
		UserInfoDTO user = userService.getUser(assetReturnDTO.getUserId());
		String msg = String.format("새 반납 요청(%s %s)", user.getUsername(), user.getPosition());
		List<UserInfoDTO> admins = userService.getUsersByRole("admin");
		for(int i = 0; i < admins.size(); i++) {
			NotificationDTO notificationDTO = new NotificationDTO(targetType, assetReturnDTO.getId(), msg);
			notificationDTO.setUserId(admins.get(i).getId());
			notificationService.insert(notificationDTO);
		}
	}
	
	// returnList 찾기
	public PageResponseDTO<AssetReturnDTO> assetReturn(RentParamDTO rentParamDTO){	
		int totalCount = rentDAO.countAssetReturn(rentParamDTO);
		PageResponseDTO<AssetReturnDTO> response = returnPaging(rentParamDTO, totalCount);
		List<AssetReturnDTO> list = rentDAO.findAssetReturn(rentParamDTO);
		response.setContent(list);
		return response;
	}
	
	// returnAsset 정보 찾기
	public AssetReturnDTO getReturnAsset(int id) { 
		AssetReturnDTO assetReturnDTO = rentDAO.findReturnAsset(id);
		return assetReturnDTO;
	}
	
	// 반납 테이블 업데이트
	public boolean updateAssetReturn(int id, int approverId, Date returnDate) {
		return rentDAO.updateAssetReturn(id,approverId, returnDate);
	}
	
	// (반납)자산 테이블 업데이트
	public boolean updateAsset(int assetId) {
		return rentDAO.updateAsset(assetId);
	}
	
	public boolean adminReturnConfirm(AssetReturnDTO assetReturnDTO) {
		if(updateAssetReturn(assetReturnDTO.getId(),assetReturnDTO.getApproverId(), new Date())) {
			if(updateAsset(assetReturnDTO.getAssetId())) {
				AssetHistoryDTO historyDTO = new AssetHistoryDTO();
				historyDTO.setAssetId(assetReturnDTO.getAssetId());
				historyDTO.setUserId(assetReturnDTO.getUserId());
				if (assetService.insertAssetHistory(historyDTO, "return")) {
					return true;
				} else {
					return false;
				}				
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	// 사용자 대시보드 - 반출 최신순 3개
	public List<RentListDTO> getRentTop3(int userId) {
		return rentDAO.getRentTop3(userId);
	}
	
	public RentListDTO getRentByApprovalId(int approvalId) {
		return rentDAO.getRentByApprovalId(approvalId);
	}
	
	@Transactional
	public boolean insertDelayForm(ApprovalDTO approvalDTO, RentDTO rentDTO, RentContentDTO rentContentDTO, int userId) {
		if(approvalDAO.insertApproval(approvalDTO)) {
			rentDTO.setApprovalId(approvalDTO.getId());
			String title = rentContentDTO.getAssetName(); 
			rentDTO.setTitle(title);	
			rentDTO.setIsDelay(1);
			if(rentDAO.insertRent(rentDTO, userId)) {
				rentContentDTO.setRentId(rentDTO.getId());
				if(rentDAO.insertRentContent(rentContentDTO)) {
					if(!insertDelayNotification(approvalDTO, rentDTO, userId)) {
						System.out.println("관리자에게 연장 알림  추가 실패");
					}
					return true;
				}else {
					return false;
				}
			}else {
				return false;
			}
		}else {
			return false;
		}
	}
	
	private boolean insertDelayNotification(ApprovalDTO approvalDTO, RentDTO rentDTO, int userId) {
		String targetType = "delay";
		NotificationDTO notificationDTO = new NotificationDTO();
		notificationDTO.setTargetId(rentDTO.getId().intValue());
		notificationDTO.setTargetType(targetType);
		notificationDTO.setUserId(approvalDTO.getApproverId());
		UserInfoDTO user = userService.getUser(userId);
		String msg = String.format("새 연장 요청(%s %s) : %s", user.getUsername(), user.getPosition(), rentDTO.getTitle());
		notificationDTO.setMessage(msg);
		return notificationService.insert(notificationDTO);
	}
	
	@Transactional
	public boolean updateRentForm(ApprovalDTO approvalDTO, RentDTO rentDTO, int userId) {
		List<RentContentDTO> assets = rentDAO.getRentContent(rentDTO.getId());
		for (RentContentDTO asset : assets)
			rentDAO.updateAssetRequest(asset.getAssetId());
		
		if (rentDAO.deleteRentContentByRentId(rentDTO.getId())) {	
			// items 가지고 오기 
			List<RentContentDTO> items = rentDTO.getItems();
			if (rentDTO.getItems() == null || rentDTO.getItems().isEmpty()) 
				return false;
			
			// items의 첫번째를 가지고 와서 title 만들기
			RentContentDTO itemName = items.get(0);
	        String title = itemName.getAssetName(); 
	    
	        if (items.size() > 1) {
	            title += " 등 " + (items.size()) + "개";
	        }
	        rentDTO.setTitle(title);
	        
			if (rentDAO.updateRent(rentDTO) ) {
				
				approvalDTO.setId(rentDTO.getApprovalId());
				if (rentDAO.updateApproval(approvalDTO)) {
					// 제품 목록 가져오기
					for (RentContentDTO item : items) {
						String assetName = item.getAssetName();
						int count = item.getCount();

						// count해서 assetId 찾기
						List<RentContentDTO> list = rentDAO.selectCount(assetName, count);		

						// assetId를 RentContent에 insert
						for (RentContentDTO dto : list) {
							dto.setRentId(rentDTO.getId());
							rentDAO.insertRentContent(dto);
							assetDAO.requestAsset(dto.getAssetId());
						}
					}
					insertRentNotification(approvalDTO, rentDTO, userId);
					return true;
				}
			}
		}
		return false;
	}
}
