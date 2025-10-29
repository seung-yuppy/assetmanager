package edu.example.assetmanager.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class ApprovalDTO {
	private Long id;
	private int approverId;
	private String approverName;
	private String approverDept;
	private int managerId;
	private String managerName;
	private String managerDept;
	private Date firstApprovalDate;
	private Date lastApprovalDate;
	private Date rejectDate;
	private String rejectReason;
	private ApprovalStatus status;
	
	public void setStatus(String status) {
		this.status = ApprovalStatus.from(status);
	}
}
