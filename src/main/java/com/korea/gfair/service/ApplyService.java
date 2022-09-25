package com.korea.gfair.service;

import java.util.List;

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

public interface ApplyService {

	public MemberVO getMemberInfo(MemberDTO dto) throws Exception;
	public List<BoothVO> getBoothList() throws Exception;
	public boolean applyExhibition(ApplyDTO dto) throws Exception;
	public boolean boothIsSelected(ApplyDTO dto) throws Exception;
	public List<ApplyVO> getApplyInfo(MemberVO dto) throws Exception;
	public List<ExhibitionVO> getExhibitionInfo() throws Exception;
	public PaymentVO getPaymentInfo(Integer applyno) throws Exception;

	//======현아
	//참가기업리스트
	public abstract List<ApplyFileVO> getCompanyList(Criteria cri, String applyname) throws Exception;
	//참가기업 상세청보
	public abstract ApplyMemberFileVO getCompany(Integer applyno) throws Exception;
	//참가기업수(최대6개월까지)
	public abstract Integer getTotalCount(String applyname) throws Exception;
}//end interface
