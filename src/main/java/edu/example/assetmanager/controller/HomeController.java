package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.AssetService;
import edu.example.assetmanager.service.HomeService;
import edu.example.assetmanager.service.ItemService;
import edu.example.assetmanager.service.OrderService;
import edu.example.assetmanager.service.RentService;
import edu.example.assetmanager.service.UserService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class HomeController {
	private final UserService service;
	private final AssetService assetService;
	private final ItemService itemService;
	private final OrderService orderService;
	private final RentService rentService;
	private final HomeService homeService;
	
	// 사원 & 부장 대시보드
	@GetMapping("/home")
	public String s3(HttpSession session, Model model) {
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId != null) {
			UserInfoDTO dto = service.getUser(userId);
			int usingCount = homeService.getCountUsing(userId);
			int pendingOrder = orderService.countPendingOrder(userId);
			int approvalOrder = orderService.countApprovalOrder(userId);
			int pendingRent = rentService.countPendingRent(userId);
			int approvalRent = rentService.countingApprovalRent(userId);

			int deptCount = homeService.getCountDept(userId);
			int firstAOrder = homeService.getCountOrderFirstA(userId);
			int finalAOrder = homeService.getCountOrderFinalA(userId);
			int firstARent = homeService.getCountRentFirstA(userId);
			int finalARent = homeService.getCountRentFinalA(userId);
			
			List<AssetHistoryDTO> list = homeService.getListUsingTop3(userId);
			List<OrderDTO> orderList = orderService.getOrderTop3(userId);
			List<RentListDTO> rentList = rentService.getRentTop3(userId);
			
			List<AssetHistoryDTO> deptList = homeService.getListDeptTop3(userId);
			List<OrderDTO> orderFirstList = homeService.getListOrderFirstATop3(userId);
			List<RentListDTO> rentFirstList = homeService.getListRentFirstATop3(userId);
			
			session.setMaxInactiveInterval(18000); 
			session.setAttribute("userInfo", dto);
			
			switch(dto.getRole()) {
				case "department":
				case "employee":
					model.addAttribute("usingCount", usingCount);
					model.addAttribute("pendingOrder", pendingOrder);
					model.addAttribute("finalOrder", approvalOrder);
					model.addAttribute("pendingRent", pendingRent);
					model.addAttribute("finalRent", approvalRent);
					model.addAttribute("list", list);
					model.addAttribute("orderList", orderList);
					model.addAttribute("rentList", rentList);
					break;
				case "manager":
					model.addAttribute("usingCount", deptCount);
					model.addAttribute("firstOrder", firstAOrder);
					model.addAttribute("finalOrder", finalAOrder);
					model.addAttribute("firstRent", firstARent);
					model.addAttribute("finalRent", finalARent);
					model.addAttribute("list", deptList);
					model.addAttribute("orderList", orderFirstList);
					model.addAttribute("rentList", rentFirstList);
					break;
			}
			return "dashboard/userDashBoard";
		} else {
			return "redirect:/login";
		}
	}
	
	// 관리자 대시보드
	@GetMapping("/admin/home")
	public String s4(HttpSession session, Model model) {
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId != null) {
			UserInfoDTO dto = service.getUser(userId);
			int totalAsset = assetService.getTotalAsset();
			int usingAsset = assetService.getUsingAsset();
			int pendingAsset = assetService.getPendingAsset();
			int invalidAsset = assetService.getInvalidAsset();
			int totalItem = itemService.getTotalItem();
			
			session.setMaxInactiveInterval(18000); 
			session.setAttribute("userInfo", dto);
			model.addAttribute("totalAsset", totalAsset);
			model.addAttribute("usingAsset", usingAsset);
			model.addAttribute("pendingAsset", pendingAsset);
			model.addAttribute("invalidAsset", invalidAsset);
			model.addAttribute("totalItem", totalItem);
			return "dashboard/adminDashBoard";	
		} else {
			return "redirect:/login";
		}
	}
	
	// 창고 자산 보유 현황을 위한 차트
	@ResponseBody
	@GetMapping(value = "/asset/value", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> h3() {
		Map<String, Object> response = new HashMap<>();
		int totalAsset = assetService.getTotalAsset();
		int usingAsset = assetService.getUsingAsset();
		int pendingAsset = assetService.getPendingAsset();
		int invalidAsset = assetService.getInvalidAsset();
		
		response.put("totalAsset", totalAsset);
		response.put("usingAsset", usingAsset);
		response.put("pendingAsset", pendingAsset);
		response.put("invalidAsset", invalidAsset);
		
		return ResponseEntity.ok(response);
	}
}
