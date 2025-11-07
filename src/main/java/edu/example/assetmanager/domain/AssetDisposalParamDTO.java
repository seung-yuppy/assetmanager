package edu.example.assetmanager.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AssetDisposalParamDTO extends PageParamDTO {
	private int categoryId;
	private String keyword;
}
