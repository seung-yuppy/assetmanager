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
public class AssetDisposalDTO {
	private int id;
	private int assetId;
	private String assetName;
	private String categoryName;
	private int approverId;
	private String userName;
	private String serialNumber;
	private Date registerDate;
	private Date disposalDate;
	private String disposalReason;
	private String position;
}
