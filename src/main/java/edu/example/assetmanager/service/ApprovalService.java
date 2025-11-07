package edu.example.assetmanager.service;

import java.util.Date;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ApprovalDAO;
import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.dao.UserDAO;
import edu.example.assetmanager.domain.NotificationDTO;
import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApprovalStatus;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.RentDTO;
import edu.example.assetmanager.domain.RentListDTO;
import edu.example.assetmanager.domain.UserDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalService{
	private final ApprovalDAO approvalDAO;
	private final NotificationService notificationService;
	private final OrderService orderService;
	private final RentService rentService;
	private final UserService userService;
	
	public boolean approve(ApprovalDTO approvalDTO) {
		// status 결정
		ApprovalStatus current = approvalDTO.getStatus();
		ApprovalStatus[] values = ApprovalStatus.values();
		int nextIndex = current.ordinal() + 1;
		String nextName = (nextIndex < values.length) ? values[nextIndex].name() : null;
		approvalDTO.setStatus(nextName);
		
		// 날짜 설정
		if (current.name().equals("PENDING")) {
			approvalDTO.setFirstApprovalDate(new Date());
		}else if(current.name().equals("FIRST_APPROVAL")) {
			approvalDTO.setFinalApprovalDate(new Date());
		}
		boolean isSucceed = approvalDAO.approveApproval(approvalDTO);
		
		if(current.name().equals("FIRST_APPROVAL") && isSucceed) { //최종 승인 후 요청자에게 알림 
			return insertEmpNotification(approvalDTO, true);
		
		}else if(current.name().equals("PENDING") && isSucceed) { //1차 승인 후 manager에게 알림
			return insertManagerNotification(approvalDTO);
		}
		
		return isSucceed;
	}

	public boolean reject(ApprovalDTO approvalDTO) {
		// status 결정
		ApprovalStatus current = approvalDTO.getStatus();
		ApprovalStatus[] values = ApprovalStatus.values();
		int nextIndex = current.ordinal() + 3;
		String nextName = (nextIndex < values.length) ? values[nextIndex].name() : null;
		approvalDTO.setStatus(nextName);
		approvalDTO.setRejectDate(new Date());
		
		boolean isSucceed = approvalDAO.rejectApproval(approvalDTO);
		
		// 알림 생성 
		if(isSucceed){
			return insertEmpNotification(approvalDTO, false);
		}
		return isSucceed;
	}
	
	private boolean insertEmpNotification(ApprovalDTO approvalDTO, boolean isApproved){
		int approvalId = approvalDTO.getId().intValue();
		OrderDTO orderDTO =  orderService.getOrderByApprovalId(approvalId);
		NotificationDTO notificationDTO = new NotificationDTO();
		if (orderDTO != null) { 
			String targetType = "order";
		    notificationDTO.setTargetId(orderDTO.getId());
		    notificationDTO.setTargetType(targetType);
		    notificationDTO.setUserId(orderDTO.getUserId());
		    notificationDTO.setMessage(buildMessage(targetType, orderDTO.getTitle(),isApproved));
		    
		} else { 
			String targetType = "rent";
		    RentListDTO rentListDTO = rentService.getRentByApprovalId(approvalId);
		    notificationDTO.setTargetId(rentListDTO.getId().intValue());
		    notificationDTO.setTargetType(targetType);
		    notificationDTO.setUserId(rentListDTO.getUserId());
		    notificationDTO.setMessage(buildMessage(targetType, rentListDTO.getTitle(), isApproved));
		}
		return notificationService.insert(notificationDTO);
	}
	
	private boolean insertManagerNotification(ApprovalDTO approvalDTO) {
		int approvalId = approvalDTO.getId().intValue();
		OrderDTO orderDTO =  orderService.getOrderByApprovalId(approvalId);
		NotificationDTO notificationDTO = new NotificationDTO();
		if (orderDTO != null) {
			String targetType = "order";
		    notificationDTO.setTargetId(orderDTO.getId());
		    notificationDTO.setTargetType(targetType);
		    notificationDTO.setUserId(approvalDTO.getManagerId());
		    UserInfoDTO user = userService.getUser(orderDTO.getUserId());
			String msg = String.format("새 구매 요청(%s %s) : %s", user.getUsername(), user.getPosition(), orderDTO.getTitle());
		    notificationDTO.setMessage(msg);
		    
		} else { 
			String targetType = "rent";
		    RentListDTO rentListDTO = rentService.getRentByApprovalId(approvalId);
		    UserInfoDTO user = userService.getUser(rentListDTO.getUserId());
		    notificationDTO.setTargetId(rentListDTO.getId().intValue());
		    notificationDTO.setTargetType(targetType);
		    notificationDTO.setUserId(approvalDTO.getManagerId());
			String msg = String.format("새 반출 요청(%s %s) : %s", user.getUsername(), user.getPosition(), rentListDTO.getTitle());
		    notificationDTO.setMessage(msg);
		}
		return notificationService.insert(notificationDTO);
	}
	

	private String buildMessage(String targetType, String title, boolean approved) {
	    String action; // 요청 종류
	    switch (targetType) {
	        case "order":
	            action = "구매 요청";
	            break;	
	        case "rent":
	            action = "반출 요청";
	            break;
	        default:
	            action = "요청";
	    }

	    if (approved) {
	        return action + "(" + title + ")이 승인되었습니다. 수령 후 자산을 등록하세요.";
	    } else {
	        return action + "(" + title + ")이 반려되었습니다.";
	    }
	}

}
