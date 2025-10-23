package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.AssetDAO;
import edu.example.assetmanager.domain.AssetDTO;

@Service
public class AssetService {

	@Autowired
	AssetDAO dao;
	
	// 페이징 처리된 목록을 가져오는 메서드
	public List<AssetDTO> getPagedList(int page) {
		int pageSize = 10;
		int start = (page - 1) * pageSize + 1;
		int end = start + pageSize - 1;
		List<AssetDTO> list = dao.listAll(start, end);
		return list;
	}
	
	// 총 페이지 수를 계산하는 메서드
	public int getTotalPages() {
		int pageSize = 10;
		int totalItems = dao.countAll();
		return (int)Math.ceil((double) totalItems / pageSize);
	}
}
