package edu.example.assetmanager.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderDetailRESP {
	private OrderDTO orderDto;
	private ApprovalDTO approvalDTO;
	private List<OrderContentDTO> products;
	private ApproverInfoDTO approverInfoDTO;
}
