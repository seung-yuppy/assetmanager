package edu.example.assetmanager.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.example.assetmanager.dao.AssetDAO;
import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetDisposalDTO;
import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.AssetHistoryUserDTO;
import edu.example.assetmanager.domain.AssetHistoryUserShowDTO;

@Service
public class AssetService {

	@Autowired
	AssetDAO dao;

	private final RentDAO rentDAO;
	
	public AssetService(RentDAO rentDAO) {
		this.rentDAO = rentDAO;
	}
	
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
	
	// 사용 중인 내 자산 수 
	public int totalUsingAssets(int userId) {
		return dao.countMyAsset(userId);
	}
	
	// 사용 중인 내 부서 자산 수
	public int totalDeptAssets(int userId) {
		return dao.countMyDeptAsset(userId);
	}
	
	// 사용자 대시보드에서 내 자산 5개 보여주기 
	public List<AssetHistoryDTO> getUserDashAsset(int userId) {
		List<AssetHistoryDTO> list = dao.listHistory(1 ,5, userId);
		return list;
	}
	
	// 사용자 자산 - 내 (사용중인) 자산
	public List<AssetHistoryDTO> getMyUsingAsset(int userId) {
		return dao.myUsingAsset(userId);
	}
	
	// 사용자 자산 - 내 부서 자산
	public List<AssetHistoryDTO> getMyDeptAsset(int userId) {
		return dao.myDeptAsset(userId);
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
