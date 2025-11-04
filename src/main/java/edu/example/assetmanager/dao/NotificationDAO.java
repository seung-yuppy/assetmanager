package edu.example.assetmanager.dao;

import org.apache.ibatis.annotations.Mapper;

import edu.example.assetmanager.domain.NotificationDTO;

@Mapper
public interface NotificationDAO {
	public boolean insert(NotificationDTO notificationDTO);
}
