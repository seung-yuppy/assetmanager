package edu.example.assetmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class RentContentDTO { 
	private Long id;
	private Long rentId;
	private int assetId;
	private int count;
	private String assetName;
}
