package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.AssetDTO;

@Mapper
public interface AssetDAO {

	// 페이징을 위한 모든 자산 개수
	public int countAll();
	
	// 자산 모든 리스트
	public List<AssetDTO> listAll(@Param("start") int start, @Param("end") int end);
	
	// 자산 상세
	public AssetDTO assetDetail(@Param("id") int id);
	
	// 자산 수정
	public boolean modifyAsset(@Param("asset") AssetDTO dto);
}
