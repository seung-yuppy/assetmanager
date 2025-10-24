package edu.example.assetmanager.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDTO {
	private int id;
	private int approvalId;
	private int userId;
	private int totalPrice;
	private String title;
	private String username;
	private String requestMsg;
	private ApprovalStatus status;
	private Date orderDate;
	
	public void setStatus(String status) {
		this.status = ApprovalStatus.from(status);
	}
}

