package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetDisposalDTO;
import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.AssetHistoryUserDTO;

@Mapper
public interface AssetDAO {

	// 페이징을 위한 모든 자산 개수(불용 제외)
	public int countAll();
	
	// 자산 모든 리스트(불용 제외)
	public List<AssetDTO> listAll(@Param("start") int start, @Param("end") int end);
	
	// 자산 상세
	public AssetDTO assetDetail(@Param("id") int id);
	
	// 자산 수정
	public boolean modifyAsset(@Param("asset") AssetDTO dto);
	
	// 자산 불용처리1(Asset 테이블 - is_valid update)
	public boolean deleteAsset(@Param("asset") AssetDisposalDTO dto);
	
	// 자산 불용처리2(Asset_Disposal 테이블 - insert)
	public boolean deleteAssetDisposal(@Param("asset") AssetDisposalDTO dto);
	
	// 페이징을 위한 모든 불용 자산 개수
	public int countDisposal();
	
	// 자산 불용 리스트
	public List<AssetDisposalDTO> listDisposal(@Param("start") int start, @Param("end") int end);
	
	// 사용자 내 자산 개수
	public int countMyAsset(@Param("userId") int userId);
	
	// 사용자 내 부서 자산 개수
	public int countMyDeptAsset(@Param("userId") int userId);
	
	// 사용자 내 자산 확인
	public List<AssetHistoryDTO> listHistory(@Param("start") int start, @Param("end") int end, @Param("userId") int userId);
	
	// 관리자 대시보드
	// 총 자산 개수
	public int totalAsset();
	
	// 사용 중인 자산 개수
	public int usingAsset();
	
	// 대기 중인 자산 개수
	public int pendingAsset();
	
	// 불용 중인 자산 개수
	public int invalidAsset();
	
	// 관리자 사용자 상세 페이지에서 자산 내역
	public List<AssetHistoryUserDTO> getUserAssetHistory(int userId);
	
	// 관리자 자산 상세 페이지에서 자산 내역
	public List<AssetHistoryUserDTO> getAssetAssetHistory(int assetId);
	
	// 사용자 내 사용 중인 자산 확인
	public List<AssetHistoryDTO> myUsingAsset(@Param("userId") int userId);
	
	// 사용자 내 부서 자산 확인
	public List<AssetHistoryDTO> myDeptAsset(@Param("userId") int userId);

}
