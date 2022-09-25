package com.korea.gfair.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Objects;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.client.ClientProtocolException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.Nullable;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.korea.gfair.domain.BoardReplyJoinVO;
import com.korea.gfair.domain.Criteria;
import com.korea.gfair.domain.LoginDTO;
import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.domain.MemberVO;
import com.korea.gfair.domain.PageDTO;
import com.korea.gfair.service.MemberService;
import com.korea.gfair.service.MyPageService;
import com.korea.gfair.util.ApiCaptchaImage;
import com.korea.gfair.util.ApiCaptchaNkey;
import com.korea.gfair.util.ApiCaptchaNkeyResult;
import com.korea.gfair.util.Captcha;
import com.korea.gfair.util.HomeTaxCBNO;
import com.korea.gfair.util.UUIDGenerator;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2

@RequestMapping("/mypage/")
@Controller
public class MyPageController {

	@Setter(onMethod_=@Autowired)
	MyPageService service;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired private MemberService memberService;

	
	
	@PostMapping("captchaAuth")
	public ResponseEntity<String> captchaAuth(
			String key, String value
			) {
		log.debug("captchaAuth(key = {}, value= {}) controller invoked..! ",key, value);
		
		String result =ApiCaptchaNkeyResult.getResult(key, value);
		
		log.info("result : {}", result);
		
		ResponseEntity<String> response = new ResponseEntity<>(result, HttpStatus.OK);
		
		
		return response;
	}//captcha
	
	@GetMapping("captchaReload")
	public ResponseEntity<String> captchaReload(Model model) {
		log.debug("captchaReload() invoked");
		
		String key =ApiCaptchaNkey.captchaNkey();
		String imgPathAndName=ApiCaptchaImage.getImageRequest(key);
		
		
		model.addAttribute("__KEY__", key);
		model.addAttribute("__CAPTCHA_IMG__",imgPathAndName);
		
		Captcha cap = new Captcha();
		cap.setImgPathAndName(imgPathAndName);
		cap.setKey(key);
		
		Gson gson = new Gson();
		String json=gson.toJson(cap);
		
		ResponseEntity<String> response = new ResponseEntity<>(json, HttpStatus.OK);
		
		return response;
	}//captchaImg
	
	@GetMapping("modifypassword")
	public void modifyPasswordUI(Model model) throws InterruptedException {
		String key =ApiCaptchaNkey.captchaNkey();
		String imgPathAndName=ApiCaptchaImage.getImageRequest(key);
		
		
		model.addAttribute("__KEY__", key);
		model.addAttribute("__CAPTCHA_IMG__",imgPathAndName);
		
	}//end class
	
	@PostMapping("modifypassword")
	public String modifyPassword(
			RedirectAttributes attrs, 
			MemberDTO dto, 
			String newMemberpw,
			HttpServletRequest req
			) throws Exception {
		
		log.debug("modifyPassword({},{}) invoked.", dto, newMemberpw);

		//기존의 비밀번호 암호화해서 dto에 저장. 
		String currentPassword =UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw());
		dto.setMemberpw(currentPassword);
		
		HttpSession session =req.getSession();
		MemberVO sessionVO =(MemberVO)session.getAttribute("__LOGIN__");
		
