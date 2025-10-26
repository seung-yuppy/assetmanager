package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetDisposalDTO;

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
	
}
