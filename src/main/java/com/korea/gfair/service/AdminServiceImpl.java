package com.korea.gfair.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.ApplyVO;
import com.korea.gfair.domain.BoardReplyCountVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.domain.ReplyBoardVO;
import com.korea.gfair.mapper.AdminMapper;
import com.korea.gfair.persistence.AdminDAO;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO dao;
	@Autowired private AdminMapper adminMapper;
	
	
	@Override
	public List<ApplyVO> getApplyInformation() throws Exception {
		log.debug("getApplyInformation() invoked.");
		
		return this.dao.selectApply();
	}//getApplyInformation

	@Override
	public boolean modifyApplyStatus(List<Integer> applynoList) throws Exception {
		log.debug("getApplyInformation() invoked.");
		
		return this.dao.updateApplyAgreeStatus(applynoList);
	}//modifyApplyStatus

	@Override
	public boolean registerPaymentInfo(List<Integer> applynoList) throws Exception {
		log.debug("getApplyInformation() invoked.");
		
		return this.dao.insertPayment(applynoList);
	}//registerPaymentInfo

	@Override
	public boolean modifyApplyPno(List<Integer> applynoList) throws Exception {
		log.debug("modifyApplyPno() invoked.");
		
		return this.dao.updateApplyPno(applynoList);
	}//registerPaymentInfo

	@Override
	public boolean modifyPaymentStatusAndApplyPaymentTF(List<Integer> applynoList) throws Exception {
		log.debug("modifyPaymentStatusAndApplyPaymentTF({}) invoked.",applynoList);
		
		boolean isPaymentStatus = this.dao.updatePaymentStatus(applynoList);
		boolean isPaymentTF		= this.dao.updateApplyPaymentTF(applynoList);
		
		return isPaymentStatus && isPaymentTF;
	}//modifyPaymentStatusAndApplyPaymentTF

	
	//이진성 - 관리자페이지 > 회원관리
	@Override
	public List<MemberVO> getMemberList(String membertype) {
		
		return this.dao.selectMemberList(membertype);
	}//getMemberList
	
	@Override
	public void delMember(List<Integer> mnoList) {
		this.dao.dropMember(mnoList);
	}//delMember
	
	@Override
	public void rollbackMember(List<Integer> mnoList) {
		this.dao.rollbackMember(mnoList);
	}//rollbackMember
	
	@Override
	public void changeMemberType(Integer mno, String membertype) {
		this.dao.changeMemberType(mno, membertype);
	}
	
	@Override
	public MemberVO showMember(Integer mno) {
		
		return this.dao.selectMember(mno);
	}

	//=======현아==========
	//=======현아==========
	@Override
	public List<BoardReplyCountVO> getMemberBoardList(Criteria cri) throws Exception {
		log.debug("getMemberBoardList() invoked.");
		
		return this.adminMapper.memberBoardList(cri);
	}//getMemberBoardList

	@Override
	public Integer getMemberBoardTotalCount(Criteria cri) throws Exception {
		log.debug("getMemberBoardTotalCount() invoked.");
		
		return this.adminMapper.memberBoardTotalCount(cri);
	}//getMemberBoardTotalCount

	@Override
	public boolean memberBoardRemove(List<Integer> bnoList) throws Exception {
		log.debug("memberBoardRemove() invoked.");
		
		return this.adminMapper.memberBoardDelete(bnoList);
	}//memberBoardRemove

	@Override
	public List<ReplyBoardVO> getMemberReplyList(Criteria cri) throws Exception {
		log.debug("getMemberReplyList() invoked.");
		
		return this.adminMapper.memberReplyList(cri);
	}//getMemberReplyList

	@Override
	public Integer getMemberReplyTotalCount(Criteria cri) throws Exception {
		log.debug("getMemberReplyTotalCount() invoked.");
		
		return this.adminMapper.memberReplyTotalCount(cri);
	}//getMemberReplyTotalCount

	@Override
	public boolean memberReplyRemove(List<Integer> renoList) throws Exception {
		log.debug("memberReplyRemove() invoked.");
		
		return this.adminMapper.memberReplyDelete(renoList);
	}



	@Override
	public Integer getPaymentCheck(List<Integer> applynoList) throws Exception {
		log.debug("getPaymentCheck() invoked.");
		return this.dao.selectPaymentCheckInt(applynoList);
	}//memberReplyRemove
}//end class
