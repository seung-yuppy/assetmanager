package edu.example.assetmanager.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.assetmanager.domain.ItemDTO;
import edu.example.assetmanager.domain.ItemListDTO;
import edu.example.assetmanager.service.ItemService;

@RequestMapping("/admin")
@Controller
public class AdminItemController {
	
	@Autowired
	ItemService service;
	
	@GetMapping("/item/list")
	public String itemList(Model model, @RequestParam(defaultValue = "1") int page) {
		List<ItemDTO> list = service.getPagedList(page);
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
		
		return "/admin/adminItemList";
	}
	
	@GetMapping("/item/form")
	public String form() {
		return "/admin/adminItemForm";
	}
	
	@PostMapping("/item/add")
	public String i4(ItemListDTO dto) {
		if (service.addItem(dto.getItems()))
			return "redirect:/admin/item/list";
		else
			return "redirect:/admin/item/form"; 
	}
}
