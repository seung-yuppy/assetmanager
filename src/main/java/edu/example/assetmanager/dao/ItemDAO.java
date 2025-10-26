package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.ItemDTO;

@Mapper
public interface ItemDAO {

	// 페이징을 위한 모든 제품 개수
	public int countAll();
	
	// 목록 모든 리스트
	public List<ItemDTO> listAll(@Param("start") int start, @Param("end") int end);
	
	// 제품 추가
	public boolean addItem(@Param("item") ItemDTO dto);
	
	// 제품 삭제
	public boolean removeItem(@Param("id") int id);
	
	public List<ItemDTO> getItemsByCategory(int id);
}
