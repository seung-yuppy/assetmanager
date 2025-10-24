package edu.example.assetmanager.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.UserService;

@RequestMapping("/admin")
@Controller
public class AdminUserController {
	
	private final UserService service;
	
	public AdminUserController(UserService service) {
		this.service = service;
	}

	@GetMapping("/user/list")
	public String userList(Model model, @RequestParam(defaultValue = "1") int page) {
		List<UserInfoDTO> list = service.getPagedList(page);
		int totalPages = service.getTotalPages();
		int pageBlockSize = 3;
		
	    int currentBlock = (int) Math.ceil((double) page / pageBlockSize);
	    int startPage = (currentBlock - 1) * pageBlockSize + 1;
	    int endPage = Math.min(startPage + pageBlockSize - 1, totalPages);
	    
	    boolean hasPrev = startPage > 1;
	    boolean hasNext = endPage < totalPages;
		
		model.addAttribute("list", list);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		
		model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("hasPrev", hasPrev);
	    model.addAttribute("hasNext", hasNext);
		
		return "/admin/adminUserList";
	}
	
	@GetMapping("/user/detail/{id}")
	public String userDetail(Model model, @PathVariable("id") int id) {
		UserInfoDTO dto = service.getUser(id);
		model.addAttribute("user", dto);
		
		return "/admin/adminUserDetail";
	}
}
