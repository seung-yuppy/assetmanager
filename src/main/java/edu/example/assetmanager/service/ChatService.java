package edu.example.assetmanager.service;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ChatDAO;
import edu.example.assetmanager.domain.ChatDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ChatService {
	private final ChatDAO chatDao;
	
	public ChatDTO getChatAnswer(int id) {
		return chatDao.showMsg(id);
	}
}
