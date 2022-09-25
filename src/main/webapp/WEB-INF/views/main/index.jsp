<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
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
                    <li class="quick"><a href="#"><img src="/resources/img/quick_1.png" alt="">전시회 일정</a></li>
                    <li class="quick"><a href="#"><img src="/resources/img/quick_2.png" alt="">참가 신청</a></li>
                    <li class="quick"><a href="#"><img src="/resources/img/quick_3.png" alt="">사전관람 신청</a></li>
                    <li class="quick"><a href="#"><img src="/resources/img/quick_4.png" alt="">이벤트</a></li>
                    <li class="quick"><a href="#"><img src="/resources/img/quick_5.png" alt="">찾아오시는길</a></li>
                </ul>
            </div>
        </div>

        <div id="notice_Wrap">
            <div id="notice_Board">
                <h2><a href="#">공지사항</a></h2>
                <ul>
                    <li><a href="#">G-FAIR KOREA 2021 참가기업 모집 안내</a></li>
                    <li><a href="#">GFK-KOTRA : 대중 수출 온라인 컨설팅 사업 (모집~7.30.(금))</a></li>
                    <li><a href="#">GFK-KOTRA : 중국 알리바바그룹 B2B 플랫폼 1688.com 입점지원 (모집~7.31.(토))</a></li>
                    <li><a href="#">G-FAIR KOREA 온라인 화상상담회 개최 (7.26.(월) ~ 27.(화))</a></li>
                    <li><a href="#">포천시 단체관 참가 기업 모집 공고 (부스비 지원) (~07/23)</a></li>
                </ul>
            </div>
        </div>

        <div id="member_Join_Wrap">
            <div id="member_Join">
                <h3>지페어 코리아에 더 많은 정보를 얻고 싶으신가요?</h3>
                <div><a href="#" class="member_Join_btn">회원가입</a></div>
            </div>

        </div>



        <div class="partner">
            <div class="partnerBox">
              <ul>
                  <li class="p1"><a href="#" title="환경부 새창으로 열림" target="_blank"><img src="/resources/img/partner1.png" alt="" /></a></li>
                  <li class="p2"><a href="#" title="한국환경산업기술원 새창으로 열림" target="_blank"><img src="/resources/img/partner2.png" alt="" /></a></li>
                  <li class="p3"><a href="#" title="녹색성장 새창으로 열림" target="_blank"><img src="/resources/img/partner3.png" alt="" /></a></li>
                  <li class="p4"><a href="#" title="그린스타트 새창으로 열림" target="_blank"><img src="/resources/img/partner4.jpg" alt="" /></a></li>
                  <li class="p5"><a href="#" title="기후변화홍보포털 새창으로 열림" target="_blank"><img src="/resources/img/partner5.jpg" alt="" /></a></li>
                  <li class="p6"><a href="#" title="녹색성장포럼 새창으로 열림" target="_blank"><img src="/resources/img/partner8.jpg" alt="" /></a></li>
                  <li class="p7"><a href="#" title="국토해양부 새창으로 열림" target="_blank"><img src="/resources/img/partner7.jpg" alt="" /></a></li>
                  <li class="p8"><a href="#" title="Green Growth 새창으로 열림" target="_blank"><img src="/resources/img/partner8.jpg" alt="" /></a></li>
                  <li class="p1"><a href="#" title="환경부 새창으로 열림" target="_blank"><img src="/resources/img/partner1.jpg" alt="" /></a></li>
                  <li class="p2"><a href="#" title="한국환경산업기술원 새창으로 열림" target="_blank"><img src="/resources/img/partner2.png" alt="" /></a></li>
                  <li class="p5"><a href="#" title="기후변화홍보포털 새창으로 열림" target="_blank"><img src="/resources/img/partner5.jpg" alt="" /></a></li>
              </ul>
            </div>
          </div>       
		  <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>