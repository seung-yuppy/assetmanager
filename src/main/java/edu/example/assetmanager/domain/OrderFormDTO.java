package edu.example.assetmanager.domain;

import java.util.List;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderFormDTO {
	private Long id;
	private int userId;
	private String username;
	private String position;
	private int approverId;
	private int managerId;
	private Long approvalId;
	private String requestMsg;
	private String title;
	private List<OrderContentDTO> products;
}
