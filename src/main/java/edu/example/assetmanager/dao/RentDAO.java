package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.UserDTO;
@Mapper
public interface RentDAO {
	// deptName로 userId 찾기
	public List<UserDTO> findByAdminUser();
	
	// role로 userId 찾기
	public List<UserDTO> findByManagerUser();
	
	// categoryId 값으로 제품 찾기  
	public List<AssetDTO> findByAsset(@Param("categoryId") int categoryId);
	
	// Approval 요청
	public boolean insertApproval();
	
	// Rent 요청 
	public boolean rentRequest(RentDTO rentDTO);
	
	// rent-content 요청
	public boolean insertRentContent();
	

		


}
