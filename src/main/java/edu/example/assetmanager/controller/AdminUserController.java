package edu.example.assetmanager.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.assetmanager.domain.AssetHistoryUserShowDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.domain.UserParamDTO;
import edu.example.assetmanager.service.AssetService;
import edu.example.assetmanager.service.UserService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/admin")
@Controller
public class AdminUserController {
	
	private final UserService service;
	private final AssetService assetService;

	@GetMapping("/user/list")
	public String userList(Model model, UserParamDTO dto) {
		PageResponseDTO<UserInfoDTO> list = service.listAll(dto);
		model.addAttribute("response", list);
		return "/admin/adminUserList";
	}	
	
	@GetMapping("/user/detail/{id}")
	public String userDetail(Model model, @PathVariable("id") int id) {
		UserInfoDTO dto = service.getUser(id);
		List<AssetHistoryUserShowDTO> assetList = assetService.getUserAssetHistory(id);
		
		model.addAttribute("user", dto);
		model.addAttribute("assetHistory", assetList);
		
		return "/admin/adminUserDetail";
	}
}