		log.info("parameter dto password : {}",dto.getMemberpw());
		log.info("session dto password : {}", sessionVO.getMemberpw());
		
		
		//입력한 기존비밀번호와 세션영역에 올라온 비밀번호가 일치했을때 
		if(sessionVO.getMemberpw().equals(dto.getMemberpw())) {
			
			
			//1. 새 비밀번호 암호화 
			String encodedNewPassword =
			UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(newMemberpw);
			//2. 새 비밀번호로 dto set
			dto.setMemberpw(encodedNewPassword);  // 
			//3. 서비스 메소드 호출 
			boolean result=this.service.modifyPassword(dto);
			
				if(result) {	//업데이트 성공시 
					attrs.addFlashAttribute("__RESULT__", "비밀번호 변경 성공");
					
					return "redirect:/login/login";
				}else {			//업데이트 실패시. 
					attrs.addFlashAttribute("__RESULT__",
							"요청을 처리하는 도중 문제가 발생하였습니다. 지속적으로 이러한 현상이 반복될 경우 관리자에게 문의하세요.");
					
					return "redirect:/mypage/modifypassword";
				}//if-else
			
			
		}else {//입력한 기존 비밀번호가 틀렸을 때. 
			attrs.addFlashAttribute("__RESULT__", "잘못된 접근입니다. ");
			return "redirect:/mypage/modifypassword";
		} //if else
		
	}//modifyPassword
	
	@GetMapping({"dropauth"})
	public void dropAuth() {	//회원 탈퇴메뉴 눌렀을때 화면. 
		log.debug("dropauth() invoked.");
		
	}//dropAuth
	
	@PostMapping({"drop"})
	public void passAuth(MemberDTO dto, HttpServletRequest req,Model model ) 
			throws NoSuchAlgorithmException, UnsupportedEncodingException {
		log.debug("passAuth({}) invoked.", dto);
		
		String currentPassword =UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw());
		dto.setMemberpw(currentPassword);
		
		HttpSession session =req.getSession();
		MemberVO sessionVO =(MemberVO)session.getAttribute("__LOGIN__");
		
		if(!sessionVO.getMemberpw().equals(dto.getMemberpw())) {	//만약 기존 비밀번호 틀릴경우
			model.addAttribute("__RESULT__","false");
		}//if
		
		
	}//passAuth
	
