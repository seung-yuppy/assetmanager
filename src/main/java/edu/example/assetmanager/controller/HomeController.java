package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.AssetService;
import edu.example.assetmanager.service.ItemService;
import edu.example.assetmanager.service.UserService;

@Controller
public class HomeController {
	private final UserService service;
	private final AssetService assetService;
	private final ItemService itemService;
	
	public HomeController(UserService service, AssetService assetService, ItemService itemService) {
		this.service = service;
		this.assetService = assetService;
		this.itemService = itemService;
	}
	
	// 사원 & 부장 대시보드
	@GetMapping("/home")
	public String s3(HttpSession session, Model model) {
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId != null) {
			UserInfoDTO dto = service.getUser(userId);
			int usingCount = assetService.totalUsingAssets(userId);
			int deptCount = assetService.totalDeptAssets(userId);
			List<AssetHistoryDTO> list = assetService.getMyUsingAsset(userId);
			
			session.setMaxInactiveInterval(18000); 
			System.out.println("Session timeout (sec): " + session.getMaxInactiveInterval());
			session.setAttribute("userInfo", dto);
			model.addAttribute("usingCount", usingCount);
			model.addAttribute("deptCount", deptCount);
			model.addAttribute("list", list);
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
			System.out.println("Session timeout ad (sec): " + session.getMaxInactiveInterval());
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
}
