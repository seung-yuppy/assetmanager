package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/login")
	public String s1 () {
		return "user/login";
	}
	
	@GetMapping("/join")
	public String s2() {
		return "user/join";
	}
	
	@GetMapping("/home/user")
	public String s3() {
		return "dashboard/userDashBoard";
	}
	
	@GetMapping("/home/admin")
	public String s4() {
		return "dashboard/adminDashBoard";
	}
}
