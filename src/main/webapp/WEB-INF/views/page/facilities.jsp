<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/facilities.css">
    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
     <script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
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
                    <div class="map">home > 전시회 소개 > 부대시설 </div>
                    <h2 class="subName">부대시설</h2>
                </div>
                <div class="contentIn">
                
                    <div id="topmenu">
                        <p>부대 시설</p> 
                        <span>facilities Information</span>
                    </div>


                    <div class="facilities_pic">
                        <img src="/resources/img/convenient_01_food_facility_map.jpg">
                    </div>

                    <div class="tap_all_wrap">
                        <ul class="tabs">
                            <li class="active" rel="tab1"> 일반음식 </li>
                            <li rel="tab2">카페</li>
                            <li rel="tab3">편의점</li>
                        </ul>
                        <div class="tab_wrap">
                            <div id="tab1" class="tab_content">
                                <div class="restaurant" id="restaurant_1">
                                    <h3>전주단지네</h3>
                                    <ul class="restaurant1_ul">
                                       <li><img src="/resources/img/res_1_1.JPG"></li> 
                                       <li><img src="/resources/img/res_1_2.JPG"></li> 
                                    </ul>

                                    <table class="restaurant_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    1
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>1층옆 (1층) </td>
                                                <th>운영시간</th>
                                                <td>09:00 ~ 18:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    031-995-8388
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>80명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">콩나물밥, 낙지볶음 
                                                
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>
                                </div>
                                <div class="restaurant" id="restaurant_2">
                                    <h3>본도시락</h3>
                                    <ul class="restaurant2_ul">
                                       <li><img src="/resources/img/res_2_1.JPG"></li> 
                                       <li><img src="/resources/img/res_2_2.JPG"></li> 
                                    </ul>

                                    <table class="restaurant_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    6
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>2홀 앞 (1층) </td>
                                                <th>운영시간</th>
                                                <td>09:00 ~ 18:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    031 995 8390
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>64명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">도시락
                                                
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>
                                </div>
                                <div class="restaurant" id="restaurant_3">
                                    <h3>푸드코트 앨리시온</h3>
                                    <ul class="restaurant3_ul">
                                       <li><img src="/resources/img/res_3_1.JPG"></li> 
                                       <li><img src="/resources/img/res_3_2.JPG"></li> 
                                    </ul>

                                    <table class="restaurant_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    11
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>201호 회의실 앞 (2층) </td>
                                                <th>운영시간</th>
                                                <td>11:00 ~ 18:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    031 995 8342
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>400명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">비빔밥, 우거지탕, 우동, 돈까스 외 (저녁식사 예약가능) 
                                                
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>
                                </div>
                                <div class="restaurant" id="restaurant_4">
                                    <h3>본우리반상</h3>
                                    <ul class="restaurant4_ul">
                                       <li><img src="/resources/img/res_4_1.JPG"></li> 
                                       <li><img src="/resources/img/res_4_2.JPG"></li> 
                                    </ul>

                                    <table class="restaurant_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    1
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>208호 회의실 앞 (2층) </td>
                                                <th>운영시간</th>
                                                <td>10:00 ~ 18:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    031-995-8383
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>180명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">곤드레밥, 설렁탕  
                                              
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>
                                </div>
                          
                            </div><!-- tab 1 -->   
                          
                            <div id="tab2" class="tab_content">
                                <div class="cafe" id="cafe_1">
                                    <h3>던킨도너츠</h3>
                                    <ul class="cafe_ul">
                                       <li><img src="/resources/img/cafe1.JPG"></li> 
                                       
                                    </ul>

                                    <table class="cafe_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    3
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>2층 앞 (1층) </td>
                                                <th>운영시간</th>
                                                <td>09:00 ~ 18:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    031-995-8307
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>48명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">커피, 도넛
                                              
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>
                                </div>

                                <div class="cafe" id="cafe_2">
                                    <h3>아이엠커피</h3>
                                    <ul class="cafe_ul">
                                       <li><img src="/resources/img/cafe2.JPG"></li> 

                                    </ul>

                                    <table class="cafe_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    4
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>4홀 앞 (1층) </td>
                                                <th>운영시간</th>
                                                <td>09:00 ~ 18:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    031-995-8717
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>50명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">커피, 주스, 케이크 등
                                           
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                               


                                <div class="cafe" id="cafe_3">
                                    <h3>뚜레쥬르</h3>
                                    <ul class="cafe_ul">
                                       <li><img src="/resources/img/cafe4.JPG"></li> 

                                    </ul>

                                    <table class="cafe_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    5
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>5홀 앞 (1층) </td>
                                                <th>운영시간</th>
                                                <td>09:00 ~ 18:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    031-995-8366
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>50명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">빵, 케이크, 커피류, 선물용 외
                                               
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>
                                </div>


                                <div class="cafe" id="cafe_4">
                                    <h3>카페베네</h3>
                                    <ul class="cafe_ul">
                                       <li><img src="/resources/img/cafe5.JPG"></li> 

                                    </ul>

                                    <table class="cafe_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    7
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>7홀 앞 (1층) </td>
                                                <th>운영시간</th>
                                                <td>09:00 ~ 18:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    031-995-8328
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>80명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">커피, 디저트
                                          
                                                </td>
                                            </tr>
                                        </tbody>

                                    </table>
                                </div>

                               
                           

                                
                            </div>

                            </div><!--2번 탭-->

                            <div id="tab3" class="tab_content">
                                
                                <div class="convenient" id="convenient_1">
                                    <h3>CU 1호점</h3>
                                    <ul class="convenient_ul">
                                       <li><img src="/resources/img/convenient_01_01.JPG"></li> 
                                       <li><img src="/resources/img/convenient_01_02.JPG"></li> 
                                       
                                    </ul>

                                    <table class="convenient_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    9
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>5홀 앞 (1층) </td>
                                                <th>운영시간</th>
                                                <td>08:00 ~ 18:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    031-995-8355
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>-명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">식음료 및 생활용품
                                    
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="convenient" id="convenient_2">
                                    <h3>세븐일레븐</h3>
                                    <ul class="convenient_ul">
                                       <li><img src="/resources/img/convenient_02_01.JPG"></li> 
                                       <li><img src="/resources/img/convenient_02_02.JPG"></li> 
                                       
                                    </ul>

                                    <table class="convenient_table">
                                        <tbody>
                                            <tr>
                                                <th rowspan="3">
                                                    8
                                                </th>
                                                <th>
                                                    위치
                                                </th>
                                                <td>3홀 앞 (1층) </td>
                                                <th>운영시간</th>
                                                <td>0:00 ~ 24:00</td>
                                            </tr>

                                            <tr>
                                                <th>
                                                    전화번호
                                                </th>
                                                <td>
                                                    -
                                                </td>

                                                <th>
                                                    수용인원
                                                </th>
                                                <td>-명</td>
                                            </tr>

                                            <tr>
                                                <th>대표메뉴</th>
                                                <td colspan="3">식음료 및 생활용품 </td>
                                            </tr>
                                        </tbody>
                                    </table>
                            </div> <!--3번 탭-->

                        </div> <!--tab_wrap-->
                    </div> <!--tap_all_wrap-->

                    <div class="facility_Info">
                        킨텍스의 식픔/ 판매/ 상설매장/ 자판기 등의 입점계약은   <strong> 외부대행사나 개인 및 중개사 등을 통하지 않습니다.</strong><br>
                        또한, <strong>기존 매장의 재전대/ 재가맹 등은 일절 허용하지 않고 있사오니</strong>, 유사한 제안을 받으신 분은 아래 킨텍스 <strong>스마트사업팀(031-995-8367)</strong>으로 꼭 사전 확인하시어 피해나 사기가 발생하지 않도록 주의하시기 바랍니다.
                    </div>
                </div><!--contentIn-->
            </div>
        </div>

  	 <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>