package edu.example.assetmanager.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.stats.CategoryData;

@Mapper
public interface StatsDAO {
	public List<CategoryData> getCategoryData(@Param("startDate") Date startDate, @Param ("endDate") Date endDate);
}
