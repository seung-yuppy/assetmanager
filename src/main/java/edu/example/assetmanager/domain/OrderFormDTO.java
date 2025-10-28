package edu.example.assetmanager.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class OrderFormDTO {
	private Long id;
	private int userId;
	private int approverId;
	private int managerId;
	private Long approvalId;
	private String requestMsg;
	private String title;
	private Date orderDate;
	private List<OrderContentDTO> products;
	
	public void setOrder(OrderDTO orderDto) {
		this.id = (long) orderDto.getId();
		this.userId = orderDto.getUserId();
		this.approvalId = (long) orderDto.getApprovalId();
		this.orderDate = orderDto.getOrderDate();
	}
}
