package edu.example.assetmanager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.assetmanager.service.AssetService;

@Controller
@RequestMapping("/admin/return")
public class AdminReturnController {
	
	@GetMapping("/list") 
	public String adminReturnlist(){
		
		return "/admin/adminReturnList";
	}
	
	@GetMapping("/detail") 
	public String adminReturnDetail(){
		
		return "/admin/adminReturnDetail";
	}

}
