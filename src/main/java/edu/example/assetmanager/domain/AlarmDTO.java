package edu.example.assetmanager.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AlarmDTO {
	private int id;
	private int userId;
	private String alarmMsg;
	private Date createDate;
	private boolean isRead;
	
}
