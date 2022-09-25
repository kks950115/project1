<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>

    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
    <script src="/resources/js/top.js" type="text/javascript"></script>
</head>

<style>

</style>

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
        
        //iframe 높이 자동조절
        let iframe = document.getElementById("child-iframe"); 

        iframe.addEventListener('load', function() { 
            iframe.height = iframe.contentWindow.document.body.scrollHeight+300+ 'px'; 
            console.log(iframe.height);
            // iframe.style.width = iframe.contentDocument.body.scrollWidth + 'px'; 
        });
    })//end jq
</script>
<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">관리페이지</h2>
                <ul id="parent">
                    <li><a class="chk" href="/mypage/adminInfo">기본정보변경</a></li>
                    <li><a class="chk" href="/admin/memberList?membertype=개인">회원관리</a></li>
                    <li><a class="chk" href="/admin/memberBoard">회원글관리</a></li>
                    <li><a class="chk" href="/admin/memberReply">회원댓글관리</a></li>
                    <li><a class="chk" href="/admin/apply">참가기업관리</a></li>
                    <li><a class="chk" href="/exhibition/list">전시일정관리</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 관리페이지 > 기본정보변경 </div>
                    <h2 class="subName">기본정보변경</h2>
                </div>
               
                <div class="contentIn">
                    <iframe id="child-iframe" src="/mypage/checkPass" frameborder="0" width="1200" scrolling='no'></iframe>
                </div>

            </div>
        </div>

        <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>