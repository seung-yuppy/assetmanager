package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.domain.RentShowDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
@Mapper
public interface RentDAO {
	// deptName로 userId 찾기
	public List<UserInfoDTO> findByAdminUser();
	
	// role로 userId 찾기
	public List<UserInfoDTO> findByManagerUser();
	
	// categoryId 값으로 제품 찾기  
	public List<AssetDTO> findByAsset(@Param("categoryId") int categoryId);
	
	// Rent 요청 
	public boolean insertRent(@Param("rentDTO") RentDTO rentDTO, @Param("userId") int userId);
	
	// rent-content 요청
	public boolean insertRentContent(@Param("rentContentDTO") RentContentDTO rentContentDTO);
	
	// rent 요청 수량(count) 가져오기
	public List<RentContentDTO> selectCount(@Param("assetName")String assetName, @Param("count") int count);
	
	// userId로 RentList 찾기
	public List<RentListDTO> findRentListByUserId(@Param("userId") int userId);
	
	// rentId로 rentApprovalId 가져오기 
	public RentDTO getRentApprovalId(Long id);
	
	// rentInfo 가져오기
	public RentShowDTO getRent(Long id);
	
	// rentId로 rentContent 가져오기
	public List<RentContentDTO> getRentContent(@Param("rentId") Long id);
	
	// userId와 approverId와 같은  admin 리스트 불러오기 
	public List<RentListDTO> findAdminListByUserId(@Param("userId") int userId, @Param("status") String status);
	
	// user_id로 부서 주소 찾기
	String getDeptAddressByUserId(@Param("userId") int userId);
	
}
