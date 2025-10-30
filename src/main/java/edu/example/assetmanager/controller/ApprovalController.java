package edu.example.assetmanager.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import edu.example.assetmanager.service.ApprovalService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ApprovalController {
	private final ApprovalService approvalService;
	
	@GetMapping("/approve")
	public String approve(HttpServletRequest request, Long id, String status) {
        String referer = request.getHeader("Referer");
        approvalService.approve(id, status);
        if (referer != null) {
            return "redirect:" + referer;
        } else {
            return "redirect:/assetmanager/home";
        }
	}
	
	@GetMapping("/reject")
	public String reject(HttpServletRequest request, Long id, String status) {
		String referer = request.getHeader("Referer");
		approvalService.reject(id, status);
		if (referer != null) {
			return "redirect:" + referer;
		} else {
			return "redirect:/assetmanager/home";
		}
	}

}