//	@Async
	@GetMapping("sendemail")
	public ResponseEntity<String> emailCode(HttpServletRequest req) throws Exception {
		log.debug("emailCode(req) invoked.");
		HttpSession session =req.getSession();
		
		MemberVO vo = (MemberVO)session.getAttribute("__LOGIN__");
		//------------------------------------------------------------------		
		//1. session에 올라간 dto이용해 email 가져오기 
		//------------------------------------------------------------------		
		String toEmail =this.service.getEmail(vo);
		//------------------------------------------------------------------		
		//2. email 발송
		//------------------------------------------------------------------
		log.debug("send() invoked.");

		Random random = new Random();
        int code = random.nextInt(888888) + 111111;
		
		String subject 	="인증번호 입니다.";
		String content 	="인증 메일<br> <strong>인증 코드: </strong>"+code;
		 
		String from   	="asdfghuiop123451@gmail.com";
//		String to		="daninoel125@gmail.com";
		
		try {
			
			MimeMessage mail = this.mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
			
			mailHelper.setFrom(from);
			mailHelper.setTo(toEmail);
			mailHelper.setSubject(subject);
			mailHelper.setText(content,true);
			
			this.mailSender.send(mail);	//메일 보내기 
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}//try-catch
		
		
		
		
		//"{\"result\" : \"true\"}"
		ResponseEntity<String> response = new ResponseEntity<>("{\"result\" :\""+code+"\"}", HttpStatus.OK);
		return response;
	}//emailCode
	
	
	@PostMapping("beforefire")
	public void beforefire() {
		log.debug("beforefire () invoked.");
	}//beforefire
	
	@PostMapping("fire")
	public String fire(HttpServletRequest req,RedirectAttributes attrs) throws Exception {
		log.debug("fire() invoked.");
		
		HttpSession session =req.getSession();
		
		MemberVO vo = (MemberVO)session.getAttribute("__LOGIN__");
		
		boolean result = this.service.fireMember(vo);
		
		if(result) {
			session.invalidate();
			return "/mypage/fired";
		}else {
			attrs.addAttribute("__RESULT__","요청을 처리하는 도중 문제가 발생하였습니다.");
			return "redirect:/mypage/beforefire";
		}//if-else
		
	}//fire
	
	@GetMapping("replymanage")
	public void replyManage(HttpServletRequest req,@ModelAttribute("cri") Criteria cri,Model model) throws Exception{
		log.debug("replyManage(req,{},model) invoked.",cri);
		
		HttpSession session =req.getSession();
		
		MemberVO vo = (MemberVO)session.getAttribute("__LOGIN__");
		
		PageDTO pageDTO = new PageDTO(cri,this.service.getReplyTotalCount(cri,vo));
		
		List<BoardReplyJoinVO> replyList =this.service.getReplyList(cri,vo);
		
		model.addAttribute("__REPLY__", replyList);
		model.addAttribute("__PAGE__",pageDTO);
	}//replyManage
	
	@PostMapping("replydelete")
	public String replyDelete(RedirectAttributes attrs, @RequestParam("reno") List<Integer> renoList) 
			throws Exception {
		log.debug("replyDelete({},{}) invoked.", attrs, renoList);
		
		log.info("reno list : {}", renoList.toString());
		log.info("reno length : {}",renoList.size());
		
		boolean result =this.service.removeReply(renoList);
		
		if(result) {
			attrs.addFlashAttribute("__RESULT__","성공적으로 삭제하였습니다.");
		}else {
			attrs.addFlashAttribute("__RESULT__","요청을 처리하는 도중 문제가 발생하였습니다. 다시 시도해주세요.");
		}//if-else
		
		return "redirect:/mypage/replymanage";
	}//replyDelete
	
	
	//=================== 현아 ===================//
	//=================== 현아 ===================//
	//주소API관련
	@PostMapping("jusoPopup")
	public void jusoPopup(String roadFullAddr) {
		log.debug("jusoPopup({}) invoked",roadFullAddr);
		
	}//jusoPopup
	
	
	//VIEW만 호출용
	@GetMapping({"checkPass","jusoPopup","myInfo","adminInfo","mypageInfo"})
	public void VIEW() throws Exception{
		log.debug("VIEW : checkPass,jusoPopup,myInfo,adminInfo() invoked");
		
	}//VIEW
	
	//패스워드 확인용
	@PostMapping({"getPass"})
	@ResponseBody
	public String getPass(LoginDTO dto) throws Exception{//전송받은 아이디값으로 패스워드를 알려줌
		log.debug("getPass() invoked",dto);
		
		MemberVO memberVO = this.memberService.searchMember(dto.getMemberid());
		String digest = UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw());
		
		log.info("pw : "+memberVO.getMemberpw().toString());
		log.info("digest:"+digest.toString());
		
		
		if(memberVO.getMemberpw().equals(digest)) {
			log.info("성공>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			return "success";
			
		}else {
			log.info("실패>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			return "fail";
		}//if-else
	}//checkPass
	
	
	//입력받은 패스워드로 회원 찾아서 정보 올림
	@PostMapping("checkPass")
	public String checkPass(LoginDTO dto, Model model) throws Exception{
		log.debug("checkPass(dto,model) invoked");
		
		Objects.nonNull(this.memberService);
		log.info("\t+ memberService: "+this.memberService);
		
		String digest = UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw());
		dto.setMemberpw(digest);
		
		MemberVO user = this.memberService.login(dto);
		
		model.addAttribute("member",user);
		
		if(user != null) {//로그인이 성공했다면! == 비밀번호가 일치한다면!
			
			return "/mypage/infoChange";
		}//if
		return "/mypage/checkPass";
	}//checkPass
	
	
	//회원정보변경
	@PostMapping("infoChange")
	public String infoChange(MemberDTO memberDTO, @Nullable MultipartFile uploadFile) throws Exception{
		log.debug("infoChange({},{}) invoked",memberDTO,uploadFile);
		
		Objects.nonNull(this.memberService);
		
		this.memberService.memberModify(memberDTO,uploadFile);
		
		return "redirect:/mypage/checkPass";
	}//checkPass
	
	
	//이메일인증시 인증코드 보내기
	@GetMapping("sendMail")
	@ResponseBody
	public String sendMail(String email) throws Exception {
		log.debug("sendMail({}) invoked",email);
		
		return this.memberService.sendMail(email);
//			return "success";
	}//end class
	
	
	//사업자 진위여부 체크
	@GetMapping("cbnoCheck")
	@ResponseBody
	public String cbnoCheck(String cbno) throws ClientProtocolException, IOException {
		log.debug("cbnoCheck({}) invoked",cbno);
		
		Double result = HomeTaxCBNO.homeTaxCBNO(cbno);
		
		log.info("result :"+result);
		
		if(result == null) {
			
			return "0";
		}else {
			return result.toString();
		}//if-else
	}//cbnoCheck
	
	
	//기존휴대폰번호, 기존이메일주소, 사업자등록번호 확인 --> 다른회원의 정보일 때
	@PostMapping("checkInfo")
	@ResponseBody
	public String checkInfo(MemberDTO memberDTO,String emailSub) throws Exception {
		log.debug("checkInfo({},{}) invoked",memberDTO,emailSub);
		
		memberDTO.setEmail(emailSub);//입력된 값으로 넣어주기
		
		return this.memberService.checkInfoCount(memberDTO).toString();//test = 0
	}//checkInfo
	
}//end class
