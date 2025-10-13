package edu.example.assetmanager.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.example.assetmanager.dao.UserDAO;
import edu.example.assetmanager.domain.UserDTO;

@Controller
public class UserController {
	
	@Autowired
	UserDAO dao;

	@GetMapping("/login")
	public String s1 () {
		return "user/login";
	}
	
	@GetMapping("/join")
	public String s2() {
		return "user/join";
	}
	
	@PostMapping("/join")
	public String s3(
	        @RequestParam("empno") String empno,
	        @RequestParam("password") String password,
	        @RequestParam("username") String username,
	        @RequestParam("email") String email,
	        @RequestParam("phone") String phone,
	        @RequestParam("department") String department,
	        @RequestParam("role") String role) {
		
	        int departmentId = mapDepartmentNameToId(department);
	        
	        UserDTO dto = new UserDTO();
	        dto.setEmpNo(empno);
	        dto.setPassword(password);
	        dto.setUsername(username);
	        dto.setEmail(email);
	        dto.setPhone(phone);
	        dto.setDepartmentId(departmentId);
	        dto.setRole(role);
	        
			if (dao.userJoin(dto))
				return "redirect:/login";
			else 
				return "redirect:/join";
	}
	
    private int mapDepartmentNameToId(String departmentValue) {
        switch (departmentValue) {
            case "management":
                return 1;
            case "development":
                return 2;
            case "security":
                return 3;
            case "hr":
                return 4;
            case "marketing":
                return 5;
        }
		return 0;
    }
}
