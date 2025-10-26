package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import edu.example.assetmanager.domain.CategoryDTO;

@Mapper
public interface CategoryDAO {
	public List<CategoryDTO> getCategories();
	public CategoryDTO getCategoryById(int id);
}
