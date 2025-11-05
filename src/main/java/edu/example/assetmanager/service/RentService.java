package edu.example.assetmanager.service;

import java.util.Base64;
import java.util.Date;
import java.util.List;

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
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.RentListDTO;
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
            title += " 외 " + (items.size() - 1) + "건";
        }
        rentDTO.setTitle(title);
			
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
				}
			}
			return true;
		} else {
			return false;
		}
	}
	
	// userId로 RentList 찾기
	public List<RentListDTO> findRentListByUserId(int userId){
		return rentDAO.findRentListByUserId(userId);
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
	
	// approverId가 userId인 adminList 찾기
	public List<RentListDTO> adminList(int userId, String status){ 
		List<RentListDTO> adminRentList = rentDAO.findAdminListByUserId(userId, status);
		return adminRentList;
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
		return rentDAO.cancelRent(id);
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
		return rentDAO.insertAssetReturn(assetReturnDTO);
	}
	
	// returnList 찾기
	public List<AssetReturnDTO> assetReturn(){	
		List<AssetReturnDTO> adminReturnList = rentDAO.findAssetReturn();
		return adminReturnList ;
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
		if(updateAssetReturn(assetReturnDTO.getId(),assetReturnDTO.getUserId(), new Date())) {
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
}
