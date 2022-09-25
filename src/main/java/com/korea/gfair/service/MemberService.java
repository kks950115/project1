package com.korea.gfair.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.web.multipart.MultipartFile;

import com.korea.gfair.domain.LoginDTO;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;

public interface MemberService {
	
	//===========이진성===========//
	//===========이진성===========//
	public abstract int checkCBNO(MemberDTO dto);
	public abstract int checkID(MemberDTO dto);
	
	public abstract int checkPhone(MemberDTO dto);
	
	//public abstract Double homeTaxCBNO(MemberDTO dto) throws ClientProtocolException, IOException;
	
	public abstract void sendMail(MemberDTO dto, HttpSession session);
	
	public abstract boolean emailCertifiation(HttpSession session, String inputCode, String userEmail);
	
	//회원가입
	public abstract void register(MemberDTO dto) throws NoSuchAlgorithmException, UnsupportedEncodingException;
	//해쉬 다이제스트 단방향 암호화 알고리즘
	//public abstract String digest(String memberpw) throws NoSuchAlgorithmException, UnsupportedEncodingException;

	
	
	//로그인 부분
	public abstract MemberVO login(LoginDTO dto) throws Exception;
	
	
	
	//아이디찾기
	public abstract String find_id_c(MemberDTO dto);
	public abstract int isExistEmail(MemberDTO dto);
	
	//비번찾기
	public abstract int find_pw_c(MemberDTO dto);
	//이메일발송 for 비번찾기
	public abstract void sendMailForPw(MemberDTO dto) throws NoSuchAlgorithmException, UnsupportedEncodingException ;

	
	
	
	//=================김희용====================//
	//=================김희용====================//
    public abstract void sendMailAuth(MemberDTO dto,HttpSession session) throws MessagingException;         //메일발송
    public abstract Integer memberIdCheck(String memberid);                                    				//아이디 중복 검사
    public abstract Integer emailCheck(String email);                                       				//이메일 중복 검사
    public abstract Integer phoneCheck(String phone);                                       				//연락처 중복 검사
    public abstract boolean authKeyCheck(HttpSession session,String email, String inputCode);       		//인증키 검사
    public abstract void memberJoin(MemberDTO dto);                                          				//회원가입
    public abstract String memberIdFind(String email) throws IOException;                        			//개인회원 아이디 찾기   
    public abstract Integer memberPwFind(String memberid,String email);                           			//개인 비밀번호 찾기(정보검색)
    public abstract Integer newPassword(String memberid,String email,String pw) throws NoSuchAlgorithmException, UnsupportedEncodingException; //비밀번호찾기시 비밀번호변경                                            //비밀번호 변경
    public abstract void sendMailPw(HttpSession session,String memberid,String email,String pw);            //비밀번호 메일발송 
	   
    
	//=================원승대====================//
	//=================원승대====================//
    public abstract MemberVO get(String memberid);
	
	
    //=================나현아====================//
    //=================나현아====================//
    //회원정보 변경
  	public abstract boolean memberModify(MemberDTO memberDTO, @Nullable MultipartFile uploadFile) throws Exception;
  	//인증메일보내기
  	public abstract String sendMail(String email) throws Exception;//인증코드메일 보내기
  	//아이디로 패스워드찾기 --> 검증용
  	public abstract MemberVO searchMember(String memberid) throws Exception;//아이디로 패스워드찾기
  	//기존휴대폰번호, 기존이메일주소, 사업자등록번호 DB중복저장 확인
  	public abstract Integer checkInfoCount(MemberDTO memberDTO) throws Exception;


}//end interface
