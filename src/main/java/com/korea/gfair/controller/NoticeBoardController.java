package com.korea.gfair.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.AttachFileVO;
import com.korea.gfair.domain.BoardDTO;
import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.BoardVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;
import com.korea.gfair.service.NoticeBoardReplyService;
import com.korea.gfair.service.NoticeBoardService;
import com.korea.gfair.service.UploadFileService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@Controller
@RequestMapping("/notice/")
public class NoticeBoardController {
	
	@Setter(onMethod_ = @Autowired)
	private NoticeBoardService board_service;
	
	@Setter(onMethod_ = @Autowired)
	private NoticeBoardReplyService reply_service;

	@Setter(onMethod_ = @Autowired)
	private UploadFileService file_service;
	
	BoardDTO dto = new BoardDTO();
	
	@GetMapping("list")
	public void getList(@ModelAttribute("cri") Criteria cri, Model model) {
		List<BoardReplyCountVO> list_notice = this.board_service.readNotice("공지사항");
		List<BoardReplyCountVO> list = this.board_service.getListPerPage(cri, "공지사항");
		
		PageDTO pageDTO = new PageDTO(cri, this.board_service.getTotal(cri, "공지사항"));
		model.addAttribute("pageMaker", pageDTO);
		
		
		model.addAttribute("list_notice", list_notice);
		model.addAttribute("list", list);
	}
	
	
	@GetMapping("get")
	public void get(ReplyDTO re_dto, BoardDTO dto, Model model, @ModelAttribute("cri") Criteria cri) {
		this.board_service.readCnt(dto);
		BoardVO board = this.board_service.readOne(dto);
		
		List<ReplyVO> reply = this.reply_service.getReply(re_dto);
		
		log.info("&& file FID : " + board.getFid());
		if(board.getFid() != null) {
			AttachFileVO attachVO = this.file_service.getFileById(board.getFid());
			model.addAttribute("file", attachVO);
		}
		
		
		model.addAttribute("board", board);
		model.addAttribute("reply", reply);

	}
	
	
	@GetMapping({"modify", "answer"})
	public void get(BoardDTO dto, Model model, @ModelAttribute("cri") Criteria cri) {
		
		BoardVO board = this.board_service.readOne(dto);
		
		
		log.info("&& file FID : " + board.getFid());
		if(board.getFid() != null) {
			AttachFileVO attachVO = this.file_service.getFileById(board.getFid());
			model.addAttribute("file", attachVO);
		}
		
		
		model.addAttribute("board", board);
		
	}
	
	@PostMapping("modify")
	public String modify(@ModelAttribute("cri") Criteria cri, BoardDTO dto, RedirectAttributes rttrs, @RequestParam("file") MultipartFile file, @RequestParam(value="delete_file", defaultValue = "F") String delete_file) throws Exception {
		
		if(delete_file.equals("T")) { //수정창에서 기존파일삭제 체크박스 유무에따라
			//기존 게시판 테이블 파일을 null로 업데이트
			//기존 파일 테이블에서 fid 값으로 데이터 삭제 
			this.file_service.removeExistFileFromBoard(dto);  
		} 
		else if(delete_file.equals("F")) {
			;;
		}
		
		this.board_service.modify(dto);
		this.file_service.uploadFileByModify(dto, file);
		
		
		rttrs.addAttribute("result", "success");
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/notice/list";
	}
	
	@PostMapping("answer")
	public String answer(@ModelAttribute("cri") Criteria cri, BoardDTO dto, RedirectAttributes rttrs, @RequestParam("file") MultipartFile file) throws Exception {
		
		this.board_service.writeAnswer(dto);
		this.file_service.uploadFileByWrite(dto, file);
		
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/notice/list";
	}
	
	@GetMapping("register")
	public void register(@ModelAttribute("cri") Criteria cri, HttpSession session) {

	}
	
	@PostMapping("register")
	public String register(@ModelAttribute("cri") Criteria cri, BoardDTO dto, RedirectAttributes rttrs, @RequestParam("file") MultipartFile file) throws Exception {
		log.debug("register_controller invoked.");
		
		this.board_service.register(dto);
		this.file_service.uploadFileByWrite(dto, file);
		
		
		rttrs.addAttribute("result", "success");
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		
		return "redirect:/notice/list";
	}//register
	
	
	@PostMapping("remove")
	public String remove(@ModelAttribute("cri") Criteria cri, BoardDTO dto, RedirectAttributes rttrs) {
		this.board_service.remove(dto);
		
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/notice/list";
	}
	
	
	
	
	@GetMapping("load_img")
	public void load_img(BoardDTO dto, HttpServletResponse response) {
		
		AttachFileVO file = this.file_service.getFileById(dto);
		
		this.file_service.load_img(dto, file, response);
		
	}//load_img
	


	
	@PostMapping("writeReply")
	public String writeReply(@ModelAttribute("cri") Criteria cri, ReplyDTO dto, RedirectAttributes rttrs) {
		
		this.reply_service.writeReply(dto);
		
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/notice/get?bno=" + dto.getBno();
	}
	
	@PostMapping("removeReply")
	public String removeReplay(@ModelAttribute("cri") Criteria cri, ReplyDTO dto, RedirectAttributes rttrs) {

		this.reply_service.removeReply(dto);
		
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/notice/get?bno=" + dto.getBno();
	}
	
	@ResponseBody
	@PostMapping("modifyReply")
	public void modifyReply(ReplyDTO dto) {
		
		this.reply_service.modifyReply(dto);
	}
	
}
