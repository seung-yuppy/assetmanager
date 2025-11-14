package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.CategoryAssetDTO;
import edu.example.assetmanager.domain.DeptAssetDTO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.RentListDTO;

@Mapper
public interface HomeDAO {
	// manager 대시보드
	// 부서 물품 개수
	public int countDept(int userId);
	
	// 구매 First_Approval 개수
	public int countOrderFirstA(int userId);
	
	// 구매 Final_Approval 개수
	public int countOrderFinalA(int userId);
	
	// 반출 First_Approval 개수
	public int countRentFirstA(int userId);
	
	// 반출 Final_Approval 개수
	public int countRentFinalA(int userId);
	
	// 부서 자산 3개 목록
	public List<AssetHistoryDTO> listDeptTop3(int userId);
	
	// 구매 First_Approval 3개 목록
	public List<OrderDTO> listOrderFirstATop3(int userId);
	
	// 반출 First_Approval 3개 목록
	public List<RentListDTO> listRentFirstATop3(int userId);
	
	// employee 대시보드
	// 사용 중인 내 자산 개수
	public int countUsing(int userId);
	
	// 사용 중인 내 자산 3개 목록
	public List<AssetHistoryDTO> listUsingTop3(int userId);
	
	// admin 대시보드
	// 권장 제품 개수
	public int countItem();
	
	// 부서 개수
	public List<DeptAssetDTO> listDeptCount();

	// 카테고리별 개수
	public List<CategoryAssetDTO> listCategoryCount();
	
	// 구매 요청 개수
	public int countOrder(int userId);

	// 반출 요청 개수 
	public int countRent(int userId);
	
	// 반납 요청 개수 
	public int countReturn();
	
	// 연장 요청 개수
	public int countDelay(int userId);
}
