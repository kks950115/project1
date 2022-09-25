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

@Log4j2
@NoArgsConstructor
@Component
public class AdminInterceptor implements HandlerInterceptor {
	//=========================================================
	//<!-- = 1. 관리자가 아닌 아이디로 접근 시에 페이지 접근 막기 = -->
	//<!-- = 2. 관리자가 아닌 아이디로 접근 시에 로그인 창으로 이동 = -->
	//<!-- = 3. 로그인이 안되어 있다면 로그인 창으로 이동 = -->
	//=========================================================	
	
	public static final String requestURIKey = "__REQUEST_URI__";
	public static final String queryStringKey = "__QUERYSTRING__";

	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO) session.getAttribute(LoginInterceptor.loginKey);
		

		if(user != null) {
			if(user.getMemberid().equals("admin")) { //admin이면
				log.info("admin계정입니다");
				return true;
			} else {
				log.info("admin계정이 아닙니다");
				response.sendRedirect("/");
				log.info("Redirected !!");
				return false;
			}
		} else {
			
			String originalRequestURI = request.getRequestURI(); //원래의 요청 URI 획득
			String originalQueryString = request.getQueryString(); //원래의 query string을 획득
			
			session.setAttribute(requestURIKey, originalRequestURI);
			session.setAttribute(queryStringKey, originalQueryString);
			
			
			log.info("세션이 비어있음 ");
			response.sendRedirect("/login/login");
			log.info("Redirected to /login/login");
			return false;
		}
		
		
		
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}



}
