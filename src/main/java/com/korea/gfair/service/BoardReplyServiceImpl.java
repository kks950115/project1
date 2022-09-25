package com.korea.gfair.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyPageDTO;
import com.korea.gfair.domain.ReplyVO;
import com.korea.gfair.mapper.BoardReplyMapper;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor
@Service
public class BoardReplyServiceImpl implements BoardReplyService {

	
	@Setter(onMethod_=@Autowired)
	private BoardReplyMapper replyMapper;
	
	
	@Override
	public ReplyPageDTO getReplyList(Criteria cri, Integer bno) {
		log.debug("getReplyList() invoked");
		
		Objects.nonNull(replyMapper);
		
		ReplyPageDTO replyPageDTO = 
				new ReplyPageDTO(this.replyMapper.totalCount(bno), this.replyMapper.replyList(cri,bno));
		
		return replyPageDTO;
	}//getReplyList

	
	@Override
	public boolean replyRegister(ReplyDTO replyDTO) {
		log.debug("replyRegister() invoked");

		Objects.nonNull(replyMapper);
		
		ReplyVO reply = new ReplyVO(null, 
									replyDTO.getBno(), 
									replyDTO.getRecontent(), 
									replyDTO.getMemberid(), 
									replyDTO.getRedate());
		
		return this.replyMapper.replyInsert(reply);
	}//replyRegister

	
	@Override
	public boolean replyRemove(Integer reno) {
		log.debug("replyRemove() invoked");

		Objects.nonNull(replyMapper);
		
		return this.replyMapper.replyDelete(reno);
	}//replyRemove



	@Override
	public Integer getTotalCount(Integer bno) {
		log.debug("getTotalCount() invoked");
		
		return this.replyMapper.totalCount(bno);
	}//getTotalCount
	

	@Override
	public List<BoardReplyCountVO> getBoardReplyCnt(Criteria cri, String bname) {
		log.debug("getBoardReplyCnt() invoked");
		
		return this.replyMapper.boardReplyCnt(cri, bname);
	}//getBoardReplyCnt


	@Override
	public ReplyVO replyGet(Integer reno) {
		log.debug("replyGet() invoked");
		
		return this.replyMapper.replySelect(reno);
	}//replyGet


	@Override
	public boolean replyModify(ReplyDTO replyDTO) {
		log.debug("replyModify({}) invoked",replyDTO);
		
		ReplyVO reply = new ReplyVO(
				replyDTO.getReno(), 
				replyDTO.getBno(), 
				replyDTO.getRecontent(), 
				replyDTO.getMemberid(), 
				replyDTO.getRedate());
		
		log.info("1. reply: "+reply);
		return this.replyMapper.replyUpdate(reply);
	}//replyModify


	
}//end class
