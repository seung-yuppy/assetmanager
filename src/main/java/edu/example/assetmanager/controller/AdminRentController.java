package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApproverInfoDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.domain.RentParamDTO;
import edu.example.assetmanager.domain.RentShowDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.RentService;

@RequestMapping("/admin")
@Controller
public class AdminRentController {
	private final RentService rentService;  

	public AdminRentController(RentService rentService) {
		this.rentService = rentService;

	}
	
	@GetMapping("/rent/list")
	public String adminList(HttpSession session, RentParamDTO rentParamDTO, Model model) {
		System.out.println("session 들어와??"+session);
		Integer userId = (Integer) session.getAttribute("userId");
		UserInfoDTO userInfo = (UserInfoDTO) session.getAttribute("userInfo");
        if (userId == null) { 
            return "redirect:/login";    
        }
        rentParamDTO.setUserId(userId);
        PageResponseDTO<RentListDTO> adminList = rentService.adminList(rentParamDTO);
        model.addAttribute("response", adminList);
        model.addAttribute("userInfo", userInfo);
        
        return "admin/adminRentList";
    }
	
	@GetMapping("/delay/list")
	public String adminDelayList(HttpSession session, RentParamDTO rentParamDTO, Model model) { 
		Integer userId = (Integer) session.getAttribute("userId");
		UserInfoDTO userInfo = (UserInfoDTO) session.getAttribute("userInfo");
        if (userId == null) { 
            return "redirect:/login";    
        }
        rentParamDTO.setUserId(userId);
        PageResponseDTO<RentListDTO> adminList = rentService.adminDelayList(rentParamDTO);
        model.addAttribute("response", adminList);
        model.addAttribute("userInfo", userInfo);
        return "admin/adminDelayList";
    }
	
	@GetMapping("/rent/detail/{id}")
	public String adminRentDetail(@PathVariable Long id, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        
        if (userId == null) {
            return "redirect:/login";
        }
        ApproverInfoDTO approverInfoDTO = rentService.getRentApprovalDetail(id);
        RentShowDTO rentDTO = rentService.getRentDetail(id);
        List<RentContentDTO> rentContentDTO = rentService.getRentContentDetail(id);
        ApprovalDTO approvalDTO = rentService.getApprovalByRentId(id);

        model.addAttribute("empInfo", approverInfoDTO); 
        model.addAttribute("rent", rentDTO);           
        model.addAttribute("item", rentContentDTO);   
        model.addAttribute("approval", approvalDTO);   
		
		return "/admin/adminRentDetail";
	}
	
	@GetMapping("rent/approve")
	public String approve(int id) {
		return "redirect:/admin/adminRentDetail";
	}
}
