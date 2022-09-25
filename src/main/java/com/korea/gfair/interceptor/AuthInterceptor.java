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
//로그인/로그아웃 성공 여부를 체크하는 인터셉터
@Component
public class AuthInterceptor 
	implements HandlerInterceptor {
	
	
	public static final String requestURIKey = "__REQUEST_URI__";
	public static final String queryStringKey = "__QUERYSTRING__";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		log.debug("===============================================================");
		log.debug("1. preHandle(request, response, {}) invoked.", handler.getClass().getName());
		log.debug("===============================================================");
		
		
		//사용자가 로그인 성공한 상태인지 체크를 preHandle에서 하면 안된다!!
		//다른 Intercepter에서 해야만한다
		
		//이미 로그인에 성공한 유저인지 아닌지를 판단하겠다. ===> 인증(Authentication)
		HttpSession session = request.getSession();
		MemberVO user= (MemberVO) session.getAttribute(LoginInterceptor.loginKey);
		
		
		if(user != null) { //이전에 이미 로그인한 사용자이구나!
			log.info("Authnticated....OK!");
			
			return true;
		} else { //이전에 아직 로그인한 사용자가 아니구나 !  
			
	  		//=============================================//
			// 1. Original Request URI + 전송파라미터도 함께 저장(Session Scope)  
	  		//=============================================//
			String originalRequestURI = request.getRequestURI(); //원래의 요청 URI 획득
			String originalQueryString = request.getQueryString(); //원래의 query string을 획득
			
			session.setAttribute(requestURIKey, originalRequestURI);
			session.setAttribute(queryStringKey, originalQueryString);
			
			
	  		//=============================================//
	  		// N. To Redirect To login form (request uri : /user/login  
	  		//=============================================//
			response.sendRedirect("/login/login");
			log.info("Redirected to /login/login");
			
			return false; //현재 요청이 컨트롤러로 가지 못한다.
		}//if-else
		
	}//preHandle

	// 뒤의 컨트롤러 메소드 호출이 완료된 후, 그리고 View가 호출되기 전에 수행된다.
	// 단, 컨트롤러 메소드 수행에서 예외가 발생되지  말아야 한다.
	// 컨트롤러 메소드 수행에서 예외가 발생되면, 이 메소드는 수행되지 않는다.
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		log.debug("===============================================================");
		log.debug("2. postHandle(request, response, {}, {}) invoked.", handler.getClass().getName(), modelAndView);
		log.debug("===============================================================");
		
		//Session Scope에 UserVO 객체를 바인딩하는 작업
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO)modelAndView.getModelMap().get(LoginInterceptor.loginKey);
		if(user != null) {
			session.setAttribute(LoginInterceptor.loginKey, user);
			log.info("\t+ UserVO객체를 Session Scope에 바인딩 완료!");
		}
		
	}//postHandle

	
	// 뒤의 컨트롤러 메소드 수행시, 예외의 발생여부와 상관없이ㅡ View까지 호출된 후에 수행된다 
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

		log.debug("===============================================================");
		log.debug("3. afterCompletion(request, response, {}, {}) invoked.", handler.getClass().getName(), ex);
		log.debug("===============================================================");
		
		// 컨트롤러에 대한 예외 처리
		//    -> DB에 대한 로그를 남긴다 
		//    -> 에러페이지로 이동
		
	}//afterCompletion

	
}//end class
