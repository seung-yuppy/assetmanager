package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.HomeDAO;
import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.DeptAssetDTO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.RentListDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class HomeService {
	private final HomeDAO homeDAO;
	
	public int getCountDept(int userId) {
		return homeDAO.countDept(userId);
	}
	
	public int getCountOrderFirstA(int userId) {
		return homeDAO.countOrderFirstA(userId);
	}
	
	public int getCountOrderFinalA(int userId) {
		return homeDAO.countOrderFinalA(userId);
	}
	
	public int getCountRentFirstA(int userId) {
		return homeDAO.countRentFirstA(userId);
	}
	
	public int getCountRentFinalA(int userId) {
		return homeDAO.countRentFinalA(userId);
	}
	
	public List<AssetHistoryDTO> getListDeptTop3(int userId) {
		return homeDAO.listDeptTop3(userId);
	}
	
	public List<OrderDTO> getListOrderFirstATop3(int userId) {
		return homeDAO.listOrderFirstATop3(userId);
	}
	
	public List<RentListDTO> getListRentFirstATop3(int userId) {
		return homeDAO.listRentFirstATop3(userId);
	}
	
	public int getCountUsing(int userId) {
		return homeDAO.countUsing(userId);
	}
	
	public List<AssetHistoryDTO> getListUsingTop3(int userId) {
		return homeDAO.listUsingTop3(userId);
	}
	
	public int getCountItem() {
		return homeDAO.countItem();
	}
	
	public List<DeptAssetDTO> getListDept() {
		return homeDAO.listDeptCount();
	}
}
