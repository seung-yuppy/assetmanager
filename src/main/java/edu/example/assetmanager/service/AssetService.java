package edu.example.assetmanager.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.example.assetmanager.dao.AssetDAO;
import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetDisposalDTO;
import edu.example.assetmanager.domain.AssetDisposalParamDTO;
import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.AssetHistoryUserDTO;
import edu.example.assetmanager.domain.AssetHistoryUserShowDTO;
import edu.example.assetmanager.domain.AssetUsingParamDTO;
import edu.example.assetmanager.domain.AssetParamDTO;
import edu.example.assetmanager.domain.PageParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AssetService {

	private final AssetDAO dao;
	private final RentDAO rentDAO;
	
	// 페이징 처리를 위한 공통 메서드
	private <T, P extends PageParamDTO> PageResponseDTO<T> paging(P dto, int totalCount) {
		final int PAGE_SIZE = 10;
		final int BLOCK_SIZE = 5;
		int page = dto.getPage();
		int offset = page > 0 ? (page - 1) * PAGE_SIZE : 0;
		dto.setOffset(offset);
		int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
		int totalBlocks = (int) Math.ceil((double) totalPages / BLOCK_SIZE);
		int block = (int) Math.ceil((double) page / BLOCK_SIZE);
		if (totalBlocks < 0)
			totalBlocks = 0;
		int blockStart = (block - 1) * BLOCK_SIZE + 1;
		int blockEnd = block < totalBlocks ? block * BLOCK_SIZE : totalPages;
		boolean hasPrev = block > 1 ? true : false;
		boolean hasNext = totalBlocks > block ? true : false;
		return new PageResponseDTO<T>(page, totalCount, totalPages, hasPrev, hasNext, blockStart, blockEnd);
	}
	
	// (사용&대기중) 자산 목록
	public PageResponseDTO<AssetDTO> listAll(AssetParamDTO dto) {
		int totalCount = dao.countAll(dto);
		PageResponseDTO<AssetDTO> response = paging(dto, totalCount);
		List<AssetDTO> list = dao.listAll(dto);
		response.setContent(list);
		return response;
	}
	
	// 불용 자산 목록
	public PageResponseDTO<AssetDisposalDTO> listDisposalAll(AssetDisposalParamDTO dto) {
		int totalCount = dao.countDisposal(dto);
		PageResponseDTO<AssetDisposalDTO> response = paging(dto, totalCount);
		List<AssetDisposalDTO> list = dao.listDisposal(dto);
		response.setContent(list);
		return response;
	}
	
	// 내가 사용중 자산 목록
	public PageResponseDTO<AssetHistoryDTO> listMyUsingAll(AssetUsingParamDTO dto, int userId) {
		int totalCount = dao.countMyUsing(dto);
		PageResponseDTO<AssetHistoryDTO> response = paging(dto, totalCount);
		List<AssetHistoryDTO> list = dao.listMyUsing(dto);
		for (AssetHistoryDTO asset : list) {
			if (dao.isReturnBtnClick(userId, asset.getAssetId()) != 0)
				asset.setActiveBtn(true);
			else
				asset.setActiveBtn(false);
		}
		response.setContent(list);
		return response;
	}
	
	// 내 부서가 사용중 자산 목록
	public PageResponseDTO<AssetHistoryDTO> listMyDeptAll(AssetUsingParamDTO dto) {
		int totalCount = dao.countMyDept(dto);
		PageResponseDTO<AssetHistoryDTO> response = paging(dto, totalCount);
		List<AssetHistoryDTO> list = dao.listMyDept(dto);
		response.setContent(list);
		return response;
	}

	// 자산 상세 가져오기
	public AssetDTO getAsset(int id) {
		return dao.assetDetail(id);
	}
	
	// 자산 상세 수정하기 
	public boolean changeAsset(AssetDTO dto) {
		if (dao.modifyAsset(dto))
			return true;
		else 
			return false;
	}
	
	// 자산 불용 처리하기
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
	
	// 관리자 대시보드 - 총 자산 수
	public int getTotalAsset() {
		return dao.totalAsset();
	}
	
	// 관리자 대시보드 - 사용중 자산 수
	public int getUsingAsset() {
		return dao.usingAsset();
	}
	
	// 관리자 대시보드 - 대기중 자산 수 
	public int getPendingAsset() {
		return dao.pendingAsset();
	}
	
	// 관리자 대시보드 - 불용중 자산 수
	public int getInvalidAsset() {
		return dao.invalidAsset();
	}
	
	// 관리자 사용자 상세 페이지에서 자산 내역
	public List<AssetHistoryUserShowDTO> getUserAssetHistory(int userId) {
		List<AssetHistoryUserDTO> list = dao.getUserAssetHistory(userId);
		List<AssetHistoryUserShowDTO> showList = new ArrayList<>();

		for (int i = 0; i < list.size(); i++) {
			AssetHistoryUserDTO current = list.get(i);
			
			if (current.getStatus().equalsIgnoreCase("rent")) {
				AssetHistoryUserShowDTO showDTO = new AssetHistoryUserShowDTO();
				showDTO.setAssetId(current.getAssetId());
				showDTO.setAssetName(current.getAssetName());
				showDTO.setCategoryName(current.getCategoryName());
				showDTO.setSerialNumber(current.getSerialNumber());
				showDTO.setRentDate(current.getCreateDate());
				if ((i + 1 < list.size()) && 
						(list.get(i + 1).getAssetId() == current.getAssetId()) && 
						(list.get(i + 1).getStatus().equalsIgnoreCase("return"))) {
					showDTO.setReturnDate(list.get(i + 1).getCreateDate());
					i++;
				} else {
					showDTO.setReturnDate(null);
				}
				showList.add(showDTO);
			}
		}
		
		return showList;
	}
	
	// 관리자 자산 상세 페이지에서 자산 내역
	public List<AssetHistoryUserShowDTO> getAssetAssetHistory(int assetId) {
		List<AssetHistoryUserDTO> list = dao.getAssetAssetHistory(assetId);
		List<AssetHistoryUserShowDTO> showList = new ArrayList<>();

		for (int i = 0; i < list.size(); i++) {
			AssetHistoryUserDTO current = list.get(i);
			
			if (current.getStatus().equalsIgnoreCase("rent")) {
				AssetHistoryUserShowDTO showDTO = new AssetHistoryUserShowDTO();
				showDTO.setAssetId(current.getAssetId());
				showDTO.setAssetName(current.getAssetName());
				showDTO.setCategoryName(current.getCategoryName());
				showDTO.setSerialNumber(current.getSerialNumber());
				showDTO.setRentDate(current.getCreateDate());
				showDTO.setUsername(current.getUsername());
				showDTO.setEmpNo(current.getEmpNo());
				showDTO.setDeptName(current.getDeptName());
				switch(current.getRole()) {
					case "manager": showDTO.setRole("부장"); break;
					case "employee": showDTO.setRole("사원");	 break;
				}
				if ((i + 1 < list.size()) && 
						(list.get(i + 1).getAssetId() == current.getAssetId()) && 
						(list.get(i + 1).getStatus().equalsIgnoreCase("return"))) {
					showDTO.setReturnDate(list.get(i + 1).getCreateDate());
					i++;
				} else {
					showDTO.setReturnDate(null);
				}
				showList.add(showDTO);
			}
		}
		
		return showList;
	}
	// 반출 자산의 등록
	@Transactional 
    public boolean registerAssetItem(AssetHistoryDTO historyDTO) {
        int userId = historyDTO.getUserId();
        String serialNumber = historyDTO.getSerialNumber();

        // 부서 주소 찾기
        String deptAddress = rentDAO.getDeptAddressByUserId(userId);
        if(deptAddress==null) {
        	return false;
        }    

        int assetId = historyDTO.getAssetId();
        
        if(dao.updateAsset(userId, serialNumber, deptAddress, assetId)) {
        	historyDTO.setStatus("rent");
        	return insertAssetHistory(historyDTO, "rent");
        } else {
        	return false;
        }
    }
	
	// 자산내역 추가
	public boolean insertAssetHistory(AssetHistoryDTO historyDTO , String status) {
    	historyDTO.setStatus(status);
    	return dao.insertAssetHistory(historyDTO);
	}
	
	// 자산 추가
	public boolean insertAsset(AssetDTO assetDTO) {
		return dao.insertAsset(assetDTO);
	}

}
