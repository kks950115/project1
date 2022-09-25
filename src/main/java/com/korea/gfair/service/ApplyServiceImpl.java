package com.korea.gfair.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.korea.gfair.domain.ApplyDTO;
import com.korea.gfair.domain.ApplyFileVO;
import com.korea.gfair.domain.ApplyMemberFileVO;
import com.korea.gfair.domain.ApplyVO;
import com.korea.gfair.domain.BoothVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.ExhibitionVO;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.domain.PaymentVO;
import com.korea.gfair.persistence.ApplyDAO;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@Service
public class ApplyServiceImpl implements ApplyService {

	@Autowired
	ApplyDAO dao;
	
	@Override
	public MemberVO getMemberInfo(MemberDTO dto) throws Exception {
		log.debug("getMemberInfo({}) invoked.", dto);
		return this.dao.selectMemberInfo(dto);
	}//getMemberInfo

	@Override
	public List<BoothVO> getBoothList() throws Exception {
		log.debug("getBoothList() invoked.");
		
		return this.dao.selectBooth();
	}//getBoothList

	@Override
	public boolean applyExhibition(ApplyDTO dto) throws Exception {
		log.debug("applyExhibition({}) invoked.", dto);
		
		return this.dao.insert(dto);
	}//applyExhibition

	@Override
	public boolean boothIsSelected(ApplyDTO dto) throws Exception {
		log.debug("boothIsSelected({}) invoked.", dto);
		
		return this.dao.updateBooth(dto);
	}//boothIsSelected

	@Override
	public List<ApplyVO> getApplyInfo(MemberVO vo) throws Exception {
		log.debug("getApplyInfo({}) invoked.", vo);
		
		return this.dao.selectApplyInfo(vo);
	}//getApplyInfo

	@Override
	public List<ExhibitionVO> getExhibitionInfo() throws Exception {
		log.debug("getExhibitionInfo() invoked.");
		
		return this.dao.selectExhibition();
	}//getExhibitionInfo

	@Override
	public PaymentVO getPaymentInfo(Integer applyno) throws Exception {
		log.debug("getPaymentInfo({}) invoked.", applyno);
		
		return this.dao.selectPaymentInfo(applyno);
	}//getExhibitionInfo

	
	@Override
	public List<ApplyFileVO> getCompanyList(Criteria cri, String applyname) throws Exception {
		log.debug("getApplyList({}) invoked.", applyname);
		
		return this.dao.applyList(cri, applyname);
	}//getApplyList

	@Override
	public ApplyMemberFileVO getCompany(Integer applyno) throws Exception {
		log.debug("getApply({}) invoked.", applyno);
		
		return this.dao.applyGet(applyno);
	}//getApply

	@Override
	public Integer getTotalCount(String applyname) throws Exception {
		log.debug("getTotalCount({}) invoked.", applyname);
		
		return this.dao.totalCount(applyname);
	}//getTotalCount

}//end class
