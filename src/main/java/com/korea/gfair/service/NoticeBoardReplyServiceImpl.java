package com.korea.gfair.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.ReplyDTO;
import com.korea.gfair.domain.ReplyVO;
import com.korea.gfair.mapper.NoticeBoardReplyMapper;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;


@Log4j2
@NoArgsConstructor
@Service
public class NoticeBoardReplyServiceImpl implements NoticeBoardReplyService {

	@Setter(onMethod_ = @Autowired)
	private NoticeBoardReplyMapper mapper;
	
    //=============================================
	// REPLY
	//=============================================
	@Override
	public boolean writeReply(ReplyDTO dto) {
		
		boolean isSuccess = this.mapper.replyInsert(dto);
		
		return isSuccess;
	}

	@Override
	public List<ReplyVO> getReply(ReplyDTO dto) {

		List<ReplyVO> list = this.mapper.replyList(dto);
		
		return list;
	}
	

	@Override
	public boolean removeReply(ReplyDTO dto) {
		
		boolean isSuccess = this.mapper.replyDelete(dto);
		
		return isSuccess;
	}

	@Override
	public void modifyReply(ReplyDTO dto) {
		this.mapper.updateReply(dto);
	}
	
}
