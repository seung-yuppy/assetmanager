package edu.example.assetmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AdminInfoDTO {
	private int id;
	private String empNo;
	private String password;
	private String username;
	private String email;
	private String phone; 
	private String role;
	private byte[] profileImage;
	private String base64ProfileImage;
}
