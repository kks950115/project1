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
    <link rel="stylesheet" href="/resources/css/exRegPage.css">
    
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
<script>
    $(function(){

        $('#exCancleBtn').on('click',function(){
            
            history.back();
        })

    })//.jq
</script>
<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">관리페이지</h2>
                <ul id="parent">
                    <li><a class="chk" href="/admin/memberList">회원관리</a></li>
                    <li><a class="chk" href="/admin/memberBoard">회원글관리</a></li>
                    <li><a class="chk" href="/admin/memberReply">회원댓글관리</a></li>

                    <li><a class="chk" href="/admin/apply">참가기업관리</a></li>
                    <li><a class="chk" href="/exhibition/list">전시일정관리</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 관리페이지 > 전시일정관리 </div>
                    <h2 class="subName">전시일정관리</h2>
                </div>
                <div class="contentIn">
                    <div class="exhibitionWrap">
                        <form id="exRegisterForm" method="POST" action="/exhibition/register">
                            <p class='bnameSize'>전시회일정 등록</p>
                            <div class="fontLine"></div>
                            <table>
                                <tbody>
                                    <tr>
                                        <th>전시명</th>
                                        <td><input type="text" name="exname" placeholder="전시명을 입력해주세요" required></td>
                                    </tr>
                                    <tr>
                                        <th>전시시작일</th>
                                        <td><input type="date" name="exstart" placeholder="전시시작일" required></td>
                                    </tr>
                                    <tr>
                                        <th>전시마감일</th>
                                        <td><input type="date" name="exend" placeholder="전시마감일" required></td>
                                    </tr>
                                    <tr>
                                        <th>전시내용</th>
                                        <td><textarea name="excontent" rows="15" placeholder="전시일정 내용을 입력해주세요" required></textarea></td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="getBtn">
                                <button type="submit" class="buttonstyle" id="exRegBtn">등록</button>
                                <button type="button" class="buttonstyle" id="exCancleBtn">취소</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>