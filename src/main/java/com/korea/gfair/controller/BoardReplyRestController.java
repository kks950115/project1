package com.korea.gfair.controller;


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
import com.korea.gfair.service.BoardReplyService;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor

@RequestMapping("/replies/")
@RestController	//Controller와는 다르게 rest를 붙이면 순수한 데이터가 된다!
public class BoardReplyRestController {

	
	@Autowired private BoardReplyService replyService;
	
	
//	댓글등록
	@PostMapping(value="new", 
				consumes = "application/json", 
				produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyDTO replyDTO){
		//@RequestBody를 쓰면 파라미터로 처리불가능! 직접 처리해야한다!
		log.debug("create({}) invoked",replyDTO);
		
		boolean result = this.replyService.replyRegister(replyDTO);
		
		return result ? 
				new ResponseEntity<>("success",HttpStatus.OK) 
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}//create
	
	
//	댓글리스트조회
	@GetMapping(value="/pages/{bno}/{page}",
			produces= { MediaType.APPLICATION_XML_VALUE,
						MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(
								@PathVariable("page")Integer page,
								@PathVariable Integer bno){
		//@PathVariable이게 있어야 파라미터형태를 처리가능하게 해준다!
		log.debug("getList({},{}) invoked",page,bno);
		
		Criteria cri = new Criteria();
		cri.setCurrPage(page);
		cri.setAmount(5);
		
		log.info("cri : "+cri);
		
		return new ResponseEntity<>(this.replyService.getReplyList(cri,bno),HttpStatus.OK);
	}//getList
	
	
//	댓글 한개 값
	@GetMapping(value="{reno}", 
				produces= {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("reno")Integer reno){
		log.debug("get({}) invoked",reno);
		
		return new ResponseEntity<>(this.replyService.replyGet(reno),HttpStatus.OK);
	}//get
	
	
//	댓글 삭제
	@DeleteMapping(value="{reno}",produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("reno") Integer reno){
		log.debug("remove({}) invoked",reno);
		
		boolean result = this.replyService.replyRemove(reno);
		
		return result ? 
				new ResponseEntity<>("success",HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}//remove
	
//	댓글 수정
	@RequestMapping(method = {RequestMethod.PUT,RequestMethod.PATCH}, 
					value="{reno}",
					consumes = "application/json",
					produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@PathVariable("reno") Integer reno,
										 @RequestBody ReplyDTO replyDTO){
		log.debug("modify({},{}) invoked/controller",replyDTO,reno);
		
		replyDTO.setReno(reno);
		boolean result = this.replyService.replyModify(replyDTO);
		
		return result ? 
				new ResponseEntity<>("success",HttpStatus.OK) 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}//modify
	
	
	
	
	
}//end class
