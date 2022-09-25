package com.korea.gfair.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.BoardReplyJoinVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.persistence.MyPageDAO;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@Service
public class MyPageServiceImpl implements MyPageService {

	@Autowired
	MyPageDAO dao;
	
	@Override
	public boolean modifyPassword(MemberDTO dto) throws Exception {
		log.debug("modifyPassword({}) invoked.", dto);
		
		return this.dao.updatePassword(dto);
	}//modifyPassword

	@Override
	public String getEmail(MemberVO memberVO) throws Exception {
		log.debug("getEmail({}) invoked.", memberVO);
		MemberVO vo = this.dao.selectEamil(memberVO);
		
		return vo.getEmail();
	}//getEmail

	@Override
	public boolean fireMember(MemberVO vo) throws Exception {
		log.debug("fireMember({}) invoked.", vo);
		
		return this.dao.updateDrop(vo);
	}//modifyPassword

	@Override
	public List<BoardReplyJoinVO> getReplyList(Criteria cri,MemberVO vo) throws Exception {
		log.debug("getReplyList({}) invoked.", vo);
		
		
		return this.dao.selectJoinReply(cri,vo);
	}//getReplyList

	@Override
	public int getReplyTotalCount(Criteria cri, MemberVO vo) throws Exception {
		log.debug("getReplyTotalCount({}) invoked.", vo);
		
		return this.dao.selectReplyTotalCount(cri,vo);
	}//getReplyList

	@Override
	public boolean removeReply(List<Integer> renoList) throws Exception {
		log.debug("removeReply({}) invoked.", renoList);
		
		return this.dao.deleteReply(renoList);
	}//removeReply

}//end class
