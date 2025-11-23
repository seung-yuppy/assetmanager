package edu.example.assetmanager.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import edu.example.assetmanager.domain.ApprovalDTO;
@Mapper
public interface ApprovalDAO {
	public ApprovalDTO getApprovalById(int id);
	public boolean insertApproval(ApprovalDTO approvalDTO);
	public boolean rejectApproval(ApprovalDTO approvalDTO);
	public boolean approveApproval(ApprovalDTO approvalDTO);
	public boolean updateApproval(ApprovalDTO approvalDTO);
	public boolean cancelApproval(int id);
}
