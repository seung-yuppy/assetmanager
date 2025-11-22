package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.NotificationSseManager;
import edu.example.assetmanager.dao.NotificationDAO;
import edu.example.assetmanager.domain.NotificationDTO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.RentDTO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
	private final NotificationDAO notificationDAO;
	private final NotificationSseManager sseManager;

	public boolean insert(NotificationDTO notificationDTO) {
		boolean isInserted = notificationDAO.insert(notificationDTO);
		if(isInserted) {
			sseManager.send((long)notificationDTO.getUserId(), notificationDTO);
		}
		return isInserted;
	}
	
	public List<NotificationDTO> getListByUserId(int id, int offset){
		return notificationDAO.getListByUserId(id, offset);
	}
	
	public int getUnreadCountByUserId(int id) {
		return notificationDAO.getUnreadCountByUserId(id);
	}
	
	public boolean readById(int id) {
		return notificationDAO.readById(id);
	}
	
	public boolean readAll(int userId) {
		return notificationDAO.readAll(userId);
		
	}
	
}
