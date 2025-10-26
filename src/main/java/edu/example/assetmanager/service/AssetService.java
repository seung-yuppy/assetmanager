package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.example.assetmanager.dao.AssetDAO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetDisposalDTO;

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
	
	// 자산 상세 가져오기
	public AssetDTO getAsset(int id) {
		AssetDTO dto = dao.assetDetail(id);
		return dto;
	}
	
	// 자산 상세 수정하기 
	public boolean changeAsset(AssetDTO dto) {
		if (dao.modifyAsset(dto))
			return true;
		else 
			return false;
	}
	
	// 자산 불용 처리하기
	@Transactional
	public boolean deleteAsset(AssetDisposalDTO dto) {
		if (dao.deleteAsset(dto)) {
			if (dao.deleteAssetDisposal(dto)) 
				return true;
			else 
				return false;
		} else {
			return false;			
		}
	}
	
	// 불용 자산 목록
	public List<AssetDisposalDTO> getPagedDisposalList(int page) {
		int pageSize = 10;
		int start = (page - 1) * pageSize + 1;
		int end = start + pageSize - 1;
		List<AssetDisposalDTO> list = dao.listDisposal(start, end);
		return list;
	}
	
	// 불용 자산 총 페이지 수를 계산하는 메서드
	public int getDisposalTotalPages() {
		int pageSize = 10;
		int totalItems = dao.countDisposal();
		return (int)Math.ceil((double) totalItems / pageSize);
	}
}
