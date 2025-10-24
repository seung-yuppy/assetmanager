package edu.example.assetmanager.domain;

import java.util.Date;

public class ApprovalDTO {
	private int id;
	private int approverId;
	private int managerId;
	private Date firstApprovalDate;
	private Date lastApprovalDate;
	private Date rejectDate;
	private String rejectReason;
	private String status;
}
