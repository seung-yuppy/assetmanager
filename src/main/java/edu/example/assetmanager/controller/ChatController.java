package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.ChatDTO;
import edu.example.assetmanager.service.ChatService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class ChatController {
	private final ChatService chatService;
	
	@ResponseBody
	@PostMapping(value = "/chat", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> c1(@RequestBody Map<String, Integer> requestBody) {
		Map<String, Object> response = new HashMap<>();
		int id = requestBody.get("id");
		ChatDTO dto = chatService.getChatAnswer(id);
		
		if (dto != null) 
			response.put("msg", dto.getAnswer());
		else
			response.put("msg", "숫자를 다시 입력해주세요.(1 또는 2)");
		
		return ResponseEntity.ok(response);
	}
}	
