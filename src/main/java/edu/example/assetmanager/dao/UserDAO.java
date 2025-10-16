package edu.example.assetmanager.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.UserDTO;

@Mapper
public interface UserDAO {

	// 회원가입
	public boolean userJoin(@Param("user") UserDTO dto);
	
	// 사번 중복체크
	public int checkEmpno(@Param("empNo") String empNo);
	
	// 로그인
	public UserDTO userLogin(@Param("empNo") String empNo);
}
