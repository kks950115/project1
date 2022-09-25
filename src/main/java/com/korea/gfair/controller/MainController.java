package com.korea.gfair.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.service.NoticeBoardService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@Controller
//@RequestMapping("/")
public class MainController {
	
	@Setter(onMethod_ = @Autowired)
	private NoticeBoardService board_service;
	
	//@RequestMapping(value = "/", method = RequestMethod.GET)
	@GetMapping({"index","/"})
	public String index(@ModelAttribute("cri") Criteria cri, Model model) {
		List<BoardReplyCountVO> list = this.board_service.getListPerPage(cri, "공지사항");
		model.addAttribute("list", list);
		
		return "index";
	}
}
