<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>

	 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/history.css">
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
                    <div class="map">home > 전시회 소개 > 연혁 </div>
                    <h2 class="subName">연혁</h2>
                </div>
                <div class="contentIn">
                        <div id="topmenu">
                            <p>연혁</p> 
                            <span>G-fair가 걸어온 길</span>
                        </div>

                        <div class="historyBox">
                            <ul class="historyList">

                                <div class="historyboxLine1">
                                    <li class="history2020">
                                        <img src="/resources/img/history_junsi2020.jpg"/>
                                            <p class="history_font">
                                                <span class="text_year">2020</span>
                                                대한민국 우수상품 전시회 
                                                <br>
                                                <span class="text_date"> 2020.10.21&lpar;수&rpar; ~ 10.23&lpar;금&rpar;</span>
                                            </p>
                                           
                                    </li>     
                                    
                                    <li class="history2019">
                                        <img src="/resources/img/history_junsi2019.jpg" >
                                        <p class="history_font">
                                            <span class="text_year">2019</span>
                                            대한민국 우수상품 전시회 
                                            <br>
                                            <span class="text_date"> 2019.10.31&lpar;목&rpar; ~ 11.03&lpar;일&rpar;</span>
                                        </p>
                                       
                                    </li> 

                                    <li class="history2018">      
                                        <img src="/resources/img/history_junsi2018.jpg" >
                                        <p class="history_font">
                                            <span class="text_year">2018</span>
                                            대한민국 우수상품 전시회 
                                            <br>
                                            <span class="text_date"> 2018.10.24&lpar;수&rpar; ~ 11.27&lpar;토&rpar;</span>
                                        </p>
                                     
                                    </li>   
                                </div> <!-- box 1-->

                                <div class="historyboxLine1">
                                    <li class="history2020">
                                        <img src="/resources/img/history_junsi2017.jpg"/>
                                            <p class="history_font">
                                                <span class="text_year">2017</span>
                                                대한민국 우수상품 전시회 
                                                <br>
                                                <span class="text_date"> 2017.11.01&lpar;수&rpar; ~ 11.04&lpar;토&rpar;</span>
                                            </p>
                                           
                                    </li>     
                                    
                                    <li class="history2019">
                                        <img src="/resources/img/history_junsi2016.jpg" >
                                        <p class="history_font">
                                            <span class="text_year">2016</span>
                                            대한민국 우수상품 전시회 
                                            <br>
                                            <span class="text_date"> 2016.10.26&lpar;수&rpar; ~ 10.29&lpar;토&rpar;</span>
                                        </p>
                                     
                                    </li> 

                                    <li class="history2018">      
                                        <img src="/resources/img/history_junsi2015.jpg" >
                                        <p class="history_font">
                                            <span class="text_year">2015</span>
                                            대한민국 우수상품 전시회 
                                            <br>
                                            <span class="text_date"> 2015.11.05&lpar;목&rpar; ~ 11.08&lpar;일&rpar;</span>
                                        </p>
                                       
                                    </li>   
                                </div> <!-- box 1-->

                                <div class="historyboxLine1">
                                    <li class="history2020">
                                        <img src="/resources/img/history_junsi2014.jpg"/>
                                            <p class="history_font">
                                                <span class="text_year">2014</span>
                                                대한민국 우수상품 전시회 
                                                <br>
                                                <span class="text_date"> 2014.10.01&lpar;수&rpar; ~ 10.04&lpar;토&rpar;</span>
                                            </p>
                                           
                                    </li>     
                                    
                                    <li class="history2019">
                                        <img src="/resources/img/history_junsi2013.jpg" >
                                        <p class="history_font">
                                            <span class="text_year">2013</span>
                                            대한민국 우수상품 전시회 
                                            <br>
                                            <span class="text_date"> 2013.10.09&lpar;수&rpar; ~ 10.12&lpar;토&rpar;</span>
                                        </p>
                                        
                                    </li> 

                                    <li class="history2018">      
                                        <img src="/resources/img/history_junsi2012.jpg" >
                                        <p class="history_font">
                                            <span class="text_year">2012</span>
                                            대한민국 우수상품 전시회 
                                            <br>
                                            <span class="text_date"> 2012.10.17&lpar;수&rpar; ~ 10.20&lpar;토&rpar;</span>
                                        </p>
                                     
                                    </li>   
                                </div> <!-- box 1-->

                                <div class="historyboxLine1">
                                    <li class="history2020">
                                        <img src="/resources/img/history_junsi2011.jpg"/>
                                            <p class="history_font">
                                                <span class="text_year">2011</span>
                                                대한민국 우수상품 전시회 
                                                <br>
                                                <span class="text_date"> 2011.10.25&lpar;화&rpar; ~ 10.27&lpar;목&rpar;</span>
                                            </p>
                                            
                                    </li>     
                                    
                                    <li class="history2019">
                                        <img src="/resources/img/history_junsi2009.jpg" >
                                        <p class="history_font">
                                            <span class="text_year">2010</span>
                                            대한민국 우수상품 전시회 
                                            <br>
                                            <span class="text_date"> 2010.10.26&lpar;수&rpar; ~ 10.29&lpar;금&rpar;</span>
                                        </p>
                                    </li> 

                                    <li class="history2018">      
                                        <img src="/resources/img/history_junsi2008.jpg" >
                                        <p class="history_font">
                                            <span class="text_year">2009</span>
                                            대한민국 우수상품 전시회 
                                            <br>
                                            <span class="text_date"> 2009.09.24&lpar;목&rpar; ~ 09.26&lpar;토&rpar;</span>
                                        </p>
                                   
                                    </li>   
                                </div> <!-- box 1-->

                                <div class="historyboxLine2">
                                    <li class="history2020">
                                        <img src="/resources/img/history_junsi2007.jpg"/>
                                            <p class="history_font">
                                                <span class="text_year">2008</span>
                                                대한민국 우수상품 전시회 
                                                <br>
                                                <span class="text_date"> 2008.10.29&lpar;수&rpar; ~ 10.31&lpar;금&rpar;</span>
                                            </p>
                                            
                                    </li>     
                                    
                                    <li class="history2019">
                                        <img src="/resources/img/history_junsi2009.jpg" >
                                        <p class="history_font">
                                            <span class="text_year">2007</span>
                                            대한민국 우수상품 전시회 
                                            <br>
                                            <span class="text_date"> 2007.10.11&lpar;목&rpar; ~ 10.13&lpar;토&rpar;</span>
                                        </p>
                                     
                                    </li> 

                                </div> <!-- box 1-->
                            </ul> <!--ul-->
                        </div> <!--historyBox -->
                    </div><!--contentin-->
            </div>
        </div>

   	<span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>