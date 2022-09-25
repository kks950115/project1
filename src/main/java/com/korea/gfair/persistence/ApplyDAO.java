package com.korea.gfair.persistence;

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

public interface ApplyDAO {
	
	public MemberVO selectMemberInfo(MemberDTO dto) throws Exception;
	public List<BoothVO> selectBooth () throws Exception;
	public boolean insert(ApplyDTO dto) throws Exception;
	public boolean updateBooth(ApplyDTO dto) throws Exception;
	public List<ApplyVO> selectApplyInfo(MemberVO dto) throws Exception;
	public List<ExhibitionVO> selectExhibition() throws Exception;
	public PaymentVO selectPaymentInfo(Integer applyno) throws Exception; 
	
	//======현아
	//참가기업리스트
	public abstract List<ApplyFileVO> applyList(Criteria cri, String applyname) throws Exception;
	//참가기업 상세청보
	public abstract ApplyMemberFileVO applyGet(Integer applyno) throws Exception;
	//참가기업수
	public abstract Integer totalCount(String applyname) throws Exception;
}//end interface
