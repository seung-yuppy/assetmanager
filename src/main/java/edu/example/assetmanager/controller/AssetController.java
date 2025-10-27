package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.service.AssetService;

@Controller
public class AssetController {
	
	private final AssetService service;
	
	public AssetController(AssetService service) {
		this.service = service;
	}
	
	@GetMapping("/asset/list")
	public String assetList(Model model, @RequestParam(defaultValue = "1") int page, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) 
			return "redirect:/login";
		
		List<AssetHistoryDTO> list = service.getPagedMyAssetList(page, userId);
		int totalPages = service.getMyAssetTotalPages(userId);
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
		return "/asset/userAssetList";
	}
	
	@GetMapping("/asset/form")
	public String assetForm() {
		return "/asset/userAssetForm";
	}
	
	@GetMapping("/asset/extension/form")
	public String extensionForm() {
		return "/asset/extensionForm";
	}
	
}
