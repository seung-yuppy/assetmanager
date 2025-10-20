package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/rent")
@Controller
public class RentController {
	
	@GetMapping("/form")
	public String requestForm() {
		return "/rent/rentForm"; 
	}
	
	@GetMapping("/list")
	public String list () {
		return "/rent/rentList";
	}
	
	@GetMapping("/list/entry")
	public String listEntry () {
		return "/rent/assetEntryDetail";
	}
	
	@GetMapping("/detail")
	public String rentList() {
		return "/rent/rentDetail";
	}
	
}
