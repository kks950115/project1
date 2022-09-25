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
    <link href="/resources/css/mypage_drop.css" rel="stylesheet" >
   
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>

    <script src="/resources/js/mypage_drop.js"></script>
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
        var result ='${__RESULT__}';

        if(result.length>0){
        alert('잘못된 접근입니다.')
        location.href="/mypage/dropauth";
        }//if

    });//jq
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
                            <form action="/mypage/beforefire" method="POST" id="dropForm">
                                <h2>회원탈퇴에 앞서 <strong>유의사항 및 안내</strong>를 반드시 읽고 진행해주세요.</h2>
                                <div id="info_agree">
                                    <div class="info_user">
                                        <strong>1. G-FAIR 아이디 재사용 및 복구 불가 안내.</strong> <br> 
                                        회원탈퇴 진행 시 본인을 포함한 타인 모두 <em>아이디 재사용이나 복구가 불가능합니다.</em> 신중히 선택하신 후 결정해주세요. <br>
                                    </div>
                                    <div class="info_user">
                                        <strong>2. 개인 정보 및 서비스 이용기록 삭제 안내.</strong> <br>
                                        전시 참가 내역, 전시회 신청 정보가 삭제 되며 <em>삭제된 데이터는 복구되지 않습니다. </em>
                                    </div>
                                    <div class="info_user">
                                        <strong>3. 게시판형 서비스에 등록한 게시글, 댓글 삭제 불가 안내</strong><br>
                                        삭제를 원하는 게시글이 있다면 반드시 회원탈퇴 전 비공개 처리하거나 삭제하시기 바랍니다.<br>
                                        탈퇴후에는 회원정보가 삭제되어 본인 여부를 확인할 수 있는 방법이 없어 <em>게시글을 임의로 삭제해드릴 수 없습니다.</em> 
                                    </div>
                                    <div id="info_user_check">
                                        <h3>위의 사항에 동의합니다.</h3>
                                        <input type="checkbox" name="agreement" id="agreement">
                                    </div>
                                    
                                </div>
                                <div id="emailbox">
                                    <div id="formdata">
                                        <h4>본인확인을 위해 이메일 인증을 진행합니다.</h4>
                                        <div class="buttons">
                                            <button type="button" id="emailSendBtn">인증번호 발송</button>
                                        </div>
                                        
                                    </div>
                                    <div id="formdata2">
                                        <input type="text" name="emailValue" id="emailValue" placeholder="인증번호를 입력하세요">
                                    </div>
                                    <div class="buttons">
                                        <button type="button" id="emailAuthAndNextBtn">다음</button>
                                    </div>
            
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