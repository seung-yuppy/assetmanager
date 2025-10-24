package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.domain.UserDTO;

@Service
public class RentService {
	private final RentDAO rentDAO;
	
	public RentService(RentDAO rentDAO) {
		this.rentDAO = rentDAO;
	}

	// dept가 경영지원팀인 user 가지고 오기
	public List<UserDTO> findByAdminUser(){	
		List<UserDTO> admin = null;
		admin = rentDAO.findByAdminUser();
		return admin;
	}
	// role이 부장인 user 가지고 오기
	public List<UserDTO> findByManagerUser(){
		List<UserDTO> manager = null;
		manager = rentDAO.findByManagerUser();
		return manager;
	}
	
	// 
	
	// 카테고리를 선택하면 assetName 필터링
	
	// assetName 클릭하면 모달 띄우기 
	
	// 수량...?
	// count가 n개이면, asset 테이블을 가지고 오기???
	
	// 결재라인 
	// department=경영지원팀인 user을 가지고 온다.
	
	
}
