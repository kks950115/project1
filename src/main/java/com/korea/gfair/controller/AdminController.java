package com.korea.gfair.controller;

import java.net.URLEncoder;
import java.util.List;

import org.apache.logging.log4j.core.util.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.ApplyVO;
import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.domain.ReplyBoardVO;
import com.korea.gfair.service.AdminService;
import com.korea.gfair.service.ApplyService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@RequestMapping("/admin/")
@Controller
public class AdminController {

	@Autowired
	AdminService service;

	
	
//	뷰 역할만 하는 Mapping
	@GetMapping({"adminPage"})
	public void view() {
		
	}//view
	
	@GetMapping("apply")
	public void apply(Model model) throws Exception {
		log.debug("apply() invoked.");
		
		List<ApplyVO> applyList =this.service.getApplyInformation();
		
		model.addAttribute("__APPLY__", applyList);
	}//apply
	
	@PostMapping("applyUpdateAgree")
	public String applyUpdateAgree(@RequestParam("applyno") List<Integer> applynoList) throws Exception {
		log.debug("applyUpdateAgree({}) invoked.",applynoList);
		
		int affected = this.service.getPaymentCheck(applynoList);
		if(affected==0) {
			log.debug("등록됨.");
			this.service.registerPaymentInfo(applynoList);
		}
		this.service.modifyApplyStatus(applynoList);
		
		this.service.modifyApplyPno(applynoList);
		
		return "redirect:/admin/apply";
	}//applyUpdateAgree
	
	@PostMapping("applyUpdatePayment")
	public String applyUpdatePayment(@RequestParam("applyno") List<Integer> applyno,RedirectAttributes attrs) throws Exception {
		
		boolean isSucceed =this.service.modifyPaymentStatusAndApplyPaymentTF(applyno);
		
		if(!isSucceed) {
			attrs.addFlashAttribute("__RESULT__", "결제상태 업데이트에 실패하였습니다.");
		}//if
		
		return "redirect:/admin/apply";
	}//applyUpdatePayment
	
	//이진성 - 관리자페이지 > 회원관리
	@GetMapping("memberList")
	public void memberList(@RequestParam(defaultValue = "개인") String membertype, Model model) {
		
		List<MemberVO> members = this.service.getMemberList(membertype);
		
		model.addAttribute("members", members);
	}//memberList
	
	
	
	
	@PostMapping("delMember")
	public String delMember(@RequestParam("mno")List<Integer> mnoList, String membertype) throws Exception {
		log.info("mno List : {}", mnoList);
		
		this.service.delMember(mnoList);
		
		log.info("membertype : {}", membertype);
		membertype = URLEncoder.encode(membertype, "UTF-8"); //UTF-8로 인코딩 해준 후 redirect 해줘야 한글이 ??? 로 안깨짐 
		
		return "redirect:/admin/memberList?membertype=" + membertype;
		
	}//delMember
	
	@PostMapping("rollbackMember")
	public String rollbackMember(@RequestParam("mno") List<Integer> mnoList, String membertype) throws Exception {
		log.info("mno List : {}", mnoList);
		
		this.service.rollbackMember(mnoList);
		
		log.info("membertype : {}", membertype);
		membertype = URLEncoder.encode(membertype, "UTF-8"); //UTF-8로 인코딩 해준 후 redirect 해줘야 한글이 ??? 로 안깨짐
		
		return "redirect:/admin/memberList?membertype=" + membertype;
	}//rollbackMember
	
	@ResponseBody
	@PostMapping("changeMemberType")
	public void changeMemberType(Integer mno, String membertype) throws Exception {
		log.info("mno : {} // membertype : {}", mno, membertype);
		
		this.service.changeMemberType(mno, membertype);
		
		membertype = URLEncoder.encode(membertype, "UTF-8"); //UTF-8로 인코딩 해준 후 redirect 해줘야 한글이 ??? 로 안깨짐		
		/* return "redirect:/admin/memberList?membertype=" + membertype; */
	}
	
	@GetMapping("showDetailInfo")
	public void showDetailInfo(@RequestParam("mno") Integer mno, Model model) {
		MemberVO list = this.service.showMember(mno);
		
		model.addAttribute("list", list);
	}
	
	//=========현아==========//
	//=========현아==========//
	//모든 회원이 쓴글 조회
	@GetMapping("memberBoard")
	public void memberBoard(@ModelAttribute("cri")Criteria cri, Model model) throws Exception {//게시판명, 제목, 등록일, 체크박스
		log.debug("memberBoard({}) invoked",cri);
		
		
		List<BoardReplyCountVO> boards = this.service.getMemberBoardList(cri);
		
		PageDTO page = new PageDTO(cri, this.service.getMemberBoardTotalCount(cri));
		
		
		model.addAttribute("mbList",boards);
		model.addAttribute("page",page);
		
	}//memberBoard
	
	
	//체크박스 삭제
	@PostMapping("boardRemove")
	public String boardRemove(
						 @ModelAttribute("cri")Criteria cri,
						 @RequestParam("bno")List<Integer> bnoList,  
						 RedirectAttributes rttrs) throws Exception {
		log.debug("remove({},{}) invoked",cri,bnoList);
		
		this.service.memberBoardRemove(bnoList);
		
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/admin/memberBoard";
	}//boardRemove
	
	//모든 회원이 쓴 댓글 조회
	@GetMapping("memberReply")
	public void memberReply(@ModelAttribute("cri")Criteria cri, Model model) throws Exception {//게시판명, 제목, 등록일, 체크박스
		log.debug("memberReply({}) invoked",cri);
		
		
		List<ReplyBoardVO> boards = this.service.getMemberReplyList(cri);
		
		PageDTO page = new PageDTO(cri, this.service.getMemberReplyTotalCount(cri));
		
		
		model.addAttribute("mrList",boards);
		model.addAttribute("page",page);
		
	}//memberReply
	
	
	//댓글 체크박스 삭제
	@PostMapping("boardReplyRemove")
	public String boardReplyRemove(
						 @ModelAttribute("cri")Criteria cri,
						 @RequestParam("reno")List<Integer> renoList,  
						 RedirectAttributes rttrs) throws Exception {
		log.debug("boardReplyRemove({},{}) invoked",cri,renoList);
		
		this.service.memberReplyRemove(renoList);
		
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/admin/memberReply";
	}//boardReplyRemove
}//end class
