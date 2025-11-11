package edu.example.assetmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalAssetDTO {
	private String approvalName;
	private int approvalCount;
}
