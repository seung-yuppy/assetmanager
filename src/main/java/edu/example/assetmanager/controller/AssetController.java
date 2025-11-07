package edu.example.assetmanager.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.AssetUsingParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.AssetService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AssetController {
	
	private final AssetService service;

	@GetMapping("/myasset/list")
	public String assetList(Model model, HttpSession session, AssetUsingParamDTO dto) {
		UserInfoDTO userInfo = (UserInfoDTO) session.getAttribute("userInfo");
		if (userInfo == null || (Integer)userInfo.getId() == null) 
			return "redirect:/login";
		dto.setUserId(userInfo.getId());
		PageResponseDTO<AssetHistoryDTO> list = service.listMyUsingAll(dto, dto.getUserId());
		model.addAttribute("response", list);
		model.addAttribute("userInfo", userInfo);
		return "/asset/userAssetList";
	}
	
	@GetMapping("/deptasset/list")
	public String deptAssetList(Model model, HttpSession session, AssetUsingParamDTO dto) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null)
			return "redirect:/login";
		dto.setUserId(userId);
		PageResponseDTO<AssetHistoryDTO> list = service.listMyDeptAll(dto);
		model.addAttribute("response", list);
		return "/asset/userDeptAssetList";
	}

	@GetMapping("/asset/extension/form")
	public String extensionForm() {
		return "/asset/extensionForm";
	}
	
}
