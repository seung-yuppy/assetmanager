package edu.example.assetmanager.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserParamDTO {
	private int page = 1;
	private int size = 10;
	private int offset;
	private int deptId;	// 필터링
	private String keyword; // 검색필터링
}
