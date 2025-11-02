package edu.example.assetmanager.dao;

import org.apache.ibatis.annotations.Mapper;

import edu.example.assetmanager.domain.ChatDTO;

@Mapper
public interface ChatDAO {
	public ChatDTO showMsg(int id);
}
