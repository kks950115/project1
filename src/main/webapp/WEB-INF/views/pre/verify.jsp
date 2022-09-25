<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>지페어 코리아</title>

        <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
        <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
        <script src="/resources/js/fullnav.js"></script>
   		<script src="/resources/js/top.js"></script>


        <style>
            th{
                width:150px;
                height: 50px;
            }

            td{
                width: 300px;
                text-align: center;
            }

            tr{
                border-bottom: solid 1px black;
            }
            
            .sub_container{
                margin-top: 50px;
                margin-bottom: 50px;

                min-height: 300px;
            }

            .show_member_info{
                margin: 0 auto;

                width: 900px;
                
                font-size: 25px;

                border-bottom: solid 1px black;
                border-top: solid 1px black;
                border-right: solid 1px black;
                border-left: solid 1px black;
            }

            .sub_top{
                display: flex;

                justify-content: center;

                border-top: 3px solid #005bbb;
                border-bottom: 1px solid #eee;
            }

            .member_name{
                margin-bottom: 5px;
                font-weight: bold;
                font-size: 40px;
            }

            .app_statement{
                display: flex;

                margin-left: 5px;

                height: 53px;

                align-items: flex-end;

                font-weight: bold;
                font-size: 25px;
            }

            .btn1 {
                width: 120px;
                height: 50px;

                border: 0;
                
                text-align: center;
                background: #005bbb;
                color: #fff;
                font-size: 15px;
                
                cursor: pointer;
            }


            .btn_area{
                display: flex;
                justify-content: center;
                border-top: 1px solid #eee;
                padding-top: 10px;
            }
            .space_input{
                height: 10px;
            }


        </style>

        <script>
            $(function () {
                console.clear();
                console.debug('jq started.');
	
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
                
                $('#mainBtn').on('click', function () {
                    location.href="/index"
                });
            })
        </script>
    </head>
    
    <body>
        <div id="wrap">
 	
            <%@ include file="/WEB-INF/views/common/header.jsp" %>
        
                <div id="container">
                    <div id="aside">
                        <h2 class="asideMenu">관람정보</h2>
                        <ul id="parent">
                            <li><a class="chk" href="/pre/guide">사전관람안내</a></li>
                            <li><a class="chk" href="/pre/register">사전관람신청</a></li>
                            <li><a class="chk" href="/pre/verify">사전관람신청확인</a></li>
                        </ul>
        
                    </div>
                    <div id="content">
                        <div class="title">
                            <div class="map">home > 관람정보 > 사전관람신청확인 </div>
                            <h2 class="subName">사전관람신청확인</h2>
                        </div>
                        <div class="contentIn">
                            
                            <!-- 여기에 게시판 넣으면 됩니다. -->
                            <div class="sub_container">

                                <div class="sub_top">
                                    <br>
                                    <span class="member_name">${__LOGIN__.membername}</span>
                                    <span class="app_statement">님의 사전관람신청 현황입니다.</h1>
                                </div>
                                <!-- <tr>
                                    <th><label for="name">신청자명</label></th>
                                    <td>${__LOGIN__.membername}</td>
                                </tr>
                                <tr>
                                    <th><label for="phone">연락처</label></th>
                                    <td>${__LOGIN__.phone}</td>
                                </tr> -->
                                <div class="contents">
                                    <c:forEach items="${__APP__}" var="app">
                                    <br>
                                    <table class="show_member_info">
                                        <tbody>
                                            <tr>
                                                <th><label for="appname">신청 전시회명/기간</label></th>
                                                <td>
                                                    ${app.appname} ( 
                                                    <fmt:formatDate pattern="YYYY.MM.dd" value="${app.exstart}" type="date"/> ~
                                                    <fmt:formatDate pattern="YYYY.MM.dd" value="${app.exend}" type="date"/> )
                                                    <br>
                                                </td>
                                                
                                            </tr>
                                            <tr>
                                                <th><label for="app.appdate">신청일</label></th>
                                                <td>
                                                    <fmt:formatDate pattern="YYYY.MM.dd" value="${app.appdate}" type="date"/><br>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <br>
                                </c:forEach>
                                </div>

                                <div class="btn_area">
                                    <div class="space_input"></div>
                                    <button id="mainBtn" type="button" class="btn1">홈으로</button>
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