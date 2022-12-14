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

		//????????? ???????????? ??????????????? dto??? ??????. 
		String currentPassword =UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw());
		dto.setMemberpw(currentPassword);
		
		HttpSession session =req.getSession();
		MemberVO sessionVO =(MemberVO)session.getAttribute("__LOGIN__");
		
		log.info("parameter dto password : {}",dto.getMemberpw());
		log.info("session dto password : {}", sessionVO.getMemberpw());
		
		
		//????????? ????????????????????? ??????????????? ????????? ??????????????? ??????????????? 
		if(sessionVO.getMemberpw().equals(dto.getMemberpw())) {
			
			
			//1. ??? ???????????? ????????? 
			String encodedNewPassword =
			UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(newMemberpw);
			//2. ??? ??????????????? dto set
			dto.setMemberpw(encodedNewPassword);  // 
			//3. ????????? ????????? ?????? 
			boolean result=this.service.modifyPassword(dto);
			
				if(result) {	//???????????? ????????? 
					attrs.addFlashAttribute("__RESULT__", "???????????? ?????? ??????");
					
					return "redirect:/login/login";
				}else {			//???????????? ?????????. 
					attrs.addFlashAttribute("__RESULT__",
							"????????? ???????????? ?????? ????????? ?????????????????????. ??????????????? ????????? ????????? ????????? ?????? ??????????????? ???????????????.");
					
					return "redirect:/mypage/modifypassword";
				}//if-else
			
			
		}else {//????????? ?????? ??????????????? ????????? ???. 
			attrs.addFlashAttribute("__RESULT__", "????????? ???????????????. ");
			return "redirect:/mypage/modifypassword";
		} //if else
		
	}//modifyPassword
	
	@GetMapping({"dropauth"})
	public void dropAuth() {	//?????? ???????????? ???????????? ??????. 
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
		
		if(!sessionVO.getMemberpw().equals(dto.getMemberpw())) {	//?????? ?????? ???????????? ????????????
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
		//1. session??? ????????? dto????????? email ???????????? 
		//------------------------------------------------------------------		
		String toEmail =this.service.getEmail(vo);
		//------------------------------------------------------------------		
		//2. email ??????
		//------------------------------------------------------------------
		log.debug("send() invoked.");

		Random random = new Random();
        int code = random.nextInt(888888) + 111111;
		
		String subject 	="???????????? ?????????.";
		String content 	="?????? ??????<br> <strong>?????? ??????: </strong>"+code;
		 
		String from   	="asdfghuiop123451@gmail.com";
//		String to		="daninoel125@gmail.com";
		
		try {
			
			MimeMessage mail = this.mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
			
			mailHelper.setFrom(from);
			mailHelper.setTo(toEmail);
			mailHelper.setSubject(subject);
			mailHelper.setText(content,true);
			
			this.mailSender.send(mail);	//?????? ????????? 
			
			
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
			attrs.addAttribute("__RESULT__","????????? ???????????? ?????? ????????? ?????????????????????.");
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
			attrs.addFlashAttribute("__RESULT__","??????????????? ?????????????????????.");
		}else {
			attrs.addFlashAttribute("__RESULT__","????????? ???????????? ?????? ????????? ?????????????????????. ?????? ??????????????????.");
		}//if-else
		
		return "redirect:/mypage/replymanage";
	}//replyDelete
	
	
	//=================== ?????? ===================//
	//=================== ?????? ===================//
	//??????API??????
	@PostMapping("jusoPopup")
	public void jusoPopup(String roadFullAddr) {
		log.debug("jusoPopup({}) invoked",roadFullAddr);
		
	}//jusoPopup
	
	
	//VIEW??? ?????????
	@GetMapping({"checkPass","jusoPopup","myInfo","adminInfo","mypageInfo"})
	public void VIEW() throws Exception{
		log.debug("VIEW : checkPass,jusoPopup,myInfo,adminInfo() invoked");
		
	}//VIEW
	
	//???????????? ?????????
	@PostMapping({"getPass"})
	@ResponseBody
	public String getPass(LoginDTO dto) throws Exception{//???????????? ?????????????????? ??????????????? ?????????
		log.debug("getPass() invoked",dto);
		
		MemberVO memberVO = this.memberService.searchMember(dto.getMemberid());
		String digest = UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw());
		
		log.info("pw : "+memberVO.getMemberpw().toString());
		log.info("digest:"+digest.toString());
		
		
		if(memberVO.getMemberpw().equals(digest)) {
			log.info("??????>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			return "success";
			
		}else {
			log.info("??????>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			
			return "fail";
		}//if-else
	}//checkPass
	
	
	//???????????? ??????????????? ?????? ????????? ?????? ??????
	@PostMapping("checkPass")
	public String checkPass(LoginDTO dto, Model model) throws Exception{
		log.debug("checkPass(dto,model) invoked");
		
		Objects.nonNull(this.memberService);
		log.info("\t+ memberService: "+this.memberService);
		
		String digest = UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw());
		dto.setMemberpw(digest);
		
		MemberVO user = this.memberService.login(dto);
		
		model.addAttribute("member",user);
		
		if(user != null) {//???????????? ???????????????! == ??????????????? ???????????????!
			
			return "/mypage/infoChange";
		}//if
		return "/mypage/checkPass";
	}//checkPass
	
	
	//??????????????????
	@PostMapping("infoChange")
	public String infoChange(MemberDTO memberDTO, @Nullable MultipartFile uploadFile) throws Exception{
		log.debug("infoChange({},{}) invoked",memberDTO,uploadFile);
		
		Objects.nonNull(this.memberService);
		
		this.memberService.memberModify(memberDTO,uploadFile);
		
		return "redirect:/mypage/checkPass";
	}//checkPass
	
	
	//?????????????????? ???????????? ?????????
	@GetMapping("sendMail")
	@ResponseBody
	public String sendMail(String email) throws Exception {
		log.debug("sendMail({}) invoked",email);
		
		return this.memberService.sendMail(email);
//			return "success";
	}//end class
	
	
	//????????? ???????????? ??????
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
	
	
	//?????????????????????, ?????????????????????, ????????????????????? ?????? --> ??????????????? ????????? ???
	@PostMapping("checkInfo")
	@ResponseBody
	public String checkInfo(MemberDTO memberDTO,String emailSub) throws Exception {
		log.debug("checkInfo({},{}) invoked",memberDTO,emailSub);
		
		memberDTO.setEmail(emailSub);//????????? ????????? ????????????
		
		return this.memberService.checkInfoCount(memberDTO).toString();//test = 0
	}//checkInfo
	
}//end class
