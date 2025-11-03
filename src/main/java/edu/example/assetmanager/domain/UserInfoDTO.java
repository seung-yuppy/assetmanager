package edu.example.assetmanager.domain;

import java.util.Base64;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserInfoDTO {
	private int id;
	private String empNo;
	private String password;
	private String username;
	private String email;
	private String phone; 
	private String role;
	private byte[] profileImage;
	private String base64ProfileImage;
	private String deptName;
	private String deptAddress;
	private String position;
	
	public void setProfileImage(byte[] profileImage) {
	    this.profileImage = profileImage;
	    if(profileImage != null) {
	    	updateBase64ProfileImage(profileImage);
	    }
	}
	
	public void updateBase64ProfileImage(byte[] profileImage) {
		 this.base64ProfileImage = Base64.getEncoder().encodeToString(profileImage);
	}
}
