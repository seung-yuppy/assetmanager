package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
@Mapper
public interface RentDAO {
	// deptName로 userId 찾기
	public List<UserInfoDTO> findByAdminUser();
	
	// role로 userId 찾기
	public List<UserInfoDTO> findByManagerUser();
	
	// categoryId 값으로 제품 찾기  
	public List<AssetDTO> findByAsset(@Param("categoryId") int categoryId);
	
	// Approval 요청
	public boolean insertApproval(ApprovalDTO approvalDTO);
	
	// Rent 요청 
	public boolean rentRequest(@Param("rentDTO") RentDTO rentDTO, @Param("userId") int userId);
	
	// rent-content 요청
	public boolean insertRentContent();
	

		


}
