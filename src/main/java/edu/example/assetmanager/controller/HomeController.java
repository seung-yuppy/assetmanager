package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/login")
	public String s1 () {
		return "login";
	}
	
	@GetMapping("/join")
	public String s2() {
		return "join";
	}
	
	@GetMapping("/home")
	public String s3() {
		return "home";
	}
}
