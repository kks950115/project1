package com.korea.gfair.mapper;

import org.apache.ibatis.annotations.Param;

import com.korea.gfair.domain.AttachFileDTO;
import com.korea.gfair.domain.LoginDTO;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;

public interface MemberMapper {

	//===========이진성============//
	public abstract int selectCheckCBNO(MemberDTO dto);
	public abstract int selectCheckID(MemberDTO dto);
	
	public abstract int selectCheckPhone(MemberDTO dto);
	
	public abstract void insertMember_c(MemberDTO dto);
	
	
	//파일처리
	public abstract void insertFile(AttachFileDTO dto);
	
	
	//===========로그인처리============//
	public abstract MemberVO selectUser(LoginDTO dto) throws Exception;
	
	//아이디찾기
	public abstract String selectFindID(MemberDTO dto);
	public abstract int selectCountEmail(MemberDTO dto);
	
	//비밀번호찾기
	public abstract int selectFindPW(MemberDTO dto);
	//비밀번호를 임시비밀번호로 변경
	public abstract void updatePW(MemberDTO dto);
	
	
	
	
	//===========김희용============//
	public abstract Integer selectMemberId(String memberid);			//아이디 중복 검사
	public abstract Integer selectEmail(String email);				 	//메일주소 중복 검사
	public abstract Integer selectPhone(String phone);					//연락처 중복검사
	public abstract void insertMember(MemberDTO dto);					//개인 신규회원 가입
	public abstract String selectFindId(String email);					//개인 아이디 찾기
	public abstract Integer selectFindPw(@Param("memberid")String memberid,@Param("email")String email);//개인 비밀번호 찾기
	public abstract Integer updatePw(@Param("memberid")String memberid,@Param("email")String email,@Param("pw")String pw);//개인 비밀번호 변경
    
	//===========원승대============//
    public abstract MemberVO get(String memberid);
	

}
