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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ExhibitionDTO;
import com.korea.gfair.domain.ExhibitionVO;
import com.korea.gfair.domain.FullCalendarDTO;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.service.ExhibitionService;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@RequestMapping("/exhibition/")
@Controller
public class ExhibitionController {

	
	@Setter(onMethod_= {@Autowired})
	private ExhibitionService exService;
	
	
	//전시일정관련 화면띄우기
	@GetMapping({"calendar","register","calRegister"})
	public void view() {
		
	}//view
	
	
	//게시판
	@GetMapping("list")
	public void getList(
			@ModelAttribute("cri")Criteria cri, 
			Model model) throws Exception {
		log.debug("getList() invoked");
		
		List<ExhibitionVO> exList = this.exService.getExPagingList(cri);
		
		Objects.nonNull(exList);
		exList.forEach(log::info);
		
		PageDTO pageDTO = new PageDTO(cri, this.exService.getTotalCount(cri));
		
		
		model.addAttribute("exList",exList);
		model.addAttribute("page",pageDTO);
	}//getList
	
	
	//상세일정페이지
	@GetMapping({"get","modify"})
	public void getSchedule(
			@ModelAttribute("cri")Criteria cri, 
			Integer exno, 
			Model model) throws Exception {
		log.debug("getSchedule(exno) invoked");
		
		ExhibitionVO exVO = this.exService.getSchedule(exno);
		
		model.addAttribute("schedule",exVO);
	}//getSchedule
	
	
	//게시판에서 일정등록
	@PostMapping("register")
	public String register( @ModelAttribute("cri") Criteria cri,
							ExhibitionDTO exDTO,
							RedirectAttributes rttrs) throws Exception {
		log.debug("register(exDTO) invoked",exDTO);
		
		this.exService.register(exDTO);

		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		
		return "redirect:/exhibition/list";
	}//getList
	
	
	//달력에서 일정등록ajax
	@PostMapping("calRegister")
	@ResponseBody
	public String calRegister(ExhibitionDTO exDTO) throws Exception {
		log.debug("calRegister({}) invoked",exDTO);
		
		log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+exDTO);
		
		this.exService.register(exDTO);
		
		return "success!";
	}//calRegister
	
	
	//게시판에서 일정수정
	@PostMapping("modify")
	public String modify(   @ModelAttribute("cri") Criteria cri,
							ExhibitionDTO exDTO,
							RedirectAttributes rttrs) throws Exception {
		log.debug("modify(exDTO) invoked",exDTO);
		
		this.exService.modify(exDTO);

		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/exhibition/list";
	}//getList
	
	//게시판에서 선택삭제
	@PostMapping("remove")
	public String remove(   @ModelAttribute("cri") Criteria cri,
							@RequestParam("exno") List<Integer> exnoList,
							RedirectAttributes rttrs) throws Exception {
		log.debug("remove(exDTO) invoked",exnoList);
		
		this.exService.remove(exnoList);

		rttrs.addAttribute("currPage", cri.getCurrPage());
		rttrs.addAttribute("amount", cri.getAmount());
		rttrs.addAttribute("pagesPerPage", cri.getPagesPerPage());
		
		return "redirect:/exhibition/list";
	}//getList
		
		
	//일정리스트ajax
	@PostMapping("calendar")
	@ResponseBody
	public String returnList() throws Exception {
		log.debug("returnList() invoked");
		
		//db데이터 끌어오기
		List<ExhibitionVO> exList = this.exService.getVisitList();
		
		List<FullCalendarDTO> calendarList = this.exService.getVisitPartList(exList);
		
		//데이터를 json으로 변환
		Gson gson = new Gson();
		String json = gson.toJson(calendarList);
		
		log.info(json);
		
		return json;
	}//getList
}//end class
