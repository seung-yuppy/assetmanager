package edu.example.assetmanager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import edu.example.assetmanager.dao.UserDAO;
import edu.example.assetmanager.domain.UserDTO;

@Controller
public class UserController {
	
	@Autowired
	UserDAO dao;

	@GetMapping("/login")
	public String s1 () {
		return "user/login";
	}
	
	@GetMapping("/join")
	public String s2() {
		return "user/join";
	}
	
	@PostMapping("/join")
	public String s3(@ModelAttribute UserDTO dto) { 
		if (dao.userJoin(dto))
			return "redirect:/login";
		else 
			return "redirect:/join";
	}
}
