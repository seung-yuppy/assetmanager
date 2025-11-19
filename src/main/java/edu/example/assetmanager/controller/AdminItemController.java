package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@ResponseBody
	@PostMapping(value = "/item/delete", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> a7(@RequestBody Map<String, Integer> requestBody) {
		Map<String, Object> response = new HashMap<>();
		int assetId = requestBody.get("id");
		
		if (service.removeItem(assetId))
			response.put("msg", "권장 제품을 삭제하였습니다.");
		else
			response.put("msg", "권장 제품 삭제에 실패하였습니다.");
		
		return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@GetMapping(value = "/item/{id}", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> a8(@PathVariable("id") int id) {
		Map<String, Object> response = new HashMap<>();
		ItemDTO dto = service.getItem(id);
		response.put("item", dto);
		return ResponseEntity.ok(response);
	}
}
