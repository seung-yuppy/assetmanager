package edu.example.assetmanager.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderDTO {
	private int id;
	private int approvalId;
	private int userId;
	private String username;
	private String requestMsg;
	private Date orderDate;
}
