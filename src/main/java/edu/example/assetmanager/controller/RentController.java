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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApproverInfoDTO;
import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetHistoryDTO;
import edu.example.assetmanager.domain.RentContentDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.domain.RentShowDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.AssetService;
import edu.example.assetmanager.service.RentService;
import edu.example.assetmanager.service.UserService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/rent")
@Controller
public class RentController {

	private final RentService rentService;
	private final UserService userService;
	private final AssetService assetService;

	@GetMapping("/form")
	public String requestForm(Model model, HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");	
		if(userId==null) {
			return "redirect:/login";
		}
		UserInfoDTO userInfo= userService.getUser(userId);
		List<UserInfoDTO> admin = rentService.findByAdminUser();
		List<UserInfoDTO> manager = rentService.findByManagerUser();
		model.addAttribute("admin", admin);
		model.addAttribute("manager", manager);
		session.setAttribute("user", userInfo);
		
		return "/rent/rentForm";
	}
	// categoryId값으로 제품 목록 조회
	@GetMapping("/assets")
	@ResponseBody 
	public List<AssetDTO> getAssetsByCategory(@RequestParam("categoryId") int categoryId) {
		List<AssetDTO> assets = rentService.findByAsset(categoryId);
		return assets;
	}
	
	// approvalId, managerId를 insert하기, rent insert 하기
	@PostMapping("/approval")
	public String approval(ApprovalDTO approvalDTO,RentDTO rentDTO, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if(userId==null) {
			return "redirect:/login"; 
		} else {
			if(rentService.insertApproval(approvalDTO,rentDTO,userId)) {
				// 요청 성공	
				return "redirect:/rent/list";
			}else {
				// 요청 실패
				return "redirect:/rent/form";
			}				
		}	
	}
	
	@GetMapping("/list")
	public String list(Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");	
		if(userId==null) {
			return "redirect:/login"; 
		}
		List<RentListDTO> rentList = rentService.findRentListByUserId(userId);
		model.addAttribute("rentList",rentList);
		
		return "/rent/rentList";
	}

	@GetMapping("/detail/{id}") 
	public String rentList(@PathVariable Long id, HttpSession session, Model model) {
		Integer userId =(Integer)session.getAttribute("userId");
		System.out.println("userid는 " +userId);
		ApproverInfoDTO approverInfoDTO = rentService.getRentApprovalDetail(id);
		RentShowDTO rentDTO = rentService.getRentDetail(id);
		List<RentContentDTO> rentContentDTO = rentService.getRentContentDetail(id);
		RentDTO dto = rentService.getRentDTO(userId, id);
		ApprovalDTO approvalDTO = rentService.getApprovalByRentId(id);
		System.out.println(dto.getId());
		System.out.println(dto.getUserId());
		
		model.addAttribute("empInfo", approverInfoDTO);
		model.addAttribute("rent", rentDTO);
		model.addAttribute("items",rentContentDTO);
		model.addAttribute("approval", approvalDTO);
		model.addAttribute("rentdto", dto);

		return "/rent/rentDetail";
	}
	 
	@ResponseBody
	@PostMapping(value = "/register/item", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> registerItem(@RequestBody AssetHistoryDTO assetHistoryDTO,  HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		Integer userId = (Integer) session.getAttribute("userId");
		System.out.println("userId???  " +  userId);
		assetHistoryDTO.setUserId(userId);
		
		if(assetService.registerAssetItem(assetHistoryDTO)) {
			response.put("msg", "자산 등록에 성공하였습니다.");
		}else {
			response.put("msg", "일련번호가 일치하지 않거나 오류가 발생했습니다.");
		}
		
	    return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@GetMapping(value = "/cancel", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> cancelRent(int id, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null)
			response.put("msg", "로그인 후 진행해주세요.");
		
		if (rentService.cancelRent(id))
			response.put("msg", "요청 취소가 완료되었습니다.");
		else
			response.put("msg", "요청 취소에 실패하였습니다.");
		
		return ResponseEntity.ok(response);
	}
}
