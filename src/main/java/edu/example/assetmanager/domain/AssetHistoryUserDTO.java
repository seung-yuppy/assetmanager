package edu.example.assetmanager.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AssetHistoryUserDTO {
	private int id;
	private int assetId;
	private String username;
	private String empNo;
	private String role;
	private String deptName;
	private String assetName;
	private String categoryName;
	private String serialNumber;
	private Date createDate;
	private String status;
}
