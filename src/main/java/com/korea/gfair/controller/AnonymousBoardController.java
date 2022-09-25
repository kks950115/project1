package com.korea.gfair.controller;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.AttachFileDTO;
import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.BoardSearchFileVO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.service.AnonymousBoardService;
import com.korea.gfair.service.BoardReplyService;
import com.korea.gfair.service.UploadFileService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@RequestMapping("/anony/")
@Controller
public class AnonymousBoardController {

//되는거맞나?
	@Autowired private AnonymousBoardService service;
	@Autowired private BoardReplyService replyservice;
	@Autowired private UploadFileService fileService;
	
	
	@GetMapping("list")
	public void iist(@ModelAttribute("cri")Criteria cri, Model model) throws Exception {
		
		log.debug("list({}, {}) invoked",cri,model);
		
		Objects.nonNull(service);
		
//		List<BoardVO> boards = this.service.getList(cri, "anony");
		List<BoardReplyCountVO> boards = this.replyservice.getBoardReplyCnt(cri, "anony");
		PageDTO page = new PageDTO(cri, this.service.getTotalCount(cri,"anony"));
		
		Objects.nonNull(boards);
		boards.forEach(log::info);


		model.addAttribute("list",boards);
		model.addAttribute("page",page);
		
		log.info("page!!!!!!!!!!!!!!!!!!!!!!"+page);
	
	}//iist
	
	
	@GetMapping({"getPage"})
	public void get(
			@ModelAttribute("cri") Criteria cri, 
			Integer bno, 
			Integer readcnt,
			Model model) throws Exception{
		
		log.debug("getui({}) invoked",model);
		
		Objects.nonNull(this.service);
		Objects.nonNull(this.fileService);
		
		//조회시 조회수1 올림
		this.service.readCount(bno);
		
		//bno로 게시글
//		BoardVO board = this.service.getSelect(bno);
		
//		bno로 게시글+파일정보 1개 찾기
		BoardSearchFileVO boardSearchFileVO = this.fileService.getBoardFile(bno);
		
//		model.addAttribute("board",board);
		model.addAttribute("board",boardSearchFileVO);
		model.addAttribute("boardFileVO",boardSearchFileVO);
		
		log.info(">>>>>>>>>>>>>>boardSearchFileVO 찍어보자!! "+boardSearchFileVO);
		log.info(">>>>>>>>>>>>>>MODEL 찍어보자!! "+model);
	}//getui
	
	
	@GetMapping({"get","modify"})
	public void modify(
			@ModelAttribute("cri") Criteria cri, 
			Integer bno, 
			Integer readcnt,
			Model model) throws Exception{
		
		log.debug("getui({}) invoked",model);
		
		Objects.nonNull(this.service);
		Objects.nonNull(this.fileService);
		
		//bno로 게시글
//		BoardVO board = this.service.getSelect(bno);
		
//		bno로 게시글+파일정보 1개 찾기
		BoardSearchFileVO boardSearchFileVO = this.fileService.getBoardFile(bno);
		
		model.addAttribute("board",boardSearchFileVO);
		model.addAttribute("boardFileVO",boardSearchFileVO);
				
		log.info(">>>>>>>>>>>>>>MODEL 찍어보자!! "+model);
	}//getui
	
	
	@GetMapping({"register","retrieve"})
	public void registerui( @ModelAttribute("cri") Criteria cri,
							@ModelAttribute("board") BoardDTO boardDTO) throws Exception {
		log.debug("registerui({}) invoked",boardDTO);
		
	}//register
	
	
//	@Transactional
	@PostMapping({"register"})
	public String register(@ModelAttribute("cri") Criteria cri, 
							BoardDTO dto, 
							String editor1,
							@Nullable AttachFileDTO fileDTO, 
							RedirectAttributes rttrs) throws Exception {
		
		log.debug("register({},{}) invoked",dto,fileDTO);
		
		Objects.nonNull(service);
		
		dto.setContent(editor1);
		this.service.register(dto,fileDTO);

		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/anony/list";
	}//register
	
	
	@PostMapping("modify")
	public String modify(@ModelAttribute("cri") Criteria cri, 
							BoardDTO dto, 
							String editor1,
							@Nullable AttachFileDTO fileDTO,
							RedirectAttributes rttrs) throws Exception {
		
		log.debug("modify({},{}) invoked",dto,fileDTO);
		
		Objects.nonNull(service);
//		Objects.nonNull(this.fileService);
		dto.setContent(editor1);
		this.service.modify(dto,fileDTO);
		
	
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/anony/list";
	}//modify
	
	@PostMapping("remove")
	public String remove(@ModelAttribute("cri") Criteria cri, 
								BoardDTO dto,  
								RedirectAttributes rttrs) throws Exception {
		log.debug("remove() invoked");
		
		Objects.nonNull(service);
		
		this.service.remove(dto);
	
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/anony/list";
	}//remove
	
	
	@PostMapping("retrieve")
	public String retrieve(@ModelAttribute("cri") Criteria cri, 
								BoardDTO dto, 
								String editor1,
								@Nullable AttachFileDTO fileDTO,
								RedirectAttributes rttrs) throws Exception {
		log.debug("retrieve({},{}) invoked",dto,fileDTO);
		
		Objects.nonNull(this.service);
		
		dto.setContent(editor1);
		this.service.retrieve(dto,fileDTO);
		
		
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/anony/list";
	}//repRegister
}//end class
