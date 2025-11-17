package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@GetMapping("/delay/form/{id}")
	public String requestForm(@PathVariable int id, Model model, HttpSession session) {	
		Integer userId = (Integer)session.getAttribute("userId");
		if(userId == null) 
			return "redirect:/login";
		AssetDTO assetDTO = service.getAsset(id);		
		AssetHistoryDTO assetHistoryDTO = service.getReturnDate(userId, id);
		
		UserInfoDTO userInfo= userService.getUser(userId);
		List<UserInfoDTO> admin = rentService.findByAdminUser();
		List<UserInfoDTO> manager = userService.getUsersByRoleAndDept("manager", userInfo.getDepartmentId());
		model.addAttribute("admin", admin);
		model.addAttribute("manager", manager);	
		model.addAttribute("asset", assetDTO);
		model.addAttribute("returning", assetHistoryDTO);
		
		System.out.println(assetHistoryDTO.getReturnDate());
		session.setAttribute("user", userInfo);
		
		return "/asset/extensionForm";
	}
	
	@PostMapping("/asset/extension/form")
	public String extensionForm(ApprovalDTO approvalDTO, RentDTO rentDTO, RentContentDTO rentContentDTO, HttpSession session, RedirectAttributes rattr) {
		Integer userId =(Integer)session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/login"; 
		} else {
			if (rentService.insertDelayForm(approvalDTO, rentDTO, rentContentDTO, userId)) {
				// 요청 성공	
				int assetId = rentContentDTO.getAssetId();
				rattr.addFlashAttribute("delaySuccess", "연장 요청이 완료되었습니다.");
				return "redirect:/delay/form/" + assetId;
			} else {
				// 요청 실패
				int assetId = rentContentDTO.getAssetId();
				rattr.addFlashAttribute("delayFail", "연장 요청이 실패하였습니다.");
				return "redirect:/delay/form/" + assetId;
			}				
		}
	}
	
}
