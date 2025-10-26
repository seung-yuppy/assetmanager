package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.CategoryDAO;
import edu.example.assetmanager.domain.CategoryDTO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CategoryService {
	private final CategoryDAO categoryDAO;
	
	public List<CategoryDTO> getCategories(){
		return categoryDAO.getCategories();
	}
	
	public CategoryDTO getCategoryById(int id) {
		return categoryDAO.getCategoryById(id);
	}

}
