package edu.example.assetmanager.domain;

import java.util.List;

import lombok.Data;

@Data
public class OrderFormDTO {
	private Long id;
	private int userId;
	private int approvalId;
	private String firstApprover;
	private String secondApprover;
	private String requestMsg;
	private String title;
	private List<OrderContentDTO> products;
}
