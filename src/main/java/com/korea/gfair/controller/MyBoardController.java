package com.korea.gfair.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.service.MyBoardService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@RequestMapping("myBoard")
@Controller
public class MyBoardController {

	@Autowired private MyBoardService myService;
	
	
	
	//내가 쓴글만 조회
	@GetMapping({"list"})
	public void list(@ModelAttribute("cri")Criteria cri, String memberid, Model model) throws Exception {//게시판명, 제목, 등록일, 체크박스
		log.debug("list({},{}) invoked",cri,memberid);
		
		
		List<BoardReplyCountVO> boards = this.myService.getList(cri, memberid);
		PageDTO page = new PageDTO(cri, this.myService.getTotalCount(cri,memberid));
		
		
		model.addAttribute("list",boards);
		model.addAttribute("page",page);
		
	}//list
	
	
	//체크박스 삭제
	@PostMapping("remove")
	public String remove(
						 String memberid,
						 @ModelAttribute("cri")Criteria cri,
						 @RequestParam("bno")List<Integer> bnoList,  
						 RedirectAttributes rttrs) throws Exception {
		log.debug("remove({},{},{},{}) invoked",memberid,cri,bnoList,rttrs);
		
		this.myService.selectAllRemove(bnoList, memberid);
		
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		rttrs.addAttribute("memberid", memberid);

		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>rttrs : "+rttrs);
		
		return "redirect:/myBoard/list";
	}//remove
}//end class
