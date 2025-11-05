package edu.example.assetmanager.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class AssetReturnDTO {
	private int id;
	private int userId;
	private int approvalId;
	private int assetId;
	private Date requestDate;
	private Date returnDate;
	private int isReturn;
	private String assetName;
	private String deptName;
	private String username; 
	private String categoryName;
	private String serialNumber;
	private String spec;
	private String location;
	private Date registerDate;
	private String email;
	private String phone;
	private String position;
	private String deptAddress;
	private Date createDate;
	private Long deadLine;
}
