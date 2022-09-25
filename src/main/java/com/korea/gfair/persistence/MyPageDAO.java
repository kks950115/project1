package com.korea.gfair.persistence;

import java.util.List;

import com.korea.gfair.domain.BoardReplyJoinVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;

public interface MyPageDAO {

	public boolean updatePassword(MemberDTO dto) throws Exception;
	public boolean updateDrop(MemberVO vo) throws Exception;
	public MemberVO selectEamil(MemberVO vo) throws Exception;
	public List<BoardReplyJoinVO> selectJoinReply(Criteria cri,MemberVO vo) throws Exception;
	public int selectReplyTotalCount(Criteria cri,MemberVO vo) throws Exception;
	public boolean deleteReply(List<Integer> renoList) throws Exception;

}//end interface
