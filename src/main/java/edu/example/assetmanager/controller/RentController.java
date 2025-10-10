package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/rent")
@Controller
public class RentController {
	
	@GetMapping("/form")
	public String requestForm() {
		return "/rent/rentRequestForm";
	}
	
	@GetMapping("/list")
	public String list () {
		return "/rent/rentList";
	}
	
	@GetMapping("/list/detail")
	public String listDetail () {
		return "/rent/assetEntryDetail";
	}
	
}
