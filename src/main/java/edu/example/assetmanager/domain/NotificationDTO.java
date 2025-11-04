package edu.example.assetmanager.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NotificationDTO {
	private int id;
	private int userId;
	private int targetId;
	private String targetType;
	private String message;
	private Date createDate;
	private boolean isRead;
	
}
