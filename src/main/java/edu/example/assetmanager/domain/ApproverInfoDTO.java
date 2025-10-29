package edu.example.assetmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ApproverInfoDTO {
	private UserInfoDTO userInfo;
	private UserInfoDTO approverInfo;
	private UserInfoDTO managerInfo;

}
