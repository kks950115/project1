package com.korea.gfair.persistence;

import com.korea.gfair.domain.MemberVO;


public interface MemberDAO {
	
	public abstract boolean memberUpdate(MemberVO memberVO) throws Exception;
	
	public abstract MemberVO getMember(String memberid) throws Exception;
	
	public abstract Integer checkInfoCount(MemberVO memberVO) throws Exception;

}//end interface
