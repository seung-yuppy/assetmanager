package edu.example.assetmanager.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class RegisterDTO {
	private Long rentId;
    private String serialNumber;
    private int rentUserId;
    private boolean success;
    private String errorMessage;
}
