package edu.example.assetmanager.service;

import java.util.Base64;
import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ApprovalDAO;
import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.UserInfoDTO;

@Service
public class RentService {
	private final RentDAO rentDAO;
	private final ApprovalDAO approvalDAO;

	public RentService(RentDAO rentDAO, ApprovalDAO approvalDAO) {
		this.rentDAO = rentDAO;
		this.approvalDAO = approvalDAO;
		
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

	// approvalId, managerId를 insert하 ,rent insert 하기
	public boolean insertApproval(ApprovalDTO approvalDTO, RentDTO rentDTO, int userId, RentContentDTO rentContentDTO) {
		approvalDAO.insertApproval(approvalDTO);
		System.out.println("approvalDTO.getId() : " + approvalDTO.getId());
		rentDTO.setApprovalId(approvalDTO.getId());		 
		System.out.println(approvalDTO.getId());
		if (rentDAO.insertRent(rentDTO, userId)) { 
			String assetName = rentDTO.getAssetName();
			System.out.println(assetName);
			int count = rentDTO.getCount();
			System.out.println("rentDTO.getCount() 나오니??"+rentDTO.getCount());
			List<RentContentDTO> list = rentDAO.selectCount(assetName, count); 
			list.stream().map(s -> s.getAssetId()).forEach(item -> System.out.println("assetID : "+item));		
			for(RentContentDTO dto : list) {
				dto.setRentId(rentDTO.getId());
				rentDAO.insertRentContent(dto);
			}
			return true;
		} else {
			return false;
		}
	}
	

	
	

}
