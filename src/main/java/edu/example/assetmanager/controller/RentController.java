package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/rent")
@Controller
public class RentController {
	
	@GetMapping("/request")
	public String requestForm() {
		return "/rent/rentRequestForm";
	}
	
	@GetMapping("/request/list")
	public String list () {
		return "/rent/rentList";
	}
	
}
