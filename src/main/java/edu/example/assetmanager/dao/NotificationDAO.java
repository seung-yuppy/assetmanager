package edu.example.assetmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.NotificationDTO;

@Mapper
public interface NotificationDAO {
	public boolean insert(NotificationDTO notificationDTO);
	public List<NotificationDTO> getListByUserId(@Param("userId") int id, @Param("offset") int offset);
	public int getUnreadCountByUserId(int id);
	public boolean readById(int id);
}
