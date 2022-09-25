package com.korea.gfair.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;
import com.korea.gfair.domain.UploadFileDTO;
import com.korea.gfair.domain.UploadFileVO;
import com.korea.gfair.service.QuestionBoardService;
import com.korea.gfair.service.ReplyService;
import com.korea.gfair.service.UploadFileService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@RequestMapping("/question/")
@Controller
public class QuestionBoardController {

	@Setter(onMethod_ = @Autowired)
	QuestionBoardService service;
	
	@Setter(onMethod_ = @Autowired)
	ReplyService replyService;
	
	@Setter(onMethod_ = @Autowired)
	UploadFileService fileService;

	
	@GetMapping("list")
	public void list(@ModelAttribute("cri") Criteria cri,Model model, BoardDTO dto) throws Exception {
		log.debug("list({}) invoked.", model);
		
		List<BoardVO> list =this.service.getAllList(cri);
	
		PageDTO pageDTO = new PageDTO(cri, this.service.getTotal(cri));
		
		model.addAttribute("__LIST__", list);
		model.addAttribute("__PAGE__", pageDTO);
	}//list
	
	@GetMapping({"modify","retrieve"})
	public void modifyUi(@ModelAttribute("cri") Criteria cri,
			BoardDTO dto, Model model) throws Exception {
		log.debug("modifyUi() invoked.");
		
		BoardVO board=this.service.getOneList(dto);
		
		model.addAttribute("__LIST__", board);
	}//modifyUi
	
	@GetMapping({"get"})
	public void getui(
			@ModelAttribute("cri") Criteria cri,
			BoardDTO dto, ReplyDTO replyDto,UploadFileDTO fileDTO, 
			Model model) throws Exception {
		
		log.debug("getui({},{}) invoked.", dto, model);
		
		BoardVO list = this.service.getOneList(dto);
		List<ReplyVO> reply = this.replyService.getReply(replyDto);
		
		if(list.getFid() != null) {
			fileDTO.setFid(list.getFid());
			UploadFileVO file =this.fileService.getFile(fileDTO);
			
			model.addAttribute("__FILE__", file);
		}//if
		
		
		model.addAttribute("__LIST__", list);
		model.addAttribute("__REPLY__",reply);
		
	}//getui
	
	@GetMapping({"register"})
	public void registerui(Model model) {
		log.debug("registerui({}) invoked.",model);
		
	}//registerui
	
	@PostMapping("replyRegister")
	public String replyRegister (@ModelAttribute("cri") Criteria cri, ReplyDTO dto, RedirectAttributes rttrs) 
				throws Exception {
		log.debug("replyRegister({},{},{}) invoked.",cri,dto,rttrs);
		
		boolean result=this.replyService.registerReply(dto);
		
		if(result) {
			rttrs.addFlashAttribute("__RESULT__", "댓글 등록 완료");
		}//if
		
		return "redirect:/question/get?bno="+dto.getBno();
	}//replyRegister
	
	@PostMapping("replyRemove")
	public String replyRemove(@ModelAttribute("cri") Criteria cri, ReplyDTO dto, RedirectAttributes rttrs) throws Exception {
		log.debug("replyRegister({},{},{}) invoked.",cri,dto,rttrs);
		
		boolean result= this.replyService.removeReply(dto);
		
		if(result) {
			rttrs.addFlashAttribute("__RESULT__", "댓글 삭제 완료");
		}//if
		
		return "redirect:/question/get?bno="+dto.getBno();
	}//replyRemove
	
	@PostMapping("register")
	public String register(
			@ModelAttribute("cri") Criteria cri,BoardDTO dto,MultipartFile file, RedirectAttributes rttrs, String editordata) throws Exception {
		log.debug("register({}, {}) invoked.", dto, rttrs);
		log.debug("file : {}", file);
		log.debug("editordata : {} ",editordata);
		
		if(file.getSize() > 0) {
			int fid=this.fileService.uploadFile(file);
			dto.setFid(fid);
		}//if
		
//		
		dto.setContent(editordata);
		boolean result=this.service.register(dto);
		
		if(result) {
			rttrs.addFlashAttribute("__RESULT__", "작성 완료");
		}//if
		
		 
		return "redirect:/question/list";
	}//register
	
	@PostMapping("retrieve")
	public String retrieve(@ModelAttribute("cri") Criteria cri,BoardDTO dto, RedirectAttributes rttrs,String editordata) throws Exception {
		log.debug("retrieve({}, {}) invoked.", dto, rttrs);
		
		dto.setContent(editordata);
		boolean result=this.service.retrieve(dto);
		
		if(result) {
			rttrs.addFlashAttribute("__RESULT__", "답글 작성 완료");
		}//if
		
		 rttrs.addAttribute("currPage" , cri.getCurrPage());
		 rttrs.addAttribute("amount", cri.getAmount());
		 rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/question/list";
	}//retrieve
	
	@PostMapping("modify")
	public String modify(@ModelAttribute("cri") Criteria cri, BoardDTO dto, RedirectAttributes rttrs,String editordata) throws Exception{
		log.debug("modify({},{}) invoked.", dto, rttrs);
		
		dto.setContent(editordata);
		boolean result=this.service.modify(dto);
		
		if(result) {
			rttrs.addFlashAttribute("__RESULT__", "수정 완료");
		}//if
		
		 rttrs.addAttribute("currPage" , cri.getCurrPage());
		 rttrs.addAttribute("amount", cri.getAmount());
		 rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/question/list";
	}//modify
	
	@PostMapping("remove")
	public String remove(@ModelAttribute("cri") Criteria cri,BoardDTO dto, RedirectAttributes rttrs) throws Exception {
		log.debug("modify({},{}) invoked.", dto, rttrs);
		
		boolean result =this.service.remove(dto);
		
		if(result) {
			rttrs.addFlashAttribute("__RESULT__", "게시글이 삭제되었습니다.");
		}//if
		
		 rttrs.addAttribute("currPage" , cri.getCurrPage());
		 rttrs.addAttribute("amount", cri.getAmount());
		 rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/question/list";
	}//remove
	
	
	
}//end class
