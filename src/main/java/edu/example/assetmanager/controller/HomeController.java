package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/home")
	public String s3() {
		return "dashboard/userDashBoard";
	}
	
	@GetMapping("/admin/home")
	public String s4() {
		return "dashboard/adminDashBoard";
	}
}
