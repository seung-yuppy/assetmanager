package edu.example.assetmanager.service;

import java.util.Base64;
import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ApprovalDAO;
import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.dao.UserDAO;
import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApproverInfoDTO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.domain.RentShowDTO;
import edu.example.assetmanager.domain.UserInfoDTO;

@Service
public class RentService {
	private final RentDAO rentDAO;
	private final ApprovalDAO approvalDAO;
	private final UserDAO userDAO;

	public RentService(RentDAO rentDAO, ApprovalDAO approvalDAO, UserDAO userDAO) {
		this.rentDAO = rentDAO;
		this.approvalDAO = approvalDAO;
		this.userDAO = userDAO;

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
	public boolean insertApproval(ApprovalDTO approvalDTO, RentDTO rentDTO, int userId) {
		// Approval 테이블 insert
		approvalDAO.insertApproval(approvalDTO);
		System.out.println("approvalDTO.getId() : " + approvalDTO.getId());
		rentDTO.setApprovalId(approvalDTO.getId());
		System.out.println(approvalDTO.getId());
		
		// items 가지고 오기 
		List<RentContentDTO> items = rentDTO.getItems();
		if (rentDTO.getItems() == null || rentDTO.getItems().isEmpty()) {
			return false;
		}
		
		// items의 첫번째를 가지고 와서 title 만들기
		RentContentDTO itemName = items.get(0);
		System.out.println("############## itemname : "+itemName);
        String title = itemName.getAssetName(); 
        System.out.println("첫번째 itemName 잘 나오니??? "+title);
    
        if (items.size() > 1) {
            title += " 외 " + (items.size() - 1) + "건";
        }
        rentDTO.setTitle(title);
				
        System.out.println("title까지 나와?" + title + " " + rentDTO.getTitle());
        System.out.println("title까지 나와?" + userId);
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
		System.out.println("rentDTO 나오니??? "+rentDTO);
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
		for(RentContentDTO dto : rentContentDTO) {
			System.out.println("카테고리는 ???" + dto.getCategoryName());
		}
		return rentContentDTO;
	}
}
