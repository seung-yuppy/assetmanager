package edu.example.assetmanager.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderParamDTO {
	private int page = 1;
	private int size = 10;
	private int offset; // sql의 offset 값
	private String status;
	private String keyword;
	private String order;
}
