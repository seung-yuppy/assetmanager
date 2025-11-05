package edu.example.assetmanager.service;

import java.util.List;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.NotificationDAO;
import edu.example.assetmanager.domain.NotificationDTO;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.RentDTO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
	private final NotificationDAO notificationDAO;
	
	public boolean insert(NotificationDTO notificationDTO) {
		return notificationDAO.insert(notificationDTO);
	}
	
	// 추후 제거 : OrderDTO에 의존성이 생김 -> 결합도 상승
	public boolean insertRejectNotice(OrderDTO orderDTO) {
		NotificationDTO notificationDTO = new NotificationDTO();
		notificationDTO.setTargetId(orderDTO.getId());
		notificationDTO.setTargetType("order");
		notificationDTO.setUserId(orderDTO.getUserId());
		String msg = "구매 요청(" +  orderDTO.getTitle() + ")이 반려되었습니다.";
		notificationDTO.setMessage(msg);
		return insert(notificationDTO);
	}
	
	public boolean insertRejectNotice(RentDTO rentDTO) {
		NotificationDTO notificationDTO = new NotificationDTO();
		notificationDTO.setTargetId(rentDTO.getId().intValue());
		notificationDTO.setTargetType("rent");
		notificationDTO.setUserId(rentDTO.getUserId());
		String msg = "반출 요청(" +  rentDTO.getTitle() + ")이 반려되었습니다.";
		notificationDTO.setMessage(msg);
		return insert(notificationDTO);
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
	
}
