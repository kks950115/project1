package com.korea.gfair.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.ApplyDTO;
import com.korea.gfair.domain.ApplyFileVO;
import com.korea.gfair.domain.ApplyMemberFileVO;
import com.korea.gfair.domain.ApplyVO;
import com.korea.gfair.domain.BoothVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ExhibitionVO;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.domain.PaymentVO;
import com.korea.gfair.service.ApplyService;
import com.korea.gfair.service.ExhibitionService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@RequestMapping("/apply/")
@Controller
public class ApplyController {
	
	@Autowired
	ApplyService service;
	
	@Autowired private ExhibitionService exService;
	
	
	@GetMapping("app")
	public void appui() {
		log.debug("app() invoked.");
		
	}//appui
	
	@PostMapping("appform")
	public void applyFormUi(HttpSession session, Model model) throws Exception {
		log.debug("applyForm() invoked.");
		
//		1. session에 올라간 회원 id 를 이용해 CBNO, FID, PHONE, EMAIL, MEMBERID 가져옴
		
		MemberVO memberVO =(MemberVO)session.getAttribute("__LOGIN__");
		//sevice 메소드 호출
//		MemberVO member= this.service.getMemberInfo(memberDto);
		
//	 	2. APPLYNAME 이름으로 EXNAME 가져옴 - select 박스 
		List<ExhibitionVO> exhibition =this.service.getExhibitionInfo();
		
//		3. 부스 리스트 가져옴 
		List<BoothVO> booths=this.service.getBoothList();
		
//		4. model에 올리기. 
		
		model.addAttribute("__EXHI__", exhibition);
		model.addAttribute("__MEMBERINFO__", memberVO);
		model.addAttribute("__BOOTH__",booths);

	}//applyForm
	
	@ResponseBody
	@PostMapping("appform2")
	public List<BoothVO> applyFormBoothInfo() throws Exception {
		log.debug("applyFormBoothInfo() invoked.");
		

		 List<BoothVO> booths=this.service.getBoothList();
		 return booths;

	}//applyFormBoothInfo
	
	@PostMapping("applyform")
	public String applyForm(ApplyDTO dto, RedirectAttributes attrs, HttpSession session) throws Exception {
		log.debug("applyForm({}) invoked.", dto);
		
		//0. 동일 전시회에 신청 이력이 있는지 검사. 
		
		//전시회 신청한 아이디로 MemberDTO객체 생성  => XXX session login dto 이용
//		MemberVO memberVO = new MemberDTO();
//		memberDto.setMemberid(dto.getMemberid());
		
		//아이디로 전시회 신청 정보 있는지 확인. 
		List<ApplyVO> applyInfo =this.service.getApplyInfo((MemberVO)session.getAttribute("__LOGIN__"));
		
		//신청한 전시회가 새롭게 신청한 전시회와 같은지 확인. 
		
		try {
			if(applyInfo.get(0).getApplyname().equals(dto.getApplyname())) {
				attrs.addFlashAttribute("__RESULT__","신청 내역이 이미 존재합니다.");
				return "redirect:/apply/applystatus";
			}//if
		}catch(IndexOutOfBoundsException e) {
			log.debug("처음 전시회 참가 신청");
		}//try-catch
		
		
		//1. 부스 상태 업데이트하기. 
		boolean isSelected = this.service.boothIsSelected(dto);
		if(!isSelected) {//만약 업데이트 실패했다면
			attrs.addFlashAttribute("__RESULT__","이미 선택된 부스입니다. ");
			return "redirect:/apply/appform";
		}
		//2. 참가신청 서비스 호출. 
		boolean result =this.service.applyExhibition(dto);
		if(!result) {	//만약 신청 실패했다면.
			
			attrs.addFlashAttribute("__RESULT__","요청을 처리하는 도중 문제가 발생하였습니다.");
			return "redirect:/apply/appform";
		}else {
			attrs.addFlashAttribute("__RESULT__","신청이 완료되었습니다.");
			return "redirect:/apply/applystatus";
		}//if-else
		
	}//applyForm
	
	@SuppressWarnings("unused")
	@GetMapping("applystatus")
	public void applyStatus(Model model, HttpSession session) throws Exception {
		log.debug("applyStatus() invoked.");
		
		MemberVO memberVO =(MemberVO)session.getAttribute("__LOGIN__");
		
		//1. Apply info 가져오기 
		List<ApplyVO> applyInfo =this.service.getApplyInfo(memberVO);
		log.debug("========DEBUG=======>applyInfo : {}",applyInfo);
		
		
		if(!applyInfo.isEmpty()) {
			//2. Payment info 가져오기 
			log.debug("=========DEBUG POINT 2 ==========");
			int applyno=applyInfo.get(0).getApplyno();
			PaymentVO paymentInfo=this.service.getPaymentInfo(applyno);
			
			model.addAttribute("__APPLY__",applyInfo);
			model.addAttribute("__PAYMENT__", paymentInfo);
		}else{
			model.addAttribute("__RESULT_REDIRECT__", "신청정보가 없습니다.");
		}//if-else
		
	}//applyStatus
	
	//=== 진성 - 전시장 배치도 페이지 매핑 === 	
	@GetMapping("map")
	public void map() {
		
	}
	
	//=== 희용 - 전시 규정 페이지 매핑 ===
	@GetMapping("rule")
	public void rule() {
		
	}
	
	@GetMapping("booth")
	public void booth() {
		log.debug("booth() invoked.");
		
		
	}//booth()
	
	//=====다솜 - 참가신청안내
	@GetMapping("info")
	public void info() {
		log.debug("info() invoked.");
		
		
	}//info()
	
	//======현아 - 참가기업목록
	@GetMapping("companyList")
	public void companyList(Criteria cri, 
							@ModelAttribute("applyname") String applyname, 
							 Model model) throws Exception {
		log.debug("companyList({},{}) invoked.",cri,applyname);
	
		//한페이지에 12개씩
		cri.setAmount(12);
		
		//기업리스트 최근6개월까지 가져오기
		List<ApplyFileVO> list = this.service.getCompanyList(cri, applyname);
		//페이징처리
		PageDTO pageDTO = new PageDTO(cri,this.service.getTotalCount(applyname));
		//전시회리스트 최근 6개월까지 가져오기
		List<ExhibitionVO> exList = this.exService.getEx();
		
		log.info(exList);
		
		model.addAttribute("companyList", list);
		model.addAttribute("page", pageDTO);
		model.addAttribute("exList", exList);
	
	}//companyList
	
	@GetMapping("companyInfo")
	public void companyInfo(@ModelAttribute("cri") Criteria cri, 
							@ModelAttribute("applyname") String applyname, 
							Integer applyno, 
							Model model) throws Exception {
		log.debug("companyInfo({}) invoked.",applyno);
		
		//해당 기업정보 1개 가져오기
		ApplyMemberFileVO applyFileVO = this.service.getCompany(applyno);
		
		model.addAttribute("company", applyFileVO);
		
	}//companyInfo
}//end class
