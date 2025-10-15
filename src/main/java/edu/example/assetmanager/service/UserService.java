package edu.example.assetmanager.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.UserDAO;
import edu.example.assetmanager.domain.UserDTO;

@Service
public class UserService {

	@Autowired
	UserDAO dao;
	
    @Autowired
    BCryptPasswordEncoder passwordEncoder;

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
	
	// 회원가입 처리
	public boolean join(UserDTO dto) {
        String encodedPassword = passwordEncoder.encode(dto.getPassword());
        dto.setPassword(encodedPassword);
		
		if (dao.userJoin(dto))
			return true;
		else
			return false;
	}
	
	// 로그인 처리
	public boolean login(String empNo, String password) {
		UserDTO dto = dao.userLogin(empNo);
		if (dto == null)
			return false;
		return passwordEncoder.matches(password, dto.getPassword());
	}
}
