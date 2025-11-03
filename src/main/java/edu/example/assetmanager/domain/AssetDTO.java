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
public class AssetDTO {
	private int id;
	private int userId;
	private int categoryId;
	private String categoryName;
	private String assetName;
	private String spec;
	private String serialNumber;
	private Date registerDate;
	private String location;
	private int isValid;
	private String status;
	private String username;
	private String deptName;
	private String deptAddress;
	private String email;
	private String phone;
	private String position;
	private int count;
}
