package edu.example.assetmanager.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.UserService;

@Controller
public class HomeController {
	
	@Autowired
	UserService service;
	
	// 사원 & 부장 대시보드
	@GetMapping("/home")
	public String s3(HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId != null) {
			UserInfoDTO dto = service.getUser(userId);
			session.setAttribute("userInfo", dto);
			return "dashboard/userDashBoard";
		} else {
			return "redirect:/login";
		}
	}
	
	// 관리자 대시보드
	@GetMapping("/admin/home")
	public String s4(HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId != null) {
			UserInfoDTO dto = service.getUser(userId);
			session.setAttribute("userInfo", dto);
			return "dashboard/adminDashBoard";	
		} else {
			return "redirect:/login";
		}
	}
}
