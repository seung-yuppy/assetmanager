package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.AssetDTO;
import edu.example.assetmanager.domain.AssetDisposalDTO;
import edu.example.assetmanager.domain.AssetDisposalParamDTO;
import edu.example.assetmanager.domain.AssetHistoryUserShowDTO;
import edu.example.assetmanager.domain.AssetModifyDTO;
import edu.example.assetmanager.domain.AssetParamDTO;
import edu.example.assetmanager.domain.PageResponseDTO;
import edu.example.assetmanager.service.AssetService;

@RequestMapping("/admin")
@Controller
public class AdminAssetController {

	@Autowired
	AssetService service;
	
	// 자산 전체 리스트
	@GetMapping("/asset/list")
	public String assetList(Model model, AssetParamDTO dto) {
		PageResponseDTO<AssetDTO> list = service.listAll(dto);
		model.addAttribute("response", list);
		return "/admin/adminAssetList";
	}
	
	//  자산 상세
	@GetMapping("/asset/detail/{id}")
	public String assetDetail(Model model, @PathVariable("id") int id) {
		AssetDTO dto = service.getAsset(id);
		List<AssetHistoryUserShowDTO> assetList = service.getAssetAssetHistory(id);
		
		model.addAttribute("asset", dto);
		model.addAttribute("assetHistory", assetList);
		
		return "/admin/adminAssetDetail";
	}
	
	// 자산 수정 모달을 위한 자산 데이터
	@ResponseBody
	@GetMapping(value = "/asset/info/{id}", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> getAsset(@PathVariable("id") int id) {
		AssetDTO dto = service.getAsset(id);
		Map<String, Object> response = new HashMap<>();
		
		if (dto != null)
			response.put("result", dto);
		else
			response.put("result", "데이터가 없습니다.");
		
		return ResponseEntity.ok(response);
	}
	
	// 자산 수정 메서드
	@ResponseBody
	@PostMapping(value = "/asset/change", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> a5(@RequestBody AssetModifyDTO requestBody) {
		Map<String, Object> response = new HashMap<>();
		AssetDTO dto = requestBody.getAsset();
		
		if (service.changeAsset(dto))
			response.put("msg", "수정이 완료되었습니다.");
		else 
			response.put("msg", "수정에 실패하였습니다.");
		
		return ResponseEntity.ok(response);
	}
	
	// 자산 불용 메서드
	@ResponseBody
	@PostMapping(value = "/asset/delete", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> a6(@RequestBody AssetDisposalDTO requestBody, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		AssetDisposalDTO dto = requestBody;
		
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null)
			response.put("msg", "로그인 후 진행해주세요.");
		
		dto.setApproverId(userId);
			
		if (service.deleteAsset(dto))
			response.put("msg", "불용처리가 완료되었습니다.");
		else
			response.put("msg", "불용처리에 실패하였습니다.");
		
		return ResponseEntity.ok(response);
	}
	
	// 불용 자산 목록
	@GetMapping("/asset/disposal")
	public String disposalList(Model model, AssetDisposalParamDTO dto) {
		PageResponseDTO<AssetDisposalDTO> list = service.listDisposalAll(dto);
		model.addAttribute("response", list);
		return "/admin/adminDisposalList";
	}
}
