package com.korea.gfair.controller;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.service.NewsBoardService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@Controller  
@RequestMapping("/news/") /* **/ 
public class NewsBoardController {
	
	@Autowired
	private NewsBoardService service;

//	@GetMapping("list")
//	public void list(Model model) {
//		log.debug("list(Model model) invoked");
//	
//		List<BoardVO> board = this.service.getList();
//		
//		Objects.requireNonNull(board); 
//		
//		board.forEach(log::info);
//		
//		
//		model.addAttribute("list",board);
//		
//	}// end list
	
	@GetMapping("modify")
	public void modifyui(
			@ModelAttribute("cri") Criteria cri,  
			@RequestParam("bno") Integer bno ,
			Model model) { 
		log.debug("getui invoked");
		
		BoardVO board = this.service.select(bno);
	
		
		assert board != null;
		
		log.info("board");
		
		model.addAttribute("board",board);
	}
	
	@GetMapping("get")
	public void getui(
			@ModelAttribute("cri") Criteria cri,  
			@RequestParam("bno") Integer bno ,
			Model model) { 
		log.debug("getui invoked");
		
		BoardVO board = this.service.select(bno);
		this.service.hit(bno);
		assert board != null;
		
		log.info("board");
		
		model.addAttribute("board",board);
	}
	
	@PostMapping("modify")
	public String modify(
				@ModelAttribute("cri") Criteria cri,
				BoardVO board,
				RedirectAttributes rttrs){
		
		log.debug("modify invoked");
		
		boolean isModify = this.service.modify(board);
		
		if(isModify) {
			rttrs.addAttribute("result", "OK ");
		}
		
		rttrs.addAttribute("currPage",cri.getCurrPage());
		rttrs.addAttribute("amount",cri.getAmount());
		rttrs.addAttribute("pagesPerPage",cri.getPagesPerPage());
		
		return "redirect:/news/listPerPage";		
	}
	
	@GetMapping("register")  // 등록화면 >> 페이지정보를 남겨야함
	public void registerui(@ModelAttribute("cri") Criteria cri) {

		
		log.debug("register () invoked");		
	}
	
	@PostMapping("register")
						//dto로 변경하기 
	public String register(
			@ModelAttribute("cri") Criteria cri,
			BoardVO board,
			RedirectAttributes rttrs) {
		log.debug("register () invoked");
		
		this.service.register(board);
		
		rttrs.addAttribute("currPage",cri.getCurrPage());
		rttrs.addAttribute("amount",cri.getAmount());
		rttrs.addAttribute("pagesPerPage",cri.getPagesPerPage());
		
		return "redirect:/news/listPerPage";
		
	}//end register 
	
	@PostMapping("remove")
	public String remove(
				@ModelAttribute("cri") Criteria cri,
				Integer bno,
				RedirectAttributes rttrs) {
		log.debug("remove invoked");
		
		boolean isRemove =this.service.remove(bno);
		if(isRemove) {
			rttrs.addAttribute("result","OK");
		}
		
		rttrs.addAttribute("currPage",cri.getCurrPage());
		rttrs.addAttribute("amount",cri.getAmount());
		rttrs.addAttribute("pagesPerPage",cri.getPagesPerPage());
		
		return "redirect:/news/listPerPage";
	}
	
	//list를 criteria로 받아서 페이징 처리하는 매핑 
	@GetMapping("listPerPage")
	public String listPerPage(
					@ModelAttribute("cri") Criteria cri, Model model ){
		 log.info("****************************"+cri);
		List<BoardVO> boards = this.service.getList(cri);
		
		Objects.requireNonNull(boards);
		boards.forEach(log::info);
		
		PageDTO pageDTO = new PageDTO(cri, this.service.getTotal(cri));
		model.addAttribute("list", boards); 
		model.addAttribute("pageMaker", pageDTO); 
		
		return "news/list"; 
		
	}//end listPerPage 
	
	
	
// 검색하기기능 
//	@GetMapping("retrieve")
//	public void retrieve(Model model) {
//
//		log.debug("register () invoked");
//		
//	}
	
	
}//end controller
