package edu.example.assetmanager.service;

import java.util.Base64;
import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.UserInfoDTO;

@Service
public class RentService {
	private final RentDAO rentDAO;

	public RentService(RentDAO rentDAO) {
		this.rentDAO = rentDAO;
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
	public List<AssetDTO> findByAsset(int categoryId){
		List<AssetDTO> asset = rentDAO.findByAsset(categoryId);

		return asset;
	}	
}
