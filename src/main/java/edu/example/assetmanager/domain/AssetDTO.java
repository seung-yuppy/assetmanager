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
	private String category;
	private String assetName;
	private String spec;
	private String serialNumber;
	private Date registerDate;
	private String location;
	private int isValid;
	private String status;
}
