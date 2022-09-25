package com.korea.gfair.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyPageDTO;
import com.korea.gfair.domain.ReplyVO;
import com.korea.gfair.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor
@AllArgsConstructor

@RestController
@RequestMapping("/reply/")
public class ReplyController {
	@Setter(onMethod_= {@Autowired})
	private ReplyService replyService;
	
	@PostMapping(
			value = "/new",
			consumes = "application/json",
			produces = MediaType.TEXT_PLAIN_VALUE
		)
	public ResponseEntity<String> create(@RequestBody ReplyDTO dto){
		log.debug("create(dto) invoked.");
		log.info("\t+ ReplyDTO: {}", dto);
		
		int insertCount = this.replyService.register(dto);
		log.info("\t+ insertCount: " + insertCount);
		
		
		// 3항연산자 처리
		return insertCount == 1 ? 
				new ResponseEntity<>("success", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}//end class
	
	

	
//	@GetMapping(
//			value = "/pages/{bno}/{page}",
//			produces = {
//					MediaType.APPLICATION_JSON_VALUE
//					
//		})
//	public ResponseEntity<List<ReplyVO>> getList(
//			@PathVariable("page") Integer page,
//			@PathVariable("bno") Integer bno
//			){
//		log.debug("getList(page, bno) invoked.");
//		log.info("\t+ page: {}, bno: {}", page, bno);
//		
//		Criteria cri = new Criteria();
//		log.info("\t+ cri: " + cri);
//		
//		return new ResponseEntity<>(this.replyService.getList(cri, bno), HttpStatus.OK);
//	}//getList()
	
	
	@GetMapping(
			value = "/pages/{bno}/{page}",
			produces = {
					MediaType.APPLICATION_JSON_VALUE
					
		})
	public ResponseEntity<ReplyPageDTO> getListPerPage(
			@PathVariable("page") Integer page,
			@PathVariable("bno") Integer bno
			){
		log.debug("getList(page, bno) invoked.");
		log.info("\t+ page: {}, bno: {}", page, bno);
		
		Criteria cri = new Criteria();
		cri.setCurrPage(page);
		cri.setAmount(5);
		log.info("\t+ cri: " + cri);
		
		return new ResponseEntity<>(this.replyService.getListPerPage(cri, bno), HttpStatus.OK);
	}//getList()
	
	
	
	
	
	
	@GetMapping(
			value = "/{reno}",
			produces = {
					MediaType.APPLICATION_JSON_VALUE
			}) 
	public ResponseEntity<ReplyVO> get(@PathVariable("reno") Integer reno){
		log.debug("get(reno) invoked.");
		log.info("\t+ reno: " + reno);
		
		return new ResponseEntity<>(this.replyService.get(reno), HttpStatus.OK);
	}//get()
	
	
	
	
	@DeleteMapping(
			value = "/{reno}",
			produces = {MediaType.TEXT_PLAIN_VALUE}
		)
	public ResponseEntity<String> remove(@PathVariable("reno") Integer reno){
		log.debug("remove(reno) invoked.");
		log.info("\t+ reno: " + reno);
		
		
		return this.replyService.remove(reno) == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}//remove()
	
	
	@RequestMapping(method = {
			RequestMethod.PUT, RequestMethod.PATCH},
			value = "/{reno}",
			consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE}
		)
	public ResponseEntity<String> modify(
			@RequestBody ReplyDTO dto,
			@PathVariable("reno") Integer reno
		) {
		log.debug("modify(dto, reno) invoked.");
		
		dto.setReno(reno);
		log.info("\t+ dto: {}, reno: {}", dto, reno);
		
		
		
		return this.replyService.modify(dto) == 1 ?
				new ResponseEntity<>("success", HttpStatus.OK) :
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}//end class
