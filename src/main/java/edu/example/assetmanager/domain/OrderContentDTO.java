package edu.example.assetmanager.domain;

import lombok.Data;

@Data
public class OrderContentDTO {
	private Long id;
	private Long orderId;
	private String category;
	private String itemName;
	private int price;
	private int count;
}
