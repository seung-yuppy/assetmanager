package edu.example.assetmanager.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public String i5(int id, RedirectAttributes rattr) {
		if (service.removeItem(id)) 
			rattr.addFlashAttribute("success", "권장 제품이 삭제 되었습니다.");
		
		return "redirect:/admin/item/list";
	}
}
