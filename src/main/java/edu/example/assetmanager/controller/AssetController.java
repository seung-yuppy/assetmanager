package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AssetController {
	
	@GetMapping("/asset/list")
	public String assetList() {
		return "/asset/userAssetList";
	}
}
