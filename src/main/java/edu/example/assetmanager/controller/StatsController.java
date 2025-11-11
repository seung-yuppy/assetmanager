package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.stats.CategoryData;
import edu.example.assetmanager.service.StatsService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/stats")
public class StatsController {
	private final StatsService statsService;
	
	@GetMapping
	public String home() {
		return "stats/adminStats";
	}
	
	@ResponseBody
	@GetMapping(value = "/category", produces = "application/json; charset=utf-8")
	public List<CategoryData> getCategoryData(int year, HttpSession session) {
		return statsService.getCategoryData(year);
	}
	
	
}
