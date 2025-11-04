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
public class RentListDTO {
	private Long id;      
    private String title;       
    private Date rentDate;      
    private Date returnDate;    
    private ApprovalStatus status;
    private String username;
    private String deptName;
    private int userId;
    
    public void setStatus(String status) {
		this.status = ApprovalStatus.from(status);
	}
}
