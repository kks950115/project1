package com.korea.gfair.service;

import java.util.List;

import com.korea.gfair.domain.ApplyVO;
import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.domain.ReplyBoardVO;

public interface AdminService {
	public List<ApplyVO> getApplyInformation () throws Exception;
	public boolean modifyApplyStatus(List<Integer> applynoList) throws Exception;
	public boolean registerPaymentInfo(List<Integer> applynoList) throws Exception;
	public boolean modifyApplyPno(List<Integer> applynoList) throws Exception;
	public boolean modifyPaymentStatusAndApplyPaymentTF(List<Integer> applynoList) throws Exception;

	//이진성 - 관리자페이지 > 회원관리
	public List<MemberVO> getMemberList(String membertype);
	public void delMember(List<Integer> mnoList);
	public void rollbackMember(List<Integer> mnoList);
	public void changeMemberType(Integer mno, String membertype);
	public MemberVO showMember(Integer mno);
	
	//=========현아===========//
	//회원글 모두 조회
	public abstract List<BoardReplyCountVO> getMemberBoardList(Criteria cri) throws Exception;
	//전체글수
	public abstract Integer getMemberBoardTotalCount(Criteria cri) throws Exception;
	//선택삭제
	public abstract boolean memberBoardRemove(List<Integer> bnoList) throws Exception;
	//회원댓글 모두 조회
	public abstract List<ReplyBoardVO> getMemberReplyList(Criteria cri) throws Exception;
	//전체댓글수
	public abstract Integer getMemberReplyTotalCount(Criteria cri) throws Exception;
	//선택댓글삭제
	public abstract boolean memberReplyRemove(List<Integer> renoList) throws Exception;
	
	public abstract Integer getPaymentCheck(List<Integer> applynoList) throws Exception;
}//end interface
