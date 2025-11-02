package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.AssetDisposalDTO;
import edu.example.assetmanager.service.ApprovalService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/approval")
public class ApprovalController {
	private final ApprovalService approvalService;

	@ResponseBody
	@PostMapping(value = "/approve", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> approve(@RequestBody ApprovalDTO approvalDTO, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		ApprovalDTO dto = approvalDTO;
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null)
			response.put("msg", "로그인 후 진행해주세요.");
		dto.setApproverId(userId);
		
		if (approvalService.approve(dto))
			response.put("msg", "승인 처리가 완료되었습니다.");
		else
			response.put("msg", "승인 처리에 실패하였습니다.");
		
		return ResponseEntity.ok(response);
	}
	
	@ResponseBody
	@PostMapping(value = "/reject", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> reject(@RequestBody ApprovalDTO approvalDTO, HttpSession session) {
		Map<String, Object> response = new HashMap<>();
		ApprovalDTO dto = approvalDTO;
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null)
			response.put("msg", "로그인 후 진행해주세요.");
		dto.setApproverId(userId);
			
		if (approvalService.reject(dto))
			response.put("msg", "반려 처리가 완료되었습니다.");
		else
			response.put("msg", "반려 처리에 실패하였습니다.");
		
		return ResponseEntity.ok(response);
	}

}
