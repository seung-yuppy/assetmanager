package edu.example.assetmanager.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.OrderParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.service.OrderService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/order")
@Controller
public class OrderController {
	private final OrderService OrderService;
	
	@GetMapping("/form")
	public String form(HttpSession httpSession) {
		return "/order/orderForm";
	}
	
	@GetMapping("/list")
	public String index (HttpSession httpSession, Model model, OrderParamDTO orderParamDTO) {
		PageResponseDTO<OrderDTO> response = OrderService.listAll(orderParamDTO);
		model.addAttribute("response", response);
		return "/order/orderList";
	}
	
	@GetMapping("/detail")
	public String detail(String status) {
		return "/order/orderDetail";
	}
	
}
