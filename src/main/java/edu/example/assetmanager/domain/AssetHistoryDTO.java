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
public class AssetHistoryDTO {
	private int id;
	private int userId;
	private String role;
	private String assetName;
	private String categoryName;
	private String serialNumber;
	private Date createDate;
	private Date returnDate;
}
