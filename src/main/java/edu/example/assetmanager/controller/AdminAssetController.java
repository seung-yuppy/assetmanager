package edu.example.assetmanager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.service.AssetService;

@RequestMapping("/admin")
@Controller
public class AdminAssetController {

	@Autowired
	AssetService service;
	
	@GetMapping("/asset/list")
	public String assetList(Model model, @RequestParam(defaultValue = "1") int page) {
		List<AssetDTO> list = service.getPagedList(page);
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
		
		return "/admin/adminAssetList";
	}
	
	@GetMapping("/asset/detail")
	public String assetDetail() {
		return "/admin/adminAssetDetail";
	}
	
	@GetMapping("/asset/disposal")
	public String disposalList() {
		return "/admin/adminDisposalList";
	}
}
