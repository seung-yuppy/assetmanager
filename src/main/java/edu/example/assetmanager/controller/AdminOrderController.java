package edu.example.assetmanager.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.OrderParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.OrderService;
import lombok.RequiredArgsConstructor;

@RequestMapping("/admin")
@Controller
@RequiredArgsConstructor
public class AdminOrderController {
	private final OrderService orderService;
	
	@GetMapping("/order/list")
	public String index(HttpSession httpSession, OrderParamDTO orderParamDTO, Model model) {
		PageResponseDTO<OrderDTO> response = orderService.listAllForAdmin(orderParamDTO);
		model.addAttribute("response", response);
		return "/admin/adminOrderList";
	}
	
	@GetMapping("/order/detail")
	public String detail() {
		return "/admin/adminOrderDetail";
	}
}
