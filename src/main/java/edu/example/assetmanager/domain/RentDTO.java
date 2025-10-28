package edu.example.assetmanager.domain;

import java.util.List;

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
public class RentDTO {
	private Long id; 
	private Long approvalId;
	private String requestMsg;
	private String returnDate; 
	private List<RentContentDTO> items;
}
