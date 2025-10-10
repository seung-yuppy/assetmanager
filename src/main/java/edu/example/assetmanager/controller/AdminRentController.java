package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminRentController {
	
	@GetMapping("/rent/list")
	public String requestForm() {
		return "/admin/adminRentList";
	}
	
	@GetMapping("/asset/list")
	public String assetList() {
		return "/admin/adminAssetList";
	}
	
	@GetMapping("/asset/detail")
	public String assetDetail() {
		return "/admin/adminAssetDetail";
	}
	
	@GetMapping("/item/list")
	public String itemList() {
		return "/admin/adminStandardItemList";
	}
}
