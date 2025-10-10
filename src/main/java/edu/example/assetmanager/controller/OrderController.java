package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/order")
@Controller
public class OrderController {
	
	@GetMapping("/list")
	public String index () {
		return "/order/orderList";
	}
	
	@GetMapping("/form")
	public String form() {
		return "/order/orderForm";
	}
	
	@GetMapping("/detail")
	public String requestDetail() {
		return "/order/orderRequestDetail";
	}

}
