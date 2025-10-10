package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

	@GetMapping("/login")
	public String s1 () {
		return "user/login";
	}
	
	@GetMapping("/join")
	public String s2() {
		return "user/join";
	}
}
