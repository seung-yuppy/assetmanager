package edu.example.assetmanager.service;

import org.springframework.stereotype.Service;

import edu.example.assetmanager.dao.ApprovalDAO;
import edu.example.assetmanager.domain.ApprovalStatus;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalService{
	private final ApprovalDAO approvalDAO;
	public boolean approve(Long id, String status) {
		ApprovalStatus current = ApprovalStatus.valueOf(status); // 문자열 to Enum
		ApprovalStatus[] values = ApprovalStatus.values();
		int nextIndex = current.ordinal() + 1;
		String nextName = (nextIndex < values.length) ? values[nextIndex].name() : null;
		return approvalDAO.updateApproval(id, nextName);
	}
	public boolean reject(Long id, String status) {
		ApprovalStatus current = ApprovalStatus.valueOf(status); // 문자열 to Enum
		ApprovalStatus[] values = ApprovalStatus.values();
		int nextIndex = current.ordinal() + 3;
		String nextName = (nextIndex < values.length) ? values[nextIndex].name() : null;
		return approvalDAO.updateApproval(id, nextName);
		
	}

}
