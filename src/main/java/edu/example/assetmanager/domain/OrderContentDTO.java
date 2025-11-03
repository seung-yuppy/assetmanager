package edu.example.assetmanager.domain;

import lombok.Data;

@Data
public class OrderContentDTO {
	private Long id;
	private Long orderId;
	private Long categoryId;
	private String categoryName;
	private String itemName;
	private int price;
	private int count;
	private boolean isRegistered;
}
