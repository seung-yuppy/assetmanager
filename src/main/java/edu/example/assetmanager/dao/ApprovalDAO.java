package edu.example.assetmanager.dao;

import org.apache.ibatis.annotations.Mapper;

import edu.example.assetmanager.domain.ApprovalDTO;
@Mapper
public interface ApprovalDAO {
	// Approval 요청
	public boolean insertApproval(ApprovalDTO approvalDTO);
	public ApprovalDTO getApprovalById(int id);
}
