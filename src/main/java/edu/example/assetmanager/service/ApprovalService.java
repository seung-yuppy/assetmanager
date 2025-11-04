package edu.example.assetmanager.service;

import java.util.Date;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ApprovalDAO;
import edu.example.assetmanager.dao.RentDAO;
import edu.example.assetmanager.domain.NotificationDTO;
import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApprovalStatus;
import edu.example.assetmanager.domain.OrderDTO;
import edu.example.assetmanager.domain.RentDTO;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalService{
	private final ApprovalDAO approvalDAO;
	private final NotificationService notificationService;
	private final OrderService orderService;
	private final RentService rentService;
	
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
		return approvalDAO.approveApproval(approvalDTO);
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
		
		// insert notification
		if(isSucceed){
			int approvalId = approvalDTO.getId().intValue();
			OrderDTO orderDTO =  orderService.getOrderByApprovalId(approvalId);
			if (orderDTO != null) {
				return notificationService.insertRejectNotice(orderDTO);
			}else {
				//return notificationService.insertRejectNotice(rentDTO);
			}
		}
		return isSucceed;
	}

}
