package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.UserDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.domain.UserParamDTO;

@Mapper
public interface UserDAO {

	// 회원가입
	public boolean userJoin(@Param("user") UserDTO dto);
	
	// 사번 중복체크
	public int checkEmpno(@Param("empNo") String empNo);
	
	// 로그인
	public UserDTO userLogin(@Param("empNo") String empNo);
	
	// 로그인 정보 불러오기
	public UserInfoDTO getUserInfo(@Param("userId") int userId);
	
	// 관리자 회원 정보 전체 개수
	public int countAll();
	
	// 관리자 회원 목록
	public List<UserInfoDTO> listAll(UserParamDTO dto);
	
	// 마이페이지에서 프로필 수정하기
	public boolean changeUserInfo(@Param("user") UserDTO user);
	
	// 사용자 대시보드에서 구입 요청 개수
	public int countOrder(@Param("userId") int userId);
	
	// 사용자 대시보드에서 반출 요청 개수
	public int countRent(@Param("userId") int userId);
}
