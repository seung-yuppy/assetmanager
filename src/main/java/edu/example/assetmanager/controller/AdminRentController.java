package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.service.RentService;

@RequestMapping("/admin")
@Controller
public class AdminRentController {
	private final RentService rentService;  

	public AdminRentController(RentService rentService) {
		this.rentService = rentService;

	}
	
	@GetMapping("/rent/list")
	public String adminList(HttpSession session, Model model) {
		System.out.println("session 들어와??"+session);
		Integer userId = (Integer) session.getAttribute("userId");	
		System.out.println("approverId 몇번이야???" + userId);
        if (userId == null) { 
            return "redirect:/login";    
        }
        List<RentListDTO> adminList = rentService.adminList(userId); 
        System.out.println("adminList 나와??"+adminList);
        model.addAttribute("adminList", adminList);
        
        return "admin/adminRentList";
    }
	
	@GetMapping("/rent/detail")
	public String listDetail() {
		return "/admin/adminRentDetail"; 
	}
}
