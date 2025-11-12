package edu.example.assetmanager.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AssetParamDTO extends PageParamDTO {
	private int categoryId;
	private String keyword;
	private String status;
}
