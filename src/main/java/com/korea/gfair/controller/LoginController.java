package com.korea.gfair.controller;

import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.korea.gfair.domain.LoginDTO;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.interceptor.LoginInterceptor;
import com.korea.gfair.service.MemberService;
import com.korea.gfair.util.UUIDGenerator;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@NoArgsConstructor
@Log4j2

@RequestMapping("/login/")
@Controller
public class LoginController {

	@Setter(onMethod_=@Autowired)
	private MemberService service;

	
	@GetMapping("login")
	public void login() {
		
	}
	
	@PostMapping("loginPost")
	public void loginPost(LoginDTO dto, Model model) throws Exception{
		log.debug("loginPost(dto) invoked");
		
		dto.setMemberpw(UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw()));
		log.info("##DIGEST ==> " + UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw()));
		
		Objects.requireNonNull(this.service);
		// 1. 전송파라미터에 해당되는 사용자가 있는지 확인 
		MemberVO user = this.service.login(dto);
		
		
		if(user != null) {//로그인이 성공했다면!
			//jsp에서 이용
			model.addAttribute(LoginInterceptor.loginKey,user);
			
		}//if
		
	}//loginPost
	
	
	
	@GetMapping("logout")
	public String logout(HttpSession session) {
		log.debug("loginPost({}) invoked",session);
		
		MemberVO user = (MemberVO) session.getAttribute(LoginInterceptor.loginKey);
		log.info("\t+user: {}",user);
		
		session.invalidate();
		
		
		return "redirect:/login/login";
	}//logout
}//end class
