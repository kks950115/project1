package com.korea.gfair.interceptor;

import java.io.PrintWriter;

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
public class LoginInterceptor 
   implements HandlerInterceptor {
   
   public static final String loginKey ="__LOGIN__";
   
   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
         throws Exception {
      log.debug("==================================================");
      log.debug("1. preHandle(request, response, {}) invoked.", handler);
      log.debug("==================================================");
      

      //사용자가 로그인 성공한 상태인지 체크 ---- XX : 여기서하면 안된다!!
      //다른 Interceptor에서 해야만 하는일임
         // ---> 즉, 이 인터셉터는 사용자가 로그인/로그아웃 했는지 안했는지만 체크할 뿐,
         // 사용자가 로그인한 상태인지, 아닌지는 다른 인터셉터(Authintercepter)에서 수행한다. 
      HttpSession session = request.getSession();
      MemberVO user = (MemberVO) session.getAttribute(LoginInterceptor.loginKey);
      if(user != null) {   //로그인 성공했다면..
    	 // 위에서 말했듯이 사용자가 로그인한 상태인지 아닌지 체크하는건 다른 인터셉터(Authintercepter)에서 수행한다.
    	     // ----> 따라서 session 을 사용할 필요가 없기 때문에 세션에 바인딩되어있는 속성을 삭제한다.
    	  //다른 사용자가 이전에 로그인했던 기록이 있었을수도 있기때문에 우선 세션스콥을 날리고 본다 
         session.removeAttribute(LoginInterceptor.loginKey);
         log.info("\t+ 기존에 바인딩된 UserVO 객체를 Session Scope에서 삭제완료.");
      }//if

      return true;

   }//preHandle

   //뒤 컨트롤러 메소드가 호출이 완료 된 후 그리고 VIEW 가 호출되기전에 수행.
   //단 컨트롤러 메소드 수행에서 예외가 발생되지 말아야함
   //컨트롤러 메솓 ㅡ수행에서 예외가 발생되면 이 메소드는 수행되지 않음.
   
   
   
   @Override
   public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
         ModelAndView modelAndView) throws Exception {
	  
	  
      log.debug("==================================================");
      log.debug("2. postHandle(request, response, {}, {}) invoked.", handler, modelAndView);
      log.debug("==================================================");
      
      //Session Scope에 UserVO 객체를 바인딩하는 작업
      HttpSession session = request.getSession();
      
      MemberVO user = (MemberVO)modelAndView.getModelMap().get(loginKey);
      if(user != null) {   //로그인 성공했다면
         
  		//=============================================//
  		// 1. Session Scope에 로그인 정보로, UserVO 객체를 바인딩  
  		//=============================================//
         session.setAttribute(LoginInterceptor.loginKey, user);
         log.info("\t+ 기존에 바인딩된 UserVO 객체를 Session Scope에서 바인딩 완료.");
         
 		//=============================================//
 		// 2. 원래 사용자의 Request URI를 복구하여, 이동시킴  
 		//=============================================//
         String originalRequestURI = (String)session.getAttribute(AuthInterceptor.requestURIKey);
         String originalQueryString = (String)session.getAttribute(AuthInterceptor.queryStringKey);
         
         if(originalRequestURI != null) { // 원래의 요청URI가 없었다면 .. (**GET방식만 고려**)
        	 response.sendRedirect(originalRequestURI + 
        			 				(originalQueryString != null && !"".equals(originalQueryString) ? "?"+originalQueryString : "") 
        	 );
        	 
        	 log.info("\t+ 2. 원래의 요청 URI({})로 강제이동시킴.", originalRequestURI);
        	 
         } else { //처음부터 사용자가 로그인 창에서 로그인 수행했다면 ...
        	 
        	 log.info("\t + 2. 사용자가 로그인부터 수행해서 들어옴.");
        	 
         } //if-else
         
      } else { //로그인에 실패했다면 ..
		  //response.setCharacterEncoding("utf-8");
		  response.setContentType("text/html; charset=utf-8");
    	  
    	  PrintWriter out = response.getWriter();
    	  
    	  try(out){

    		  out.println("<script>alert('아이디/비밀번호를 확인해주세요.'); location.href='/login/login';</script>");
        	  
        	  // postHandle 메소드가 수행되는 지점과 싯점을 잘 기억하셔야 합니다 
        	  //response.sendRedirect("/login/login");
        	  
        	  log.info("\t+ 1. 로그인 실패 - 다시 로그인 창으로 되돌림.");
    	  }

      }// if-else
      
   }//postHandle

   
   @Override
   public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception e)
         throws Exception {

      log.debug("==================================================");
      log.debug("3. afterCompletion(request, response, {}, {}) invoked.", handler, e);
      log.debug("==================================================");
      
      //컨트롤러에 대한 예외처리
      //(1) DB에 발생 예외의 로그를 남김
      //(2) 에러페이지로 이동
      
   }//afterCompletion

   
}//end class