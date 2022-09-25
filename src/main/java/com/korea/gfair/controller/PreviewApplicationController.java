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

import com.korea.gfair.domain.ExhibitionVO;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.domain.PreApplicationDTO;
import com.korea.gfair.domain.PreApplicationVO2;
import com.korea.gfair.service.EventBoardService;
import com.korea.gfair.service.ExhibitionService;
import com.korea.gfair.service.MemberService;
import com.korea.gfair.service.PreApplicationService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2


@Controller
@RequestMapping("/pre/")
public class PreviewApplicationController {
	
	
	//Service 주입
	@Setter(onMethod_= {@Autowired})
	private PreApplicationService preAppService;
	
	@Setter(onMethod_= {@Autowired})
	private MemberService memberService;
	
	@Setter(onMethod_= {@Autowired})
	private ExhibitionService exhibitionService;
	
	@Setter(onMethod_= {@Autowired})
	private EventBoardService eventBoardService;
	
	
//	뷰만 올려주는 맵핑
	@GetMapping("guide")
	public void view() {
		
	}//view
	
	
	
	@GetMapping("sample")
	public String sample(RedirectAttributes rttrs, HttpServletRequest req) {
		log.debug("sample(rttrs, req) invoked.");
		
		MemberDTO dto = new MemberDTO();
//		dto.setMemberid("dannywon91");
//		dto.setMemberpw("dnjstmdeo1234");
		
		dto.setMemberid("Blognation");
		dto.setMemberpw("8uuaPm1");
		
		MemberVO member = this.memberService.get(dto.getMemberid());
		
		HttpSession session = req.getSession();
		
		session.setAttribute("__LOGIN__", member);
		
		return "redirect:/index";
	}//sample()
	
	
	@GetMapping("register")
	public void registerui(Model model) {
		log.debug("registerui(memberVO, model) invoked.");
//		log.info("\t+ memberVO: {}",  memberVO);
		
		List<ExhibitionVO> lists = this.exhibitionService.getList();
		
		
//		memberVO = this.memberService.get(memberVO.getMemberid());
		
		
		model.addAttribute("__EXHI__", lists);
//		model.addAttribute("member", memberVO);
	}//registerui()
	
	
	
	@PostMapping("registerAction")
	public String registerAction(PreApplicationDTO applications, RedirectAttributes rttrs) {
		log.debug("register(applications, rttrs) invoked.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		log.info("\t+ applications: {}", applications);
		
		this.preAppService.register(applications);
		
		return "redirect:/pre/verify";
	}//register()
	
	
	@GetMapping("verify")
	public void verify(Model model, HttpSession session) {
		log.debug("verify() invoked.");
		MemberVO memberVO = (MemberVO)session.getAttribute("__LOGIN__");
		
		List<PreApplicationVO2> app = this.preAppService.getList(memberVO.getMemberid());
		
		
		
		List<ExhibitionVO> lists = this.exhibitionService.getList();
		
		model.addAttribute("__APP__", app);
		model.addAttribute("__EXHI__", lists);
	}//verify()
	
	@GetMapping("agreement")
	public void agreementui() {
		log.debug("agreementui() invoked.");
		
	}//agreementui()
	
}//end class
