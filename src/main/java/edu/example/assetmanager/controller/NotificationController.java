package edu.example.assetmanager.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.example.assetmanager.domain.NotificationDTO;
import edu.example.assetmanager.domain.UserInfoDTO;
import edu.example.assetmanager.service.AssetService;
import edu.example.assetmanager.service.NotificationService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/notification")
public class NotificationController {
	private final NotificationService notificationService;
	private final AssetService assetService;
	
	@GetMapping("/list")
	@ResponseBody
	public List<NotificationDTO> listAll(HttpSession httpSession, int offset){
		UserInfoDTO userInfo = (UserInfoDTO) httpSession.getAttribute("userInfo");
		if (userInfo != null) {
			List<NotificationDTO> list = notificationService.getListByUserId(userInfo.getId(), offset);
			return list;
		}else {
			return null;
		}
	}
	
	@GetMapping("/unread/count")
	@ResponseBody
	public int countUnreads(HttpSession httpSession){
		UserInfoDTO userInfo = (UserInfoDTO) httpSession.getAttribute("userInfo");
		if (userInfo != null) {
			int count = notificationService.getUnreadCountByUserId(userInfo.getId());
			return count;
		}else {
			return 0;
		}
	}
	
	@GetMapping("/read/{id}")
	@ResponseBody
	public boolean readById(@PathVariable int id) {
		return notificationService.readById(id);
	}
	
	@GetMapping("/return/check/{targetId}")
	@ResponseBody
	public boolean isReturned(@PathVariable("targetId") int id) {
		return assetService.isReturnedByReturnId(id);
	}
	
}
