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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.EventDTO;
import com.korea.gfair.domain.EventVO;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.domain.PhotoDTO;
import com.korea.gfair.domain.PhotoVO;
import com.korea.gfair.domain.PhotoVO2;
import com.korea.gfair.service.EventBoardService;
import com.korea.gfair.service.PhotoBoardService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@RequestMapping("/photo/")
@Controller
public class PhotoBoardController {
	
	@Autowired
	private PhotoBoardService photoService;
	
	@Autowired
	private EventBoardService eventService;
	
	@GetMapping("list")
	public void list(Model model) {
		log.debug("list() invoked.");
		log.info("\t+ model: " + model);
		
		List<PhotoVO2> photos = this.photoService.getList();
		
		Objects.requireNonNull(photos);
		
		photos.forEach(log::info);
		
		model.addAttribute("list", photos);
	}//list()
	
	@GetMapping("listPerPage")
	public String listPerPage(@ModelAttribute("cri")Criteria cri, Model model) {
		log.debug("listPerPage(cri, model) invoked.");
		log.info("\t+ cri: {}, model: {}", cri, model);
		
		cri.setAmount(12);
		List<PhotoVO2> photos = this.photoService.getListPerPage(cri);
		
		Objects.requireNonNull(photos);
		
		photos.forEach(log::info);
		PageDTO pageDTO = new PageDTO(cri, this.photoService.getTotal(cri));
		
		model.addAttribute("list", photos);
		model.addAttribute("pageMaker", pageDTO);
		//우리가 직접 뷰의 이름을 반활 할때는 baseURi이랑 상세URI를 지정해야함
		
		return "/photo/list";
	}//listPerPage()
	
	@GetMapping("register")
	public void registerui(@ModelAttribute("cri") Criteria cri) {
		log.debug("registerui(cri) invoked.");
		log.info("\t+ cri: " + cri);
		
	}//registerui()
	
	@PostMapping("register")
	public String registerImage(
			EventDTO eventDTO,
			@ModelAttribute("cri") Criteria cri, 
			MultipartFile uploadFile,
			RedirectAttributes rttrs
			) {
		
		log.debug("registerImage()invoked.");
		
		log.info(
				"cri: {}, uploadFile: {}, rttrs: {}",
				cri, uploadFile, rttrs);
		
		this.eventService.register("img", eventDTO, uploadFile);
		log.info("uploadFileName: " + uploadFile.getOriginalFilename());
		log.info("uploadFile: " + uploadFile);
		
		
		rttrs.addFlashAttribute(
				"result", uploadFile);
		
		
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
		
		return "redirect:/photo/listPerPage";
		
		
	} // registerImage
	
	@GetMapping({"getFile", "modify"})
	public void get(
			@ModelAttribute("cri") Criteria cri,
		    @RequestParam("fid")Integer fid,
		    Model model) {
		
		log.debug("get() invoked.");
		log.info("fileNo: {}, model: {}", fid, model);
		
		PhotoVO photo = this.photoService.read(fid);
		log.info("\t+ photo: " + photo);
		
		EventVO board = this.eventService.getWithFid(fid);
		log.info("\t+ board: " + board);
		
		this.eventService.readcntWithFid(fid);
		model.addAttribute("board", board);
		model.addAttribute("file", photo);
	}//get()
	
	
	
	@PostMapping("modify")
	public String modify(
			@ModelAttribute("cri") Criteria cri,
			EventDTO eventDTO,
			Integer fid,
			MultipartFile uploadFile, 
			RedirectAttributes rttrs
			) {
		log.debug("modify(cri, eventDTO, rttrs) invoked.");
		log.info(
				"\t+ cri: {}, eventDTO: {}, rttrs: {}"
				,cri, uploadFile, rttrs);
		
		log.info("\t+ ===============eventDTO: " + eventDTO);
		
		
		this.eventService.modify(eventDTO, uploadFile);
//		this.photoService.modify(fid, uploadFile);
		
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

		return "redirect:/photo/listPerPage";  //HTTP status code 301(moved permanently)
		
	}//modify()
	
	
	
	
	@PostMapping("remove")
	public String remove(
			@ModelAttribute("cri") Criteria cri,
			@RequestParam(value="fid", required=false) Integer fid, 
			RedirectAttributes rttrs) {
		log.debug("remove({}, {}) invoked,", fid, rttrs);
		
		boolean childRemoved = this.eventService.removeWithFid(fid);
		
		if(childRemoved) {
			log.info("자식레코드가 삭제되었습니다.");
			
		}else {
			log.info("자식레코드 삭제실패.");
			
		}
		
		boolean isRemoved = this.photoService.remove(fid);
		
		if(isRemoved) {//삭제 성공일때
			rttrs.addFlashAttribute("result", "success");
		}//if
		
		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		//주소창의 주소가 바뀐다 redirect
		
		return "redirect:/photo/listPerPage";
	}//remove()
}//end class
