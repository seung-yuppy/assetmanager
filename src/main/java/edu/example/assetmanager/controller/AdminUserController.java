package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminUserController {

	@GetMapping("/user/list")
	public String userList() {
		return "/admin/adminUserList";
	}
	
	@GetMapping("user/detail")
	public String userDetail() {
		return "/admin/adminUserDetail";
	}
}
