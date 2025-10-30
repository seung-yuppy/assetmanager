package edu.example.assetmanager.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Base64;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.UserDAO;
import edu.example.assetmanager.domain.UserDTO;
import edu.example.assetmanager.domain.UserInfoDTO;

@Service
public class UserService {

	@Autowired
	UserDAO dao;
	
    @Autowired
    BCryptPasswordEncoder passwordEncoder;
    
    @Autowired
    ServletContext servletContext;

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
	
	// 회원가입 처리
	public boolean join(UserDTO dto) {
		if (!dto.getPassword().equals(dto.getPasswordCheck()))
            return false;
		
        String encodedPassword = passwordEncoder.encode(dto.getPassword());
        dto.setPassword(encodedPassword);

		try {
			String webPath = "/resources/image/img_profile.png";
			String absolutePath = servletContext.getRealPath(webPath);
			File imageFile = new File(absolutePath);
	        
			if (imageFile.exists() && imageFile.isFile()) {
                byte[] imageBytes = Files.readAllBytes(imageFile.toPath());
                dto.setProfileImage(imageBytes); 
            } else {
                System.err.println("경로: " + absolutePath + " 에서 파일을 찾을 수 없습니다. 기본 이미지 없이 가입 진행.");
                dto.setProfileImage(null); // 파일을 찾지 못하면 null 처리
            }
		} catch (IOException e) {
			e.printStackTrace();
			System.err.println("프로필 이미지 경로 변경 수정 에러 발생" + e);
		}

        boolean isUserJoin = dao.userJoin(dto);  
		if (isUserJoin) {
			if (dao.checkEmpno(dto.getEmpNo()) == 1) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	// 사번 중복 체크
	public boolean isDupEmpno(String empNo) {
		if (dao.checkEmpno(empNo) == 0)
			return true;
		else
			return false;
	}
	
	// 로그인 처리
	public boolean login(String empNo, String password, HttpSession session) {
		UserDTO dto = dao.userLogin(empNo);
		if (dto == null)
			return false;
		
		if (passwordEncoder.matches(password, dto.getPassword())) {
			session.setAttribute("userId", dto.getId());
			return true;
		} else {
			return false;
		}
		
	}

	// 로그인 후 사용자 정보 불러오기
	public UserInfoDTO getUser(int userId) {
		UserInfoDTO dto = dao.getUserInfo(userId);
		
		if (dto != null) {
			String role = dto.getRole();
			switch (role) {
				case "employee":
					dto.setRole("사원");
					break;
				case "manager":
					dto.setRole("부장");
					break;
				case "admin":
					dto.setRole("관리자");
					break;
				case "department":
					dto.setRole("부서");
					break;
			}
			
			byte[] profileImageBytes = dto.getProfileImage();
	        if (profileImageBytes != null && profileImageBytes.length > 0) {
	            String base64Image = Base64.getEncoder().encodeToString(profileImageBytes);
	            dto.setBase64ProfileImage(base64Image);
	        } else {
	            // 프로필 이미지가 없는 경우 (null 또는 빈 배열)
	            dto.setBase64ProfileImage(null); 
	        }
		}
		
		return dto;
	}
	
	// 직급 전처리 
	public void processRole(UserInfoDTO dto) {
		switch(dto.getRole()) {
			case "employee":
				dto.setRole("사원");
				break;
			case "manager":
				dto.setRole("부장");
				break;
			case "admin" :
				dto.setRole("관리자");
				break;
		}
	}
	
	// 목록 데이터 가공
	public List<UserInfoDTO> refactorList(List<UserInfoDTO> list) {
		if (list != null) {
			for (UserInfoDTO dto : list)
				processRole(dto);
		}
		return list;
	}
	
	// 페이징 처리된 목록을 가져오는 메서드
	public List<UserInfoDTO> getPagedList(int page) {
		int pageSize = 10;
		int start = (page - 1) * pageSize + 1;
		int end = start + pageSize - 1;
		List<UserInfoDTO> list = dao.listAll(start, end);
		return refactorList(list);
	}
	
	// 총 페이지 수를 계산하는 메서드
	public int getTotalPages() {
		int pageSize = 10;
		int totalItems = dao.countAll();
		return (int)Math.ceil((double) totalItems / pageSize);
	}
	
	// 마이페이지에서 프로필 이미지 수정하는 메서드
	public boolean changeUserInfo(UserDTO dto) {
		if (dao.changeUserInfo(dto))
			return true;
		else
			return false;
	}
	
	// 사용자 화면에서 구매 요청 개수
	public int getOrderCount(int userId) {
		return dao.countOrder(userId);
	}
	
	// 사용자 화면에서 반출 요청 개수
	public int getRentCount(int userId) {
		return dao.countRent(userId);
	}
}
