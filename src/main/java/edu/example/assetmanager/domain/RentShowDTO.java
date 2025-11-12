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
public class RentShowDTO {
	private Long rentId; 
	private int userId;
	private Date rentDate;
	private Date returnDate;
	private String requestMsg;
	private int isDelay;
}
