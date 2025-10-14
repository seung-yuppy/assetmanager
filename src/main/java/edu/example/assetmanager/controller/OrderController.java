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
	
	@GetMapping("/regist")
	public String regist() {
		return "/order/orderRegist";
	}
	
	@GetMapping("/detail")
	public String detail() {
		return "/order/orderDetail";
	}
	
	@GetMapping("/form2")
	public String form2() {
		return "/order/orderForm2";
	}
	

}
