package edu.example.assetmanager.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import edu.example.assetmanager.domain.AdminInfoDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.UserService;

@Controller
public class HomeController {
	
	@Autowired
	UserService service;
	
	@GetMapping("/home")
	public String s3(HttpSession session) {
		int userId = (int)session.getAttribute("userId");
		UserInfoDTO dto = service.getUser(userId);
		session.setAttribute("userInfo", dto);

		return "dashboard/userDashBoard";
	}
	
	@GetMapping("/admin/home")
	public String s4(HttpSession session) {
		int userId = (int) session.getAttribute("userId");
		AdminInfoDTO dto = service.getAdmin(userId);
		session.setAttribute("adminInfo", dto);
		
		return "dashboard/adminDashBoard";
	}
}
