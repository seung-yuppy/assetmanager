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

import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.RentService;
import edu.example.assetmanager.service.UserService;

@RequestMapping("/rent")
@Controller
public class RentController {

	private final RentService rentService;
	private final UserService userService;

	public RentController(RentService rentService, UserService userService) {
		this.rentService = rentService;
		this.userService = userService;
	}

	@GetMapping("/form")
	public String requestForm(Model model, HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");	
		if(userId==null) {
			return "redirect:/login";
		}
		UserInfoDTO userInfo= userService.getUser(userId);
		List<UserInfoDTO> admin = rentService.findByAdminUser();
		List<UserInfoDTO> manager = rentService.findByManagerUser();
		model.addAttribute("admin", admin);
		model.addAttribute("manager", manager);
		session.setAttribute("user", userInfo);
		
		return "/rent/rentForm";
	}
	// categoryId값으로 제품 목록 조회
	@GetMapping("/assets")
	@ResponseBody 
	public List<AssetDTO> getAssetsByCategory(@RequestParam("categoryId") int categoryId) {
		List<AssetDTO> assets = rentService.findByAsset(categoryId);
		return assets;
	}
	
	// approvalId, managerId를 insert하기, rent insert 하기
	@PostMapping("/approval")
	public String approval(ApprovalDTO approvalDTO,RentDTO rentDTO,RentContentDTO rentContentDTO, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/login";
		} else {
			if(rentService.insertApproval(approvalDTO,rentDTO,userId,rentContentDTO)) {
				// 요청 성공	
				return "redirect:/rent/list";
			}else {
				// 요청 실패
				return "redirect:/rent/form";
			}				
		}	
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
