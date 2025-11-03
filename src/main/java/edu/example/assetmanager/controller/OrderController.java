package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.CategoryDTO;
import edu.example.assetmanager.domain.ItemDTO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.OrderDetailRESP;
import edu.example.assetmanager.domain.OrderFormDTO;
import edu.example.assetmanager.domain.OrderParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.AssetService;
import edu.example.assetmanager.service.CategoryService;
import edu.example.assetmanager.service.ItemService;
import edu.example.assetmanager.service.OrderService;
import edu.example.assetmanager.service.RentService;
import edu.example.assetmanager.service.UserService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/order")
@Controller
public class OrderController {
	private final OrderService orderService;
	private final CategoryService categoryService;
	private final ItemService itemService;
	private final UserService userService;
	private final AssetService assetService;
	
	@GetMapping("/form")
	public String form(HttpSession httpSession, Model model) {
		UserInfoDTO userInfo = (UserInfoDTO) httpSession.getAttribute("userInfo");
		if (userInfo == null)
			return "redirect:/login";
		//결재자 정보
		List<UserInfoDTO> admin = userService.getUsersByRole("admin");
		List<UserInfoDTO> manager = userService.getUsersByRole("manager");
		model.addAttribute("admin", admin);
		model.addAttribute("manager", manager);
		
		// 카테고리 목록
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
	
	@GetMapping("/detail/{id}")
	public String detail(@PathVariable int id, Model model, HttpSession session) {
		OrderDetailRESP response = orderService.getOrderDetail(id);
		OrderDTO orderDTO =  response.getOrderDto();
		ApprovalDTO approvalDTO = response.getApprovalDTO();
		int userId = (int)session.getAttribute("userId");
		
		// 결재에 포함된 사용자만 조회 가능 
		if((userId != orderDTO.getUserId()) && (userId != approvalDTO.getManagerId()) && (userId != approvalDTO.getApproverId())) 
			return "redirect:/login";
		
		model.addAttribute("order", orderDTO);
		model.addAttribute("approval", approvalDTO);
		model.addAttribute("products", response.getProducts());
		model.addAttribute("empInfo", response.getApproverInfoDTO());
		
		return "/order/orderDetail";
	}

	@ResponseBody
	@GetMapping(value = "/cancel", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> cancelOrder(int id, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null)
			response.put("msg", "로그인 후 진행해주세요.");
		
		if (orderService.cancelOrder(id))
			response.put("msg", "요청 취소가 완료되었습니다.");
		else
			response.put("msg", "요청 취소에 실패하였습니다.");
		
		return ResponseEntity.ok(response);
	}
	
//	@ResponseBody
//	@PostMapping(value = "/register/item", produces = "application/json; charset=utf-8")
//	public ResponseEntity<Map<String, Object>> registerNewAsset(@RequestBody Asset,  HttpSession session) {
//		Map<String, Object> response = new HashMap<>();
//		Integer userId = (Integer) session.getAttribute("userId");
//		assetHistoryDTO.setUserId(userId);
//		
//		if(orderService.registerAsset(Asset)) {
//			response.put("msg", "자산 등록에 성공하였습니다.");
//		}else {
//			response.put("msg", "일련번호가 일치하지 않거나 오류가 발생했습니다.");
//		}
//		
//	    return ResponseEntity.ok(response);
//	}
	
}
