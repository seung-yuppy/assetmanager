package edu.example.assetmanager.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetReturnDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.domain.RentParamDTO;
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
	
	// 페이징
	public int countAll(RentParamDTO rentParamDTO);
	public int countAllForAdmin(RentParamDTO rentParamDTO);
	public int countAllForManager(RentParamDTO rentParamDTO);
	public int countAssetReturn(RentParamDTO rentParamDTO);
	public int countAllForAdminDelay(RentParamDTO rentParamDTO);
	
	// RentList 찾기  
	public List<RentListDTO> findRentList(RentParamDTO rentParamDTO);
	
	// adminRentList 찾기 
	public List<RentListDTO> findAdminList(RentParamDTO rentParamDTO);
	
	// managerRentList 찾기 
	public List<RentListDTO> findManagerList(RentParamDTO rentParamDTO);
	
	// rentId로 rentApprovalId 가져오기 
	public RentDTO getRentApprovalId(Long id);
	
	// rentInfo 가져오기
	public RentShowDTO getRent(Long id);
	
	// rentId로 rentContent 가져오기
	public List<RentContentDTO> getRentContent(@Param("rentId") Long id);
	
	// user_id로 부서 주소 찾기
	public String getDeptAddressByUserId(@Param("userId") int userId);
	
	// rentId로 요청 취소
	public boolean cancelRent(int id);
	
	// rentDTO 가져오기 
	public RentDTO getRentIdWithUserId(@Param("userId")int userId, @Param("id") Long id);
	
	// 사용자 대시보드 - 반출 대기
	public int getPendingRent(@Param("userId") int userId);
	
	// 사용자 대시보드 - 반출 승인
	public int getApprovalRent(@Param("userId") int userId);
	
	// Asset_return 요청
	public boolean insertAssetReturn(AssetReturnDTO assetReturnDTO);
	
	// assetReturn 찾기
	public List<AssetReturnDTO> findAssetReturn(RentParamDTO rentParamDTO);
	
	// 반납 자산 찾기 
	public AssetReturnDTO findReturnAsset(int id);
	
	// Asset_return 확인
	public boolean updateAssetReturn(@Param("id")int id, @Param("approverId")int approverId, @Param("returnDate")Date returnDate);
	
	// 반납 완료 Asset 업데이트
	public boolean updateAsset(int assetId);
	
	// 사용자 대시보드 - 반출 요청 3개
	public List<RentListDTO> getRentTop3(@Param("userId") int userId);
	
	// approvalId로 Rent 찾기 
	public RentListDTO getRentByApprovalId(int approvalId);
	
	// delay 찾기
	public List<RentListDTO> findAdminDelayList(RentParamDTO rentParamDTO);
	
	// assetId로 Rent 찾기
	public RentShowDTO getRentInfoByAssetId(@Param("assetId") int assetId);
	
}
