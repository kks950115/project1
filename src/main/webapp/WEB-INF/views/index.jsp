<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

    
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>G-FAIR KOREA</title>

    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/main.css" rel="stylesheet" type="text/css" />
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
    <script src="/resources/js/top.js"></script>
    
    <script src="/resources/js/movebanner.js" type="text/javascript"></script>

    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

</head>

<body>
    <div id="wrap">
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	
    <!-- Swiper -->
    <div class="swiper mySwiper">
        <div class="swiper-wrapper">
          <div class="swiper-slide"><img src="/resources/img/slide1.png" alt=""></div>
          <div class="swiper-slide"><img src="/resources/img/slide2.png" alt=""></div>
          <div class="swiper-slide"><img src="/resources/img/slide3.png" alt=""></div>
        </div>
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
        <div class="swiper-pagination"></div>
      </div>
      
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

        <!-- Swiper JS -->
        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

        <!-- Initialize Swiper -->
        <script>
        var swiper = new Swiper(".mySwiper", {
            spaceBetween: 30,
            centeredSlides: true,
            autoplay: {
            delay: 2500,
            disableOnInteraction: false,
            },
            pagination: {
            el: ".swiper-pagination",
            clickable: true,
            },
            navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
            },
        });
        </script>

        <div id="quick_Menu_Wrap">
            <div id="quick_Menu">
                <ul>
                    <li class="quick"><a href="/exhibition/calendar"><img src="/resources/img/quick_1.png" alt="">전시회 일정</a></li>
                    <li class="quick"><a href="/apply/app"><img src="/resources/img/quick_2.png" alt="">참가 신청</a></li>
                    <li class="quick"><a href="/pre/agreement"><img src="/resources/img/quick_3.png" alt="">사전관람 신청</a></li>
                    <li class="quick"><a href="/event/listPerPage"><img src="/resources/img/quick_4.png" alt="">이벤트</a></li>
                    <li class="quick"><a href="/page/traffic"><img src="/resources/img/quick_5.png" alt="">찾아오시는길</a></li>
                </ul>
            </div>
        </div>

        <div id="notice_Wrap">
            <div id="notice_Board">
                <h2><a href="/notice/list">공지사항</a></h2>
                <c:forEach items="${list}" var="board" begin="0" end="4">
                <ul>
                    <li><a href="/notice/get?bno=${board.bno}">${board.title}</a></li>
                </ul>
                </c:forEach>
            </div>
        </div>

        <div id="member_Join_Wrap">
            <c:choose>
            	<c:when test="${__LOGIN__.memberid == null}">
            		<div id="member_Join">
				        <h3>지페어 코리아에 더 많은 정보를 얻고 싶으신가요?</h3>
				        <div><a href="member/agreement" class="member_Join_btn">회원가입</a></div>
				    </div>
                </c:when>
                <c:otherwise>
                	<div id="member_Join">
		                <h3>지페어 코리아의 일정이 궁금하다면?</h3>
				        <div><a href="exhibition/calendar" class="member_Join_btn">일정조회</a></div>
				    </div>
                </c:otherwise>
            </c:choose>
        </div>



        <div class="partner">
            <div class="partnerBox">
              <ul>
                  <li><a href="https://www.bitcamp.co.kr/" title="비트캠프 새창으로 열림" target="_blank"><img src="/resources/img/partner1.png" alt="" /></a></li>
                  <li><a href="#" title="쓰담쓰담 새창으로 열림" target="_blank"><img src="/resources/img/partner2.png" alt="" /></a></li>
                  <li><a href="#" title="필미 새창으로 열림" target="_blank"><img src="/resources/img/partner3.png" alt="" /></a></li>
                  <li><a href="#" title="포조 열림" target="_blank"><img src="/resources/img/partner4.png" alt="" /></a></li>
                  <li><a href="https://www.kotra.or.kr/biz/" title="대한무역투자진흥공사 새창으로 열림" target="_blank"><img src="/resources/img/partner5.png" alt="" /></a></li>
                  <li><a href="http://www.motie.go.kr/www/main.do" title="산업통상자원부 새창으로 열림" target="_blank"><img src="/resources/img/partner6.png" alt="" /></a></li>
                  <li><a href="https://www.gg.go.kr/" title="경기도청 새창으로 열림" target="_blank"><img src="/resources/img/partner7.png" alt="" /></a></li>
                  <li><a href="https://www.okta.net/okta/" title="세계한인무역협회 새창으로 열림" target="_blank"><img src="/resources/img/partner8.png" alt="" /></a></li>
                  <li><a href="https://www.kintex.com/" title="킨텍스 새창으로 열림" target="_blank"><img src="/resources/img/partner9.png" alt="" /></a></li>
                  <li><a href="https://www.mss.go.kr/site/smba/main.do" title="중소벤처기업부 새창으로 열림" target="_blank"><img src="/resources/img/partner10.png" alt="" /></a></li>
                  <li><a href="https://www.gbsa.or.kr/index.do" title="경기도경제과학진흥원 새창으로 열림" target="_blank"><img src="/resources/img/partner11.png" alt="" /></a></li>
              </ul>
            </div>
          </div>
          <span id="top_btn">top</span>
		  <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>