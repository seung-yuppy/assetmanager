package edu.example.assetmanager.controller;


import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.OrderDetailRESP;
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
		UserInfoDTO userInfo = (UserInfoDTO) httpSession.getAttribute("userInfo");
		if (userInfo != null) {
			orderParamDTO.setUserId(userInfo.getId());
		}
		PageResponseDTO<OrderDTO> response = orderService.listAllForAdmin(orderParamDTO);
		model.addAttribute("response", response);
		return "/admin/adminOrderList";
	}
	
	@GetMapping("/order/detail/{id}")
	public String detail(@PathVariable int id, Model model) {
		OrderDetailRESP response = orderService.getOrderDetail(id);
		model.addAttribute("order", response.getOrderDto());
		model.addAttribute("approval", response.getApprovalDTO());
		model.addAttribute("products", response.getProducts());
		model.addAttribute("empInfo", response.getApproverInfoDTO());
		System.out.println("결재한 관리자 이름 : " + response.getApproverInfoDTO().getApproverInfo().getUsername());
		System.out.println("결재한 부장 이름 : " + response.getApproverInfoDTO().getManagerInfo().getUsername());
		return "/admin/adminOrderDetail";
	}
	
	@GetMapping("order/approve")
	public String approve(int id) {
		return "redirect:/admin/adminOrderDetail";
	}
	
}
