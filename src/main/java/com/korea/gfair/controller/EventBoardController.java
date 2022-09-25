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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.EventDTO;
import com.korea.gfair.domain.EventVO;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.domain.PhotoVO;
import com.korea.gfair.service.EventBoardService;
import com.korea.gfair.service.PhotoBoardService;
import com.korea.gfair.service.ReplyService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@RequestMapping("/event/")
@Controller
public class EventBoardController {

	@Setter(onMethod_= {@Autowired})
	private EventBoardService service;
	
	
	@Setter(onMethod_= {@Autowired})
	private PhotoBoardService photoService;
	
	@Setter(onMethod_= {@Autowired})
	private ReplyService replyService;
	
	@GetMapping("listPerPage")
	public String listPerPage(@ModelAttribute("cri")Criteria cri, Model model) {
		log.debug("list(cri, model) invoked.");
		log.info("\t+ cri: {}, model: {}", cri, model);
		
		List<EventVO> lists = this.service.getListPerPage(cri);
		
		Objects.requireNonNull(lists);
		
		lists.forEach(log::info);
		
		PageDTO pageDTO = new PageDTO(cri, this.service.getTotal(cri));
		
		
		model.addAttribute("list", lists);
		model.addAttribute("pageMaker", pageDTO);
		
		return "/event/list";
	}//list()
	
	
	
	@GetMapping("register")
	public void registerui(@ModelAttribute("cri")Criteria cri) {
		log.debug("registerui() invoked.");
		log.info("\t+ cri: " + cri);
		
	}//registerui()
	
	
	
	@PostMapping("register")
	public String registerAction(
			EventDTO eventDTO,
			Criteria cri,
			RedirectAttributes rttrs,
			MultipartFile uploadFile
			) {
		log.debug("registerAction() invoked.");
		log.info("\t+ eventDTO: {}, cri: {}, rttrs: {}",
				eventDTO, cri, rttrs);
		
		log.info("uploadFileName: " + uploadFile.getOriginalFilename());
		
		log.info("uploadFile: " + uploadFile);
		
		this.service.register("event_img", eventDTO, uploadFile);
		
		
		rttrs.addFlashAttribute(
				"result",
				eventDTO.getBno()
			);
		
		rttrs.addAttribute(
				"currPage",
				cri.getCurrPage()
			);
		rttrs.addAttribute(
				"amount",
				cri.getAmount()
			);
		rttrs.addAttribute(
				"pagesPerPage",
				cri.getPagesPerPage()
				);
		
		return "redirect:/event/listPerPage";
		
	}//registerAction()
	
	@GetMapping("test")
	public void test() {
		
	}//test
	
	@GetMapping("get")
	public void get(
			@ModelAttribute("cri") Criteria cri,
			@RequestParam("bno") Integer bno,
			Model model
			) {
		log.debug("get(cri, bno, model) invoked.");
		log.info(
				"\t+ cri: {}, bno: {}, model: {}",
				cri, bno, model);
		
		
		EventVO eventVO = this.service.get(bno);
		log.info("\t+ eventVO: " + eventVO.getFid());
		
		PhotoVO photoVO = this.photoService.read(eventVO.getFid());
		log.info("\t+ photoVO: " + photoVO);
		
		
		model.addAttribute("photo", photoVO);
		
		model.addAttribute("board", eventVO);
		
		this.service.readcnt(bno);
		
	}//get()
	
	@GetMapping({"subGet", "modify"})
	public void get1(
			@ModelAttribute("cri") Criteria cri,
			@RequestParam("bno") Integer bno,
			Model model
			) {
		log.debug("get(cri, bno, model) invoked.");
		log.info(
				"\t+ cri: {}, bno: {}, model: {}",
				cri, bno, model);
		
		
		EventVO eventVO = this.service.get(bno);
		log.info("\t+ eventVO: " + eventVO.getFid());
		
		PhotoVO photoVO = this.photoService.read(eventVO.getFid());
		log.info("\t+ photoVO: " + photoVO);
		
		
		model.addAttribute("photo", photoVO);
		
		model.addAttribute("board", eventVO);
		
		
	}//get()
	
	@PostMapping("modify")
	public String modify(
			@ModelAttribute("cri") Criteria cri,
			EventDTO eventDTO,
			@Nullable MultipartFile uploadFile, 
			RedirectAttributes rttrs
			) {
		log.debug("modifyController(cri, eventDTO, rttrs) invoked.");
		log.info(
				"\t+ cri: {}, eventDTO: {}, rttrs: {}"
				,cri, eventDTO, rttrs);
		
		this.service.modify(eventDTO, uploadFile);
//		this.photoService.modify(eventDTO.getFid(), uploadFile);

		rttrs.addFlashAttribute(
				"result",
				"success"
			);
		rttrs.addAttribute(
				"currPage", 
				cri.getCurrPage()
			);
		rttrs.addAttribute(
				"amount", 
				cri.getAmount()
			);
		rttrs.addAttribute(
				"pagesPerPage", 
				cri.getPagesPerPage()
			);

		return "redirect:/event/listPerPage";  //HTTP status code 301(moved permanently)
		
	}//modify()
	
	
	
	
	@PostMapping("remove")
	public String remove(
			@ModelAttribute("cri") Criteria cri,
			@RequestParam("bno") Integer bno,
//			@RequestParam("reno") Integer reno,
			RedirectAttributes rttrs
			) {
		
		log.debug("remove(cri, bno, rttrs) invoked.");
		log.info(
				"\t+ cri: {}, bno: {}, rttrs: {}",
				cri, bno, rttrs);
		
//		int childRemoved = this.replyService.remove(reno);
//		
//		if(childRemoved == 1) {
//			log.info("자식레코드가 삭제되었습니다.");
//			
//		}else {
//			log.info("자식레코드 삭제실패.");
//			
//		}
		
		
		boolean isRemoved = this.service.remove(bno);
		
		if(isRemoved) {
			rttrs.addFlashAttribute("result", "success");
		}//if
		
		rttrs.addAttribute(
				"currPage",
				cri.getCurrPage()
			);
		rttrs.addAttribute(
				"amount",
				cri.getAmount()
			);
		rttrs.addAttribute(
				"pagesPerPage",
				cri.getPagesPerPage()
				);
		
		return "redirect:/event/listPerPage";
		
	}//remove()
}//end class

