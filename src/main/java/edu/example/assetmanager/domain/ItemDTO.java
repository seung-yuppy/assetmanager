package edu.example.assetmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ItemDTO {
	private int id;
	private int categoryId;
	private String categoryName;
	private String itemName;
	private int price;
	private String seller;
	private String maker;
	private String spec;
}
