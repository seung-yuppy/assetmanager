package edu.example.assetmanager.domain;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class NotificationDTO {
	private int id;
	private int userId;
	private int targetId;
	private String targetType;
	private String message;
	private Date createDate;
	private boolean isRead;
	
	public NotificationDTO(String targetType, int targetId, String message) {
		this.targetId = targetId;
		this.targetType = targetType;
		this.message = message;
	}
	
}
