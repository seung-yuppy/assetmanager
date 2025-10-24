package edu.example.assetmanager.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.assetmanager.domain.UserDTO;
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
		List<UserDTO> admin = rentService.findByAdminUser();
		List<UserDTO> manager = rentService.findByManagerUser();
		model.addAttribute("admin", admin);
		model.addAttribute("manager", manager);
		return "/rent/rentForm"; 
	}
	
	@GetMapping("/list")
	public String list () {
		return "/rent/rentList";
	}
	
	@GetMapping("/detail")
	public String rentList() {
		return "/rent/rentDetail";
	}
	
	
	
}
