<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>
	 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/traffic.css">
    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
     <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
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
 	$(document).ready(function() {
 		  $('ul.dropdownmenu li ul').hide();

 		  $('ul.dropdownmenu').hover(
 		  function() { 
 		      $('ul.dropdownmenu li.menu ul').fadeIn('slow',function(){$(this).stop();});
 		      $('.header_wapper').animate({height:200},'fast').clearQueue();
 		      },
 		      function() {
 		      $('ul.dropdownmenu li.menu ul').fadeOut('fast');
 		      $('.header_wapper').animate({height:200},'fast').clearQueue();
 		      });


 		      $(".tab_content").hide();
 		      $(".tab_content").eq(0).show();
 		     
 		     
 		      $("ul.tabs li").click(function(){
 		          $("ul.tabs li").removeClass("active")
 		          $(this).addClass("active")
 		          $(".tab_content").hide();
 		          var tabid = $(this).attr("rel");
 		          $("#"+tabid).fadeIn();
 		        })

 		        //2번째 탭  >> 자차 

 		      $(".tab_content_2").hide();
 		      $(".tab_content_2").eq(0).show();
 		     
 		     
 		      $("ul.tabs_2 li").click(function(){
 		          $("ul.tabs_2 li").removeClass("active")
 		          $(this).addClass("active")
 		          $(".tab_content_2").hide();
 		          var tabid = $(this).attr("rel");
 		          $("#"+tabid).fadeIn();
 		      });


 		          //3번째 탭  >> 대중교통

 		          $(".tab_content_3").hide();
 		          $(".tab_content_3").eq(0).show();
 		         
 		         
 		          $("ul.tabs_3 li").click(function(){
 		              $("ul.tabs_3 li").removeClass("active")
 		              $(this).addClass("active")
 		              $(".tab_content_3").hide();
 		              var tabid = $(this).attr("rel");
 		              $("#"+tabid).fadeIn();
 		          });
 		   
 		    });

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
                    <div class="map">home > 전시회 소개 > 찾아오시는길 </div>
                    <h2 class="subName">찾아오시는길</h2>
                </div>
                <div class="contentIn">
                    <div id="topmenu">
                        <p>찾아오시는길</p> 
                        <span>Traffic Information</span>
                    </div>

                    <div class="tap_all_wrap">
                        <ul class="tabs">
                            <li class="active" rel="tab1"> 지도 </li>
                            <li rel="tab2">자차 이용</li>
                            <li rel="tab3">대중 교통</li>
                        </ul>
                        <div class="tab_wrap">
                            <div id="tab1" class="tab_content">
                                
                                <div id="map" >
                                    <div id="daumRoughmapContainer1630476541297" class="root_daum_roughmap root_daum_roughmap_landing"></div>
                                        <script charset="UTF-8">
                                            new daum.roughmap.Lander({
                                                "timestamp" : "1630476541297",
                                                "key" : "277qj",
                                                "mapWidth" : "1000",
                                                "mapHeight" : "500"
                                            }).render();
                                        </script>
                                    
                                    <table id="map_table">
                                        <tbody>
                                            <tr>
                                                <th>
                                                전시장 위치
                                                </th>
                                                <td>
                                                    경기 고양시 일산서구 킨텍스로 217-60
                                                </td>
                                            </tr>

                                            <tr>
                                                <th>연락처</th>
                                                <td>
                                                    G-FAIR KOREA 사무국 (Tel. 031-259-6539)
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div><!-- tab 1 _map-->   
                            </div>

                            <div id="tab2" class="tab_content">
                                <div class="tap_all_wrap_2">
                                    <ul class="tabs_2">
                                        <li class="active" rel="tab1_2">올림픽 대로</li>
                                        <li rel="tab2_2">경기 북/남</li>
                                        <li rel="tab3_2">인천/김포 공항</li>
                                    </ul>
                                    <div class="tab_wrap_2">
                                        <div id="tab1_2" class="tab_content_2">
                                            <div id="car_1">
                                                <img src="/resources/img/parking_user_olympic_highway.jpg">
                                            </div>
                                        </div>
                                        <div id="tab2_2" class="tab_content_2">
                                            <div id="car_2">
                                                <img src="/resources/img/parking_user_capital_01.jpg">
                                            </div>
                                        </div>
                                        <div id="tab3_2" class="tab_content_2">
                                            <div id="car_3">
                                                <img src="/resources/img/parking_user_capital_02.jpg">
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div><!--2번 탭-->


                            <div id="tab3" class="tab_content">
                                <div class="tap_all_wrap_3">
                                    <ul class="tabs_3">
                                        <li class="active" rel="tab1_3"> 버스 </li>
                                        <li rel="tab2_3"> 지하철 </li>
                                        <li rel="tab3_3"> KTX </li>
                                    </ul>
                                    <div class="tab_wrap_3">
                                        <div id="tab1_3" class="tab_content_3">
                                            <div id="public_1">
                                                <a href="https://map.naver.com/v5/bus/bus-route/?c=14148979.0663618,4507603.5031196,15,0,0,0,dh"><img src="/resources/img/parking_transportation_bus1.jpg"></a>
                                            </div>
                                        </div>
                                        <div id="tab2_3" class="tab_content_3">
                                            <div id="public_2">
                                                <a href="https://map.naver.com/v5/subway/1000/entry/310?c=14148979.0663618,4507603.5031196,15,0,0,0,dh">
                                                <img src="/resources/img/parking_transportation_subway1.jpg"></a>
                                            </div>
                                        </div>
                                        <div id="tab3_3" class="tab_content_3">
                                            <div id="public_3">
                                                <a href="https://map.naver.com/v5/subway/1000/entry/310?c=14148979.0663618,4507603.5031196,15,0,0,0,dh">
                                                <img src="/resources/img/parking_transportation_ktx1.png"></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> <!--3번 탭-->
                        </div> <!--tab_wrap-->
                    </div> <!--tap_all_wrap-->

                    <div id="topmenu">
                        <p>주차장 안내</p> 
                        <span>Parking Information</span>
                    </div>

                    <div class="parkingInfo">
                        <div class="parkingInfo_1">
                            <img src="/resources/img/parking_user_visual.jpg" alt="parking">
                        </div>
                        <div class="parkingInfo_2">
                            <a href="https://iparking.co.kr/mobile/arf/core/pay/selfPaymentFormMug.do?park_seq=1885">
                            <div id="parkingPay">
                                    <span>주차비 결제</span>
                            </div>
                        </a>
                        </div>
                    </div><!--parking info-->

                    <div id="topmenu">
                        <p>요금 안내</p> 
                        <span>Price Information</span>
                    </div>
                    <div class="parkingPrice">
                        <table class="price_table">
                            <thead>
                                <tr>
                                    <th colspan="2">구분</th>
                                    <th>주차요금</th>

                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th rowspan="2">
                                        일반 요금
                                        <br>
                                        전용주차장
                                    </th>
                                    <td>승용,승합차 
                                        <br> 
                                        소형화물 (2.5톤 미만)
                                    </td>
                                    <td>기본 30분 : 1,500원
                                        <br>
                                        추가 10분당 : 500원
                                        <br>
                                        일일요금 : 12,000원
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        대형화물(2.5톤 이상)
                                        <br>
                                        버스(25인승 이상)
                                    </td>
                                    <td>
                                        기본 30분 : 3,000원
                                        <br>
                                        추가 10분당 : 1,000원
                                        <br>
                                        일일요금 : 24,000원
                                    </td>
                                </tr>


                                <tr>
                                    <th rowspan="2">
                                        일반 요금
                                        <br>
                                        하역장
                                    </th>
                                    <td>승용,승합차 
                                        <br> 
                                        화물 톤수 구분 없음
                                    </td>
                                    <td>기본 30분 : 1,500원
                                        <br>
                                        추가 10분당 : 500원
                                        <br>
                                        일일요금 : 12,000원
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        버스 25인승 이상
                                    </td>
                                    <td>
                                        기본 30분 : 3,000원
                                        <br>
                                        추가 10분당 : 1,000원
                                        <br>
                                        일일요금 : 24,000원
                                    </td>
                                </tr>


                            
                                <tr>
                                    <th rowspan="3">
                                        할인대상
                                    </th>
                                    <td>
                                        국가유공자 차량, 장애인 차량, 경차
                                        <br>
                                        저공해 차량 (하이브리드/전기차)
                                    </td>
                                    <td>
                                        50% 할인
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        전시업체 및 관련업체
                                        <br>
                                        3일이상 주차시
                                    </td>
                                    <td>
                                        승용, 승합, 소형화물 : 7,000원/일
                                        <br>
                                        대형화물, 버스 : 14,000원/일
                                        <br>
                                        ※ 단, 행사차량 등록 신청서 작성 후 주차사무실 직접 제출하는 경우에 한해 적용
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        하역장 이용차량
                                        <br>
                                        (전시 및 행사용 차량)
                                    </td>
                                    <td>
                                        화물차량 일괄 2시간 무료/일
                                        <br>
                                        ※단, 하역장에 한해 적용
                                    </td>
                                </tr>

                            </tbody>
                        </table>

                        <ul class="table_bottom_list">
                            <li>중복할인은 되지 않습니다.</li>
                            <li>사전무인정산기를 이용, 정산 후 출차 시 여유시간 30분을 인정합니다.</li>
                            <li>행사권 구입은 선납을 원칙으로 하며 환불은 되지 않습니다.</li>
                            <li>입차 후 20분 이내 출차 시 주차요금이 부과되지 않으나, 20분 초과 시 최초 입차시간부터 계산, 정상요금이 부과됩니다.</li>
                            <li>이 외 행사주최자 지원 및 기타 문의는 아래 기재된 연락처로 연락주시면 친절히 안내드리도록 하겠습니다.</li>
                            <li>(제1전시장 주차관리사무실 Tel:031-995-8265, 제2전시장 주차관리사무실 Tel:031-995-7265)</li>
                        </ul>
                    </div>
                </div><!--contentIn-->
            </div>
        </div>

   	<span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>