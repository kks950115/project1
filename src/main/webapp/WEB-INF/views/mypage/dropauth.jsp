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
    <link href="/resources/css/mypage_dropauth.css" rel="stylesheet" type="text/css">
    
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
    $(function () {
        $('#passBtn').on('click',function () {
            console.debug('passBtn event triggered');
                var pass =$('#memberpw').val();
                
                if(pass.length >0){
                    let form =$('#passAuth');
                    form.submit();
                }else{
                    alert('잘못된 접근입니다.')
                }//if
        });//onclick


    })//.jq
</script>

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
                    <div class="map">home > 마이페이지 > 회원탈퇴</div>
                    <h2 class="subName">회원탈퇴</h2>
                </div>

                <div class="contentIn">
                    <div id="wrapper">
                        <div id="inner_con">
                            <h2>회원탈퇴를 위해 비밀번호를 인증해주세요</h2>
            
                            <form action="/mypage/drop" method="POST" id="passAuth">
                                <div>
                                    <h4>비밀번호</h4>
                                    <input type="password" id="memberpw" name="memberpw">
                                </div>
                                
                                <div id="buttons">
                                    <button type="button" id="passBtn">확인</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

            </div>
        </div>

   	<span id="top_btn">top</span>  
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>