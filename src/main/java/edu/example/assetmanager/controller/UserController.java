package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.UserDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	UserService service;

	@GetMapping("/login")
	public String s1 () {
		return "user/login";
	}
	
	@GetMapping("/join")
	public String s2() {
		return "user/join";
	}
	
	@GetMapping("/mypage")
	public String s4() {
		return "user/myPage";
	}
	
	// 회원가입
	@PostMapping("/join")
	public String userJoin(UserDTO dto) {
		boolean isJoin = service.join(dto);
		
		if (isJoin)
			return "redirect:/login";
		else 
			return "redirect:/join";
	}
	
	// 사번 중복체크
	@ResponseBody
	@PostMapping(value = "/check/empno", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> checkEmpno(@RequestBody Map<String, String> requestBody) {
		Map<String, Object> response = new HashMap<>();
		String empNo = requestBody.get("empNo");
		
		if (service.isDupEmpno(empNo))
			response.put("isDup", "사용 가능한 사번입니다.");
		else
			response.put("isDup", "이미 사용중인 사번입니다.");
		
		return ResponseEntity.ok(response);
	}
	
	// 로그인
	@PostMapping("/login")
	public String userJoin(String empNo, String password, HttpSession session) {
		if (service.login(empNo, password, session)) {
			int userId = (int) session.getAttribute("userId");
			UserInfoDTO dto = service.getUser(userId);
			String role = dto.getRole();
			if (role.equals("관리자")) 
				return "redirect:/admin/home";
			else 
				return "redirect:/home";
		} else {
			return "redirect:/login";
		}
			
	}
}
