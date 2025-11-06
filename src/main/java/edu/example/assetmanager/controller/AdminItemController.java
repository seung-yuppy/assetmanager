package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.example.assetmanager.domain.ItemDTO;
import edu.example.assetmanager.domain.ItemListDTO;
import edu.example.assetmanager.domain.ItemParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.service.ItemService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/admin")
@Controller
public class AdminItemController {
	
	private final ItemService service;
	
	@GetMapping("/item/list")
	public String itemList(Model model, ItemParamDTO dto) {
		PageResponseDTO<ItemDTO> list = service.listAll(dto);
		model.addAttribute("response", list);
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
	
	@PostMapping("/item/remove")
	public String i5(int id) {
		service.removeItem(id);
		return "redirect:/admin/item/list";
	}
}
