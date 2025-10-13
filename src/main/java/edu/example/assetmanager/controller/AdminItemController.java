package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminItemController {
	@GetMapping("/item/list")
	public String itemList() {
		return "/admin/adminStandardItemList";
	}
	
	@GetMapping("/item/form")
	public String form() {
		return "/admin/adminItemForm";
	}
}
