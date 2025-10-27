package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.CategoryDTO;
import edu.example.assetmanager.domain.ItemDTO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.OrderFormDTO;
import edu.example.assetmanager.domain.OrderParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.CategoryService;
import edu.example.assetmanager.service.ItemService;
import edu.example.assetmanager.service.OrderService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/order")
@Controller
public class OrderController {
	private final OrderService orderService;
	private final CategoryService categoryService;
	private final ItemService itemService;
	
	@GetMapping("/form")
	public String form(HttpSession httpSession, Model model) {
		List<CategoryDTO> categories = categoryService.getCategories();
		model.addAttribute("categories",categories);
		return "/order/orderForm";
	}
	
	@PostMapping("/form")
	public String newOrder(HttpSession httpSession, OrderFormDTO orderFormDTO) {
		UserInfoDTO userInfo = (UserInfoDTO) httpSession.getAttribute("userInfo");
		if (userInfo != null) {
			orderFormDTO.setUserId(userInfo.getId());
		}
		System.out.println("title : " + orderFormDTO.getTitle());
		orderService.save(orderFormDTO);
		
		return "redirect:/order/list";
	}
	
	@GetMapping("/form/standard")
	@ResponseBody
	public List<ItemDTO> getStandardsByCategory(int categoryId) {
		return itemService.getItemsByCategory(categoryId);
	}
	
	@GetMapping("/form/category")
	@ResponseBody
	public List<CategoryDTO> getCategories(){
		return categoryService.getCategories();
	}
	
	@GetMapping("/list")
	public String index (HttpSession httpSession, Model model, OrderParamDTO orderParamDTO) {
		UserInfoDTO userInfo = (UserInfoDTO) httpSession.getAttribute("userInfo");
		if (userInfo != null) {
			orderParamDTO.setUserId(userInfo.getId());
		}
		PageResponseDTO<OrderDTO> response = orderService.listAll(orderParamDTO);
		model.addAttribute("response", response);
		return "/order/orderList";
	}
	
	@GetMapping("/detail")
	public String detail(String status) {
		return "/order/orderDetail";
	}
	
}
