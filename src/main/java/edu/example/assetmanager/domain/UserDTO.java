package edu.example.assetmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class UserDTO {
	private int id;
	private int departmentId;
	private String deptName;
	private String empNo;
	private String password;
	private String passwordCheck;
	private String username;
	private String email;
	private String phone; 
	private String role;
	private byte[] profileImage;
}
