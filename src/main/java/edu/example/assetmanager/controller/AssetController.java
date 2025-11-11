package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.AssetUsingParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.AssetService;
import edu.example.assetmanager.service.RentService;
import edu.example.assetmanager.service.UserService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class AssetController {
	
	private final AssetService service;
	private final RentService rentService;
	private final UserService userService;

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
	
	@GetMapping("/delay/form")
	public String requestForm(int id, Model model, HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");	
		AssetDTO assetDTO = service.getAsset(id);
		
		if(userId==null) {
			return "redirect:/login";
		}
		UserInfoDTO userInfo= userService.getUser(userId);
		List<UserInfoDTO> admin = rentService.findByAdminUser();
		List<UserInfoDTO> manager = rentService.findByManagerUser();
		model.addAttribute("admin", admin);
		model.addAttribute("manager", manager);	
		model.addAttribute("asset", assetDTO);
		session.setAttribute("user", userInfo);
		
		
		return "/asset/extensionForm";
	}
	
	@PostMapping("/asset/extension/form")
	public String extensionForm(ApprovalDTO approvalDTO, RentDTO rentDTO,RentContentDTO rentContentDTO, HttpSession session) {
		Integer userId =(Integer)session.getAttribute("userId");
		System.out.println("userId 나와??" + userId);
		if(userId==null) {
			return "redirect:/login"; 
		} else {
			if(rentService.insertDelayForm(approvalDTO,rentDTO,rentContentDTO, userId)) {
				// 요청 성공	
				return "redirect:/myasset/list";
			}else {
				// 요청 실패
				return "redirect:/delay/form";
			}				
		}
	}
	
}
