package edu.example.assetmanager.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.RentService;

@RequestMapping("/rent")
@Controller
public class RentController {

	private final RentService rentService;

	public RentController(RentService rentService) {
		this.rentService = rentService;
	}

	@GetMapping("/form")
	public String requestForm(Model model) {
		List<UserInfoDTO> admin = rentService.findByAdminUser();
		List<UserInfoDTO> manager = rentService.findByManagerUser();
		model.addAttribute("admin", admin);
		model.addAttribute("manager", manager);
		return "/rent/rentForm";
	}
	// categoryId값으로 제품 목록 조회
	@GetMapping("/assets")
	@ResponseBody
	public List<AssetDTO> getAssetsByCategory(@RequestParam("categoryId") int categoryId) {
		List<AssetDTO> assets = rentService.findByAsset(categoryId);
		return assets;
	}

	@GetMapping("/list")
	public String list() {
		return "/rent/rentList";
	}

	@GetMapping("/detail")
	public String rentList() {
		return "/rent/rentDetail";
	}
}
