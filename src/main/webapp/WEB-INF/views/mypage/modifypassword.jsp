<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>비밀번호변경</title>

    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/mypage_modifypassword.css" rel="stylesheet" type="text/css">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
	<script src="/resources/js/top.js"></script>
</head>

<script>
    $(function(){
    	var tmp;
    	
        var subName = $('.subName').text();
        
        $('.chk').each(function(index,obj){
            var t = index;
            var o = $(this).text();
            console.log(t + ':' + o)
            if(o == subName) {
            	tmp = t;
            }
        });

        console.log(tmp)
        
        $('#parent').children().eq(tmp).children().css({
            'font-size': '18px',
            'font-weight':'bold',
            'background':'url(/resources/img/side_li_bg.jpg) no-repeat',
            'background-position': 'right center'
        });
        

    })//end jq
</script>
<script>
    var key = '${__KEY__}'
    var reloadKey;

    // --------------------------------------------------------------------------------------------------//
    // 0. Captcha 이미지 로드            
    // --------------------------------------------------------------------------------------------------//
    // =======인증 지연 때문에 주석처리 ===========
    // setTimeout(function () {
    //     console.debug('setTimeout() invoked.');
    //     $('#captcha').find('#capImg').attr('src','/resources/captcha/${__CAPTCHA_IMG__}'); 
    // }, 5000);//setTimeout

    $(function () {
        console.debug('jq started...1')
        
        var result = '${__RESULT__}';
        
        if(result.length>0){
            alert('${__RESULT__}');
        }//if

    });//.jq


</script>
<script src="/resources/js/mypage_modifypassword.js"></script>

<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">마이페이지</h2>
                <ul id="parent">
                    <li><a class="chk" href="/mypage/myInfo">회원정보변경</a></li>
                    <li><a class="chk" href="/mypage/modifypassword">비밀번호변경</a></li>
                    <li><a class="chk" href="/myBoard/list?memberid=${__LOGIN__.memberid}">내가쓴글</a></li>
                    <li><a class="chk" href="/mypage/replymanage">내가쓴댓글</a></li>
                    <li><a class="chk" href="/mypage/dropauth">회원탈퇴</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 마이페이지 > 비밀번호변경</div>
                    <h2 class="subName">비밀번호변경</h2>
                </div>

                <div class="contentIn">
                    <div id="wrapper">

                        <form action="/mypage/modifypassword" method="POST" id="modifyForm">
                            <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                            <div id="inner_con"> 
                                <h4>기존 비밀번호 </h4>
                                <input type="password" id="currPass" name="memberpw" autocomplete="off" placeholder=" 기존 비밀번호">
                                <h4>새 비밀번호 </h4>
                                <input type="password" id="newPass1" name="newMemberpw" autocomplete="off" placeholder=" 새 비밀번호">
                                <h4>새 비밀번호 확인</h4>
                                <input type="password" id="newPass2" autocomplete="off" placeholder=" 비밀번호 확인">
                                <h6 id="passwordInvalidMessage">&nbsp;</h6>
                                
                                <div id="captcha">
                                    
                                    <h6>아래의 이미지를 보이는 대로 입력해주세요.</h6>
                                    <div id="captcha_top">
                                        
                                        <!-- 인증지연때문에 주석처리 -->
                                        <!-- <img src="" alt="이미지 로드중입니다..." id="capImg" width="200" height="90"> -->
                                        <img src="/resources/img/pass_captcha.jpg" id="capImg" width="200" height="90">
                                        <div id="capBtn">
                                            <button type="button" id="captchaReloadBtn"><img src="/resources/img/mypage_modifypassword_refresh.png" alt="새로고침" width="15" height="15">새로고침</button>
                                            <button type="button" id="captchaBtn">인증</button>
                                        </div>
                                    </div>
                                  
                                    <input type="text" id="value" placeholder=" 자동입력 방지 문자">
                                </div>
                                <div id="buttons">
                                    <button type="button" id="modifyPasswordBtn">비밀번호 변경</button>
                                </div>
                                
                            </div>
                            
                        </form>
                    </div>
                
                </div>

            </div>
        </div>

   	<span id="top_btn">top</span>  
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>