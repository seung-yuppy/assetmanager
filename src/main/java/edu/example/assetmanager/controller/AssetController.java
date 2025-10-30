package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.service.AssetService;

@Controller
public class AssetController {
	
	private final AssetService service;
	
	public AssetController(AssetService service) {
		this.service = service;
	}
	
	@GetMapping("/myasset/list")
	public String assetList(Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) 
			return "redirect:/login";
		
		List<AssetHistoryDTO> list = service.getMyUsingAsset(userId);
		model.addAttribute("list", list);

		return "/asset/userAssetList";
	}
	
	@GetMapping("/deptasset/list")
	public String deptAssetList(Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null)
			return "redirect:/login";
		
		List<AssetHistoryDTO> list = service.getMyDeptAsset(userId);
		model.addAttribute("list", list);
		
		return "/asset/userDeptAssetList";
	}
	
	@GetMapping("/asset/form")
	public String assetForm() {
		return "/asset/userAssetForm";
	}
	
	@GetMapping("/asset/extension/form")
	public String extensionForm() {
		return "/asset/extensionForm";
	}
	
}
