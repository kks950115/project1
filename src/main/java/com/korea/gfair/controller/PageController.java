package com.korea.gfair.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.ApplyDTO;
import com.korea.gfair.domain.ApplyVO;
import com.korea.gfair.domain.BoothVO;
import com.korea.gfair.domain.ExhibitionVO;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.domain.PaymentVO;
import com.korea.gfair.service.ApplyService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@RequestMapping("/page/")
@Controller
public class PageController {
	
	
	//===교통	
	@GetMapping("traffic")
	public void traffic() {
		
	}
	
	//===편의시설
	@GetMapping("facilities")
	public void facilities() {
		
	}
	//==지페어 소개 
	@GetMapping("intro")
	public void intro() {
		
	}
	//===연혁
	@GetMapping("history")
	public void history() {
		
	}
	
	
	
}//end class
