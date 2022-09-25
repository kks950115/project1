package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.BoardReplyJoinVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;

public interface MyPageService {

	public boolean modifyPassword(MemberDTO dto) throws Exception;
	public String getEmail(MemberVO vo) throws Exception;
	public boolean fireMember(MemberVO vo) throws Exception;
	public List<BoardReplyJoinVO> getReplyList (Criteria cri,MemberVO vo) throws Exception;
	public int getReplyTotalCount(Criteria cri, MemberVO vo) throws Exception;
	public boolean removeReply(List<Integer> renoList) throws Exception;
}//end interface
