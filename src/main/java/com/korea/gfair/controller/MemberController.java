package com.korea.gfair.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.client.ClientProtocolException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.korea.gfair.domain.MemberDTO;
import com.korea.gfair.interceptor.FindInfoInterceptor;
import com.korea.gfair.interceptor.RegisterInterceptor;
import com.korea.gfair.service.MemberService;
import com.korea.gfair.service.UploadFileService;
import com.korea.gfair.util.ApiCaptchaImage;
import com.korea.gfair.util.ApiCaptchaNkey;
import com.korea.gfair.util.ApiCaptchaNkeyResult;
import com.korea.gfair.util.HomeTaxCBNO;
import com.korea.gfair.util.UUIDGenerator;

import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@NoArgsConstructor

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	//=================== 진성 ===================//
	//=================== 진성 ===================//
	private static final String loginKey = "__LOGIN__";
	private String key;
	
	@Setter(onMethod_ = @Autowired)
	private MemberService reg_service;
	
	@Setter(onMethod_ = @Autowired)
	private UploadFileService file_service; 
	
	@GetMapping("agreement")
	public void agreement() {
		log.debug("agreement() invoked.");
	}
	
	@GetMapping("member_type")
	public void member_type() {
		log.debug("member_type() invoked.");
	}
	
	@GetMapping("completed")
	public void completed() {
		log.debug("completed() invoked.");
	}
	
	@GetMapping("checkCBNO")
	public void checkCBNO() {
		log.debug("checkCBNO() invoked.");
	}
	
	
	// ID중복체크 검사
	@ResponseBody
	@PostMapping("checkID")
	public String checkID(MemberDTO dto) {
		log.debug("checkID() invoked.");
		
		int check = this.reg_service.checkID(dto);
		
		if(check == 0) {
			return "ok";
		} else {
			return "fail";
		}
		
	}
	
	// PHONE 중복 체크 검사 
	@ResponseBody
	@PostMapping("checkPhone")
	public String checkPhone(MemberDTO dto) {
		int check = this.reg_service.checkPhone(dto);
		
		if(check == 0) {
			return "ok";
		} else {
			return "fail";
		}
	}
	
	
	@GetMapping("join_c")
	public void join_c() {
		log.debug("join_c() invoked.");
		
		
		
		
//		String imgPathAndName = ApiCaptchaImage.getImageRequest(key);
//		model.addAttribute("__CAPTCHA__", "/resources/captcha/"+imgPathAndName);
		
	}
	
	//이미지 발급 역할
	@ResponseBody
	@PostMapping("captchaImg")
	public String captchaImg() {
		
		
//		String path = session.getServletContext().getRealPath("/");
		
		key = ApiCaptchaNkey.captchaNkey();
		String imgPathAndName = ApiCaptchaImage.getImageRequest(key);
		
		
		if(key != null) {
			
			return "/resources/captcha/"+imgPathAndName;
//			return "/img/" + imgPathAndName;
//			return "/Users/jinsung/Desktop/opt/eclipse/workspace/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/gfair/captcha/"+imgPathAndName;
		} else {
			return "fail";
		}
		
	}
	
	@ResponseBody
	@PostMapping("captcha") //입력 코드 체크만 하는역할
	public String captcha(String captcha) {
		
		
		
		String result = ApiCaptchaNkeyResult.getResult(key, captcha, "");
		
		if(result == "true") {
			return "ok";
		} else {
			return "fail";
		}
	}
	
	
	@PostMapping("join_cc")
	public String join_cc(MemberDTO dto, @RequestParam("file") MultipartFile file) throws Exception {
		
		this.file_service.uploadFileByRegister(dto, file);
		
		this.reg_service.register(dto);
		
		return "redirect:/member/completed";
	}
	
	
	
	//사업자등록번호 DB중복검사
	@ResponseBody
	@PostMapping("doubleCheckCBNO")
	public int doubleCheckCBNO(MemberDTO dto) {
		log.info("!@#@#@! > cbno : " + dto.getCbno());
		int check = this.reg_service.checkCBNO(dto);
		
		if(check == 0) {
			return 1; //가입이 안되어있는 사용자면 1반환 
		} else {
			return 0; //가입되어있다면 0반환 
		}
		
	}
	
	//사업자등록번호 API 유효성 검사
	@ResponseBody
	@PostMapping("homeTaxCBNO")
	public String homeTaxCBNO(MemberDTO dto, HttpSession session) throws ClientProtocolException, IOException {
		
		//Double tmp = this.reg_service.homeTaxCBNO(dto);
		Double tmp = HomeTaxCBNO.homeTaxCBNO(Long.toString(dto.getCbno()));
		log.info("API 수행 결과 : " + tmp);
		if(tmp != null) { //매칭이되면 1
			session.setAttribute(RegisterInterceptor.cbnoKey, dto.getCbno());
			return "ok";
		} else { //매칭이 안되면 0 
			return "fail";
		}
	}
	
	
	@ResponseBody
	@PostMapping("sendMail")
	public void sendMail(MemberDTO dto, HttpSession session) {
		
		
		
		this.reg_service.sendMail(dto, session);
		
	}
	
	@ResponseBody
	@PostMapping("emailCertification")
	public String emailCertification(HttpSession session, String inputCode, String userEmail) {
		
		
		boolean result = this.reg_service.emailCertifiation(session, inputCode, userEmail);
		
		log.info("(**) Controller result : " + result);
		log.info("(**) Controller InputCODE : " + inputCode);
		
		if(result == true) {
			return "ok"; 
		} else {
			return "fail";
		}
		
	}//emailCertification
	
	@ResponseBody
	@PostMapping("removeSession")
	public String removeSession(HttpSession session, String inputCode, String userEmail) {
		
		
		
		/*
		 세션 remove 하면 emailCertification 수행 시에 null값 전달로인해 NullPointerException 발생,
		 따라서 세션 remove가 아닌 난수값으로 재설정 하는식으로...
		 */
//		session.removeAttribute("auth");
		
		String randomString = UUID.randomUUID().toString();
		session.setAttribute(userEmail, randomString);
		log.info("%%% value = " + session.getAttribute(userEmail));
		if((String)session.getAttribute(userEmail) != inputCode) {
			return "ok";
		} else {
			return "fail";
		}
	}//인증 부분 - 세션 삭제
	
	
	//아이디찾기
	@GetMapping("find_id_c")
	public void find_id_c() {
		
	}
	
	@ResponseBody
	@PostMapping("isExistEmail")
	public String isExistEmail(MemberDTO dto) {
		Integer result = this.reg_service.isExistEmail(dto);
		
		if(result == 1) {
			return "ok";
		} else {
			return "fail";
		}
	}
	
	@PostMapping("find_id_c")
	public String find_id_c(MemberDTO dto, RedirectAttributes rttrs, HttpSession session) {
		
		String user = this.reg_service.find_id_c(dto);
		
		if(user != "fail") {
			rttrs.addFlashAttribute("find", user);
			session.setAttribute(FindInfoInterceptor.findKey, user);
		}
		
		return "redirect:/member/find_id_c_result"; 
		 
	}
	
	//아이디 찾기 결과
	@GetMapping("find_id_c_result")
	public void find_id_c_result() {
		
	}
	
	//비밀번호 찾기
	@GetMapping("find_pw_c")
	public void find_pw_c() {
		
	}
	
	@ResponseBody
	@PostMapping("find_pw_c")
	public String find_pw_c(MemberDTO dto) {
		int result = this.reg_service.find_pw_c(dto);
		
		if(result == 1) {
			return "ok";
		} else {
			return "fail";
		}
	}
	
	@ResponseBody
	@PostMapping("sendMailForPw")
	public void sendMailForPw(MemberDTO dto) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		this.reg_service.sendMailForPw(dto);
	}
	
	@GetMapping("find_type")
	public void find_type() {
		
	}
	
	
	
	
	//=================== 희용 ===================//
	//=================== 희용 ===================//

	@GetMapping("/find_id_p")
	public void find_id_p() {


	}
	
	@PostMapping("/find_id_p_result")
	public String find_id_p(String email, RedirectAttributes rttrs, HttpServletResponse response) throws IOException {
		
		String result = reg_service.memberIdFind(email);

		rttrs.addFlashAttribute("id", result);	
		return "redirect:/member/find_id_p_result";
		
	}//find_id_p
	
	@GetMapping("/find_id_p_result")
	public void find_id_p_result() {
		
	}//개인 아이디 찾기 결과 페이지
	@GetMapping("/find_pw_p")
	public void find_pw_p() {
		
	}
	
	@ResponseBody
	@PostMapping("/find_pw_p")
	public String find_pw_p(String memberid,String email,HttpSession session) {
		log.info("############"+memberid);
		log.info("############"+email);
		
		Random random = new Random();
		String pw = Integer.toString(random.nextInt(888888)+111111);  //새로운 비밀번호 변경
		
		
		session.setAttribute("pw", pw);
		int result = reg_service.memberPwFind(memberid,email);
		
		
		if(result == 1) {
			return "success";
		}else {
			return "false";
			
		}//if-else
	}//find_pw_p


	@ResponseBody
	@PostMapping("/sendMailPw")
	public String sendMailPw(HttpSession session,String memberid,String email) throws Exception {
		
		String password = (String)session.getAttribute("pw");				//패스워드 난수값 얻기
		int result = reg_service.newPassword(memberid, email, password);	//비밀번호 암호화
		reg_service.sendMailPw(session, memberid, email, password);			//임시 비밀번호 메일 발송
		
			log.info("!!!!!!!!"+result);
			if(result == 1) {
				
				return "success";
			}else {
				return "false";
			}//if-else

	}
	
	@PostMapping("/find_pw_p_result")
	public void find_pw_p_result() {
		
		
	}
	
	
	@GetMapping("/join_p")
	public void join_p() {
		
	}//join_p	
	
	@ResponseBody
	@PostMapping("/send")
	public void send(MemberDTO dto,HttpSession session) throws MessagingException {
		
		reg_service.sendMailAuth(dto, session);
		
	}//send
	
	@ResponseBody
	@PostMapping("/memberIdChk")
	public String memberIdChk(@RequestParam("memberid") String memberid) throws Exception {
		log.info("#"+ memberid);
		int result = reg_service.memberIdCheck(memberid);
		// result = 1  이메일 존재
		// result = 0  이메일 없음
		
		if(result == 0) {
			return "success";	//아이디 생성 가능
		
		}else {
			return "fail";		//중복아이디 존재
		}//if-else
	}//memberIdChk
	
	@ResponseBody
	@PostMapping("/emailChk")
	public String emailChk(@RequestParam("email") String email) {

		int result = reg_service.emailCheck(email);
		// result = 1  이메일 존재
		// result = 0  이메일 없음
		
		if(result == 0) {
			return "success";
		
		}else {
			return "fail";
		}//if-else
	}//emailChk
	
	@ResponseBody
	@PostMapping("/phoneChk")
	public String phoneChk(@RequestParam("phone") String phone) {
		
		int result = reg_service.phoneCheck(phone);
		
		if(result == 0) {
			return "success";
			
		}else {
			return "fail";
		}//if-else
		
	}//phoneChk
	
	@ResponseBody
	@PostMapping("/authKey")
	public String authKey(String authKey,HttpSession session, String email) {
		
		boolean check = reg_service.authKeyCheck(session, email, authKey );
		
		if(check == true) {
			
			return "success";
		}else {
			return "fail";
		}//if-else
	}//authKey
	
	
	@PostMapping("/join_p")
	public String memberJoin(MemberDTO dto) throws NoSuchAlgorithmException, UnsupportedEncodingException {
		String result = UUIDGenerator.generateUniqueKeysWithUUIDAndMessageDigest(dto.getMemberpw());
		
		dto.setMemberpw(result);
		
		reg_service.memberJoin(dto);
		
		return "redirect:/member/completed";
		
	}//memberJoin

	
}
