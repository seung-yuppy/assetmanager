package edu.example.assetmanager.service;

import java.util.Date;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ApprovalDAO;
import edu.example.assetmanager.domain.ApprovalDTO;
import edu.example.assetmanager.domain.ApprovalStatus;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalService{
	private final ApprovalDAO approvalDAO;
	
	public boolean approve(ApprovalDTO approvalDTO) {
		// 상태 설정
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
		ApprovalStatus current = approvalDTO.getStatus();
		ApprovalStatus[] values = ApprovalStatus.values();
		int nextIndex = current.ordinal() + 3;
		String nextName = (nextIndex < values.length) ? values[nextIndex].name() : null;
		approvalDTO.setStatus(nextName);
		approvalDTO.setRejectDate(new Date());
		return approvalDAO.rejectApproval(approvalDTO);
	}

}
