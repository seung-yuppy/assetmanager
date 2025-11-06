package edu.example.assetmanager.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemParamDTO {
	private int page = 1;
	private int size = 10;
	private int offset;
	private int categoryId;
	private String keyword;
}
