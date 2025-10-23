package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminAssetController {

	@GetMapping("/asset/list")
	public String assetList() {
		return "/admin/adminAssetList";
	}
	
	@GetMapping("/asset/detail")
	public String assetDetail() {
		return "/admin/adminAssetDetail";
	}
	
	@GetMapping("/asset/disposal")
	public String disposalList() {
		return "/admin/adminDisposalList";
	}
}
