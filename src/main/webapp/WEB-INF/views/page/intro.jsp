<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/intro.css">
    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
	<script src="/resources/js/top.js"></script>
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
        
    })//end jq
</script>
<body>
  <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">전시회 소개</h2>
                <ul id="parent">
                    <li><a class="chk" href="/page/intro">전시회안내</a></li>
                    <li><a class="chk" href="/page/history">연혁</a></li>
                    <li><a class="chk" href="/exhibition/calendar">전시회일정</a></li>
                    <li><a class="chk" href="/page/facilities">부대시설</a></li>
                    <li><a class="chk" href="/page/traffic">찾아오시는길</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 전시회 소개 > 전시회안내 </div>
                    <h2 class="subName">전시회안내</h2>
                </div>
                <div class="contentIn">
                    <div id="topmenu">
                        <p>전시회 안내</p> 
                        <span>About G-fair</span>
                    </div>
                    <div class="about_gfair">
                        <div class="about_gfair01">
                            <div class="about_gfair01_bg"></div>
                            <div class="about_gfair01_img">
                                <img src="/resources/img/kintexbg2.jpg" alt="kinteximg">
                            </div>
                            <div class="about_gfair01_info">
                                <ul>
                                    <li class="infolist_01">
                                        <span class="info_span01">명칭 :</span>
                                        <span class="infolist_01_01">G-FAIR KOREA</span>
                                    </li>
                                
                                    <li class="infolist_01">
                                        <span class="info_span01">장소 :</span>
                                        <span class="infolist_01_01">고양 KINTEX 제 1 전시장</span>
                                    </li>
                                </ul>
                                <ul>
                                    <li class="infolist_02">
                                        <span class="info_span01">기간 :</span>
                                        <span class="infolist_01_02">2021년 10월 28일 ~ 2021년 10 월 30일 </span>
                                    </li>
                                    <li class="infolist_02">
                                        <span class="info_span01">후원 :</span>
                                        <span class="infolist_01_02">산업통상자원부  중소벤처기업부  World-OKTA </span>
                                    </li>
                                    <li class="infolist_02">
                                        <span class="info_span01">주관 :</span>
                                        <span class="info_Institution">
                                            <img src="/resources/img/info_kotra.png" >
                                        </span> 
                                        <span class="info_Institution">
                                            <img src="/resources/img/info_ky.png" >
                                        </span>   
                                    </li>
                                </ul>

                            </div>
                        </div>
                        <div class="about_gfair02">
                            <ul>
                                <li class="title_box01">
                                    <div class="dia">
                                        <div class="diat">
                                            생활용품관
                                            <br>
                                            <br>
                                            유아+생활가전
                                         </div>
                                     </div>
                                </li>
                                <li class="title_box02">
                                    <div class="dia">
                                        <div class="diat">
                                            건강용품관
                                            <br>
                                            <br>
                                            헬스케어+레저
                                        </div>
                                    </div>
                                </li>
                                <li class="title_box03">
                                    <div class="dia">
                                        <div class="diat">
                                            주방용품관
                                            <br>
                                            <br>
                                            식품+주방용품
                                        </div>
                                    </div>
                                </li>
                                <li class="title_box04">
                                    <div class="dia">
                                        <div class="diat">
                                            뷰티용품관
                                            <br>
                                            <br>
                                            화장품+패션
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>

                        <div class="about_gfair03">
                            <ul>
                                <li class="topbro">
                                    브로슈어 <span>DOWNLOAD</span>
                                </li>
                                <li class="picBro">
                                    <img src="/resources/img/brobookf.png" alt="brobook">
                                </li>
                            
                                <li class="downbro">
                                    국문브로슈어 
                                    <a href="/resources/pdf/G-FAIR KOREA 2021 브로슈어.pdf"><span class="down1">DOWNLOAD</span></a>
                                </li>
                                <li class="downbro">
                                    영문브로슈어 
                                    <a href="/resources/pdf/G-FAIR_KOREA_2021_Brochure.pdf"><span class="down1">DOWNLOAD</span></a>
                                </li>
                                <li class="downbro">
                                    2020년 결과보고서 
                                    <a href="/resources/pdf/G-FAIR KOREA 2020 결과보고서.pdf"><span class="down2">DOWNLOAD</span></a>
                                </li>
                            </ul>
                        </div>
                    </div>

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