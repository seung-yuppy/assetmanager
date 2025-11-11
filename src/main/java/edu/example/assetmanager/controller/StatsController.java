package edu.example.assetmanager.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.stats.CategoryData;
import edu.example.assetmanager.domain.stats.DeptAmountData;
import edu.example.assetmanager.domain.stats.TotalPurchaseData;
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
	public List<CategoryData> getCategoryData(@RequestParam(required = false) String year, HttpSession session) {
		System.out.println("getCategoryData");
		int targetYear = (year != null) ? Integer.parseInt(year) : LocalDateTime.now().getYear();
		return statsService.getCategoryData(targetYear);
	}
	
	@ResponseBody
	@GetMapping(value = "/total", produces = "application/json; charset=utf-8")
	public List<TotalPurchaseData> getTotalPurchaseData(@RequestParam(required = false) String year, HttpSession session) {
		int targetYear = (year != null) ? Integer.parseInt(year) : LocalDateTime.now().getYear();
		return statsService.getTotalPurchaseData(targetYear);
	}
	
	@ResponseBody
	@GetMapping(value = "/dept", produces = "application/json; charset=utf-8")
	public List<DeptAmountData> getAmountGroupByDept(@RequestParam(required = false) String year, HttpSession session) {
		int targetYear = (year != null) ? Integer.parseInt(year) : LocalDateTime.now().getYear();
		return statsService.getAmountGroupByDept(targetYear);
	}
	
	
}
