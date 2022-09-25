package com.korea.gfair.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.korea.gfair.domain.MemberVO;

import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j2;

@NoArgsConstructor
@Log4j2
//역할:로그인/로그아웃 처리에 특화 된 인터셉터
@Component
public class RegisterInterceptor implements HandlerInterceptor{
	
	public static final String cbnoKey ="__CBNO__";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
	      log.debug("==================================================");
	      log.debug("1. preHandle(request, response, {}) invoked.", handler);
	      log.debug("==================================================");
	      
	      HttpSession session = request.getSession();
	      Long cbno = (Long) session.getAttribute(RegisterInterceptor.cbnoKey);
	      log.info("intercpetor cbno : " + cbno);
	      if(cbno != null) {   
	    	  log.info("사업자번호 인증을 마친 사용자입니다.");
	    	  
	    	  session.removeAttribute(RegisterInterceptor.cbnoKey);
	    	  return true;
	    	 
	      } else {
	    	  	log.info("사업자번호 인증을 안한 사용자 입니다.");
	    	 
				response.sendRedirect("/member/checkCBNO");
				log.info("Redirected to /member/checkCBNO");
	    	  return false;
	      }//if-else
	}//preHandle

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub\
	}
	
}
