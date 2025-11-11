package edu.example.assetmanager.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.StatsDAO;
import edu.example.assetmanager.domain.stats.CategoryData;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class StatsService {
	private final StatsDAO statsDAO;
	public List<CategoryData> getCategoryData(int year) {
		LocalDate start = LocalDate.of(year, 1, 1);
	    LocalDate end = start.plusYears(1);
		return statsDAO.getCategoryData(java.sql.Date.valueOf(start), java.sql.Date.valueOf(end));
	}
}
