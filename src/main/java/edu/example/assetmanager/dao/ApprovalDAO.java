package edu.example.assetmanager.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.ApprovalDTO;
@Mapper
public interface ApprovalDAO {
	// Approval 요청
	public boolean insertApproval(ApprovalDTO approvalDTO);
	public ApprovalDTO getApprovalById(int id);
	public boolean rejectApproval(ApprovalDTO approvalDTO);
	public boolean updateApproval(@Param("id")Long id, @Param("status") String status);
}
