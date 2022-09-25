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
    <link href="/resources/css/calendar.css" rel="stylesheet" type="text/css" />

    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.js"></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.css">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
    <script src="/resources/js/top.js" type="text/javascript"></script>
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
<!-- 초기화코드-------------------------------------------------- -->
<script>

    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');


        var calendar = new FullCalendar.Calendar(calendarEl, {
            
            // initialView: 'dayGridMonth',

            // 아래부터 추가
            headerToolbar: {
                 left: 'prevYear,prev',
                 center: 'title',
                 right: 'today,next,nextYear'
            
            }, // buttons for switching between views

            //일정 클릭시 이벤트...
            eventClick:function(){
                
            },
            
            // eventLimit:true,
            dayMaxEventRows:true,
            views:{
                dayMacEventRows: 3
            },
            events: getCalendarDataInDB()

        });//FullCalendar

        calendar.render();
    });//addEventListener
  
    var data = [];
    // 화면에 db일정 뿌려줌
    function getCalendarDataInDB(){
        console.log("getCalendarDataInDB() invoked");

        $.ajax({
            contentType: 'application/x-www-form-urlencoded; charset=utf8',
            dataType: 'json',
            url: '/exhibition/calendar',
            type: 'POST',
            async: false,
            success: function(result){
                
                console.log(result);
                
                data = result;
            }//success
            
        })//ajax
        return data;
    }//getCalendarDataInDB
    

    $(function(){
        $('#exRegBtn').on('click',function(){
            window.open("/exhibition/calRegister","tst","width=500, height=400, toolbar=no, menubar=no,scrollbars=no,resizable=yes");
        })//exRegBtn

        $('#exListBtn').on('click',function(){
            location.href = "/exhibition/list";
        })//exListBtn

    })//.jq

    
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
                    <div class="map">home > 전시회 소개 > 전시회일정</div>
                    <h2 class="subName">전시회일정</h2>
                </div>
                <div class="contentIn">
                    <c:choose>
                        <c:when test="${__LOGIN__.membertype == '관리자'}">
                            <div class="btn">
                                <button type="button" id="exRegBtn">일정등록</button>
                                <button type="button" id="exListBtn">일정관리</button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p id="totalCount"></p>
                        </c:otherwise>
                    </c:choose>

                    <p>&nbsp;</p>

                	<!-- fullcalendar -->
                    <div id='calendar'></div>
                
                    <p id="totalCount"></p>
                </div>
            </div>
        </div>

        <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>