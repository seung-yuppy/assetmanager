package edu.example.assetmanager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.example.assetmanager.domain.AssetHistoryUserShowDTO;
import edu.example.assetmanager.domain.UserDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.AssetService;
import edu.example.assetmanager.service.UserService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class UserController {
	
	private final UserService service;
	private final AssetService assetService;

	@GetMapping("/login")
	public String s1 () {
		return "user/login";
	}
	
	@GetMapping("/join")
	public String s2() {
		return "user/join";
	}
	
	@GetMapping("/mypage")
	public String s4(HttpSession session, Model model) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) 
			return "redirect:/login";

		UserInfoDTO dto = service.getUser(userId);
		List<AssetHistoryUserShowDTO> list = assetService.getUserAssetHistory(userId);
		session.setAttribute("userInfo", dto);
		model.addAttribute("list", list);
		return "user/myPage";
	}
	
	// 회원가입
	@PostMapping("/join")
	public String userJoin(UserDTO dto) {
		boolean isJoin = service.join(dto);
		
		if (isJoin)
			return "user/login";
		else 
			return "redirect:/join";
	}
	
	// 사번 중복체크
	@ResponseBody
	@PostMapping(value = "/check/empno", produces = "application/json; charset=utf-8")
	public ResponseEntity<Map<String, Object>> checkEmpno(@RequestBody Map<String, String> requestBody) {
		Map<String, Object> response = new HashMap<>();
		String empNo = requestBody.get("empNo");
		
		if (service.isDupEmpno(empNo))
			response.put("isDup", "사용 가능한 사번입니다.");
		else
			response.put("isDup", "이미 사용중인 사번입니다.");
		
		return ResponseEntity.ok(response);
	}
	
	// 로그인
	@PostMapping("/login")
	public String userJoin(String empNo, String password, HttpSession session, RedirectAttributes rattr) {
		if (service.login(empNo, password, session)) {
			Integer userId = (Integer) session.getAttribute("userId");
			if (userId != null) {
				UserInfoDTO dto = service.getUser(userId);
				String role = dto.getRole();
				if (role.equals("admin")) {
					rattr.addFlashAttribute("loginAdminSuccess", "로그인에 성공하였습니다.");
					return "redirect:/login";
				} else {
					rattr.addFlashAttribute("loginUserSuccess", "로그인에 성공하였습니다.");
					return "redirect:/login";
				}		
			} else {
				rattr.addFlashAttribute("loginError", "로그인 세션 정보를 가져오는데 오류가 발생했습니다.");
				return "redirect:/login";
			}
		} else {
			rattr.addFlashAttribute("loginError", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "redirect:/login";
		}
	}
	
	// 로그아웃
	@PostMapping("/logout")
	public String logOut(HttpSession session) {
		session.removeAttribute("userId");
		session.invalidate();
		return "redirect:/login";
	}
	
	// 마이페이지 프로필 이미지 수정
	@PostMapping("/change/userinfo")
	public String changeImage(HttpSession session, 
			@RequestParam(value = "profileImage", required = false) MultipartFile profileFile, 
			@RequestParam("email") String email,
			@RequestParam("phone") String phone) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null)
	        return "redirect:/login";
	    
		try {
	        UserDTO dto = new UserDTO();
	        dto.setId(userId);
	        dto.setEmail(email);
	        dto.setPhone(phone);
	        
	        if (profileFile != null && !profileFile.isEmpty()) {
	            dto.setProfileImage(profileFile.getBytes());
	        }
	        
	        if (service.changeUserInfo(dto)) 
	            return "redirect:/mypage";
	        else 
	            return "redirect:/login";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/login";
	    }
	}
	
	// 마이페이지
	@GetMapping("/mypage/edit")
	public String us1(HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) 
			return "redirect:/login";
		
		UserInfoDTO dto = service.getUser(userId);
		session.setAttribute("userInfo", dto);
		return "user/editMyPage";
	}
	
}
