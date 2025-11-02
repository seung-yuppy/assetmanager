package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApproverInfoDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.domain.RentShowDTO;
import edu.example.assetmanager.service.RentService;

@RequestMapping("/admin")
@Controller
public class AdminRentController {
	private final RentService rentService;  

	public AdminRentController(RentService rentService) {
		this.rentService = rentService;

	}
	
	@GetMapping("/rent/list")
	public String adminList(HttpSession session,@RequestParam(value = "status", required = false) String status, Model model) {
		System.out.println("session 들어와??"+session);
		Integer userId = (Integer) session.getAttribute("userId");	
		System.out.println("approverId 몇번이야???" + userId);
        if (userId == null) { 
            return "redirect:/login";    
        }
        List<RentListDTO> adminList = rentService.adminList(userId, status);
        System.out.println("adminList 나와??"+adminList);
        model.addAttribute("adminList", adminList);
        model.addAttribute("status", status);
        
        return "admin/adminRentList";
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
        
        // 현재 결재자가 맞는지 확인하기 
        boolean isApprover = false;
        if (approvalDTO != null) {
            String currentStatus = approvalDTO.getStatus().name(); 
        
            if ("PENDING".equals(currentStatus) && userId.equals(approvalDTO.getApproverId())) {
            	isApprover = true;
            } 
            else if ("FIRST_APPROVAL".equals(currentStatus) && userId.equals(approvalDTO.getManagerId())) {
            	isApprover = true;
            }
        }

        model.addAttribute("empInfo", approverInfoDTO); 
        model.addAttribute("rent", rentDTO);           
        model.addAttribute("item", rentContentDTO);   
        model.addAttribute("approval", approvalDTO);   
        model.addAttribute("isApprover", isApprover);  
		
		return "/admin/adminRentDetail";
	}
}
