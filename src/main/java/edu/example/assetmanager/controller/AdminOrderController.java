package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminOrderController {
	@GetMapping("/order/list")
	public String index() {
		return "/admin/adminOrderList";
	}
}
