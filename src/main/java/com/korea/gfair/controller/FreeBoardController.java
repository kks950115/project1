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

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;
import com.korea.gfair.service.FreeBoardReplyService;
import com.korea.gfair.service.FreeBoardService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@RequestMapping("/free/")
@Controller
public class FreeBoardController {
	
	@Setter(onMethod_=@Autowired)
	public FreeBoardService service;
	
	@Autowired
	public FreeBoardReplyService replyService;

	
	
	@GetMapping("board")
	public String listPerPage(@ModelAttribute("cri") Criteria cri, Model model) {
		
		List<BoardVO> boards = service.getListPerPage(cri,"자유게시판");
		
		Objects.requireNonNull(boards);
		
		boards.forEach(log::info);
		
		
		PageDTO pageDTO= new PageDTO(cri,service.getTotal(cri,"자유게시판"));
		
		model.addAttribute("__LIST__",boards);
		model.addAttribute("pageMaker",pageDTO);
		
		
		return "free/board";
		
	}//listPerPage
	
	@GetMapping({"read","modify"})
	public void read(BoardDTO dto,ReplyDTO rdto, Model model) {

		BoardVO read = service.read(dto);
		
		log.info(">>>>>>>>>>>>>>>>>" + rdto);
		
		Objects.requireNonNull(read);
		model.addAttribute("__READ__",read);

		List<ReplyVO> replyList = replyService.readReply(rdto);

		model.addAttribute("__replyList__",replyList);
		
	}//read
	
	
	@PostMapping("modify")
	public String modify(BoardDTO dto) {
		
		service.modify(dto);
		
		return "redirect:/free/board";
	}//modify
	
	
	@GetMapping("write")
	public void write() {
		
		
	}//write
	
	@PostMapping("write")
	public String write(BoardVO vo) {
		boolean write = service.write(vo);
		
		Objects.requireNonNull(write);
		
		return "redirect:/free/board";
		
	}//write
	
	@PostMapping("remove")
	public String remove(@RequestParam("bno") Integer bno) {
		log.info("integer bno : " + bno);
		service.remove(bno);
		
		return "redirect:/free/board";
	}//remove
	
	@PostMapping("replyWrite")
	public String replyWrite(ReplyDTO rdto) {
		replyService.writeReply(rdto);
		
		return "redirect:/free/read?bno="+ rdto.getBno();
	}//replyWrite
	
	@PostMapping("replyModify")
	public void replyModify(ReplyDTO dto,Model model) {
		
		replyService.modifyReply(dto);
		
	}//replyModify
	
	@PostMapping("replyRemove")
	public String replyRemove(ReplyDTO dto) {

		log.info(">>>>>>>>"+dto.getBno());
		replyService.deleteReply(dto);
		
		
		return "redirect:/free/read?bno="+dto.getBno();
		
	}//replyModify
	
	@PostMapping("countReply")
	public void countReply(ReplyDTO dto,Model model) {
		replyService.countReply(dto);
		
	}//countReply

}//end class
