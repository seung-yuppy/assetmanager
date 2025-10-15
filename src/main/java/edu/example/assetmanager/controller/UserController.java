package edu.example.assetmanager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import edu.example.assetmanager.domain.UserDTO;
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
	
	@PostMapping("/join")
	public String userJoin(@ModelAttribute UserDTO dto) { 
		if (service.join(dto))
			return "redirect:/login";
		else 
			return "redirect:/join";
	}
	
	@PostMapping("/login")
	public String userJoin(String empNo, String password) {
		if (service.login(empNo, password))
			return "redirect:/home";
		else
			return "redirect:/login";
	}
}
