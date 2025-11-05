package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.AssetReturnDTO;
import edu.example.assetmanager.service.RentService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/return")
public class AdminReturnController {

	private final RentService rentService;
	

	@GetMapping("/list")
	public String adminReturnlist(Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/login";
		}
		List<AssetReturnDTO> assetReturnDTO = rentService.assetReturn(); 
		
		System.out.println("assetReturnDTO 나오니??" +assetReturnDTO);
		model.addAttribute("returnList",assetReturnDTO);
		
		return "/admin/adminReturnList";
	}

	@GetMapping("/detail/{id}")
	public String adminReturnDetail(@PathVariable int id, Model model) {
		AssetReturnDTO assetReturnDTO = rentService.getReturnAsset(id);
		System.out.println("assetReturnDTO 여긴 컨트롤러~~ "+assetReturnDTO);
		System.out.println("마감일 언제냐???" + assetReturnDTO.getDeadLine());
		model.addAttribute("returnDetail",assetReturnDTO);
		
		return "/admin/adminReturnDetail";
	}
	
	@ResponseBody
	@PostMapping(value = "/confirm", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> rentReturn(@RequestBody AssetReturnDTO assetReturnDTO, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null)
			response.put("msg", "로그인 후 진행해주세요.");
		
		assetReturnDTO.setUserId(userId);
		
		if(rentService.adminReturnConfirm(assetReturnDTO))
			response.put("msg", "반납에 성공하였습니다.");
		else
			response.put("msg", "반납에 실패하였습니다.");
		
		return ResponseEntity.ok(response);
	}
	


}
