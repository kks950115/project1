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

        $('#exListBtn').on('click',function(){

            location.href = "/exhibition/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

        });//regBtn
        
        $('#removeBtn').on('click',function(){
            $('form').attr('action','/exhibition/remove?exno=${schedule.exno}').attr('method','POST').submit();
                        
        });//removeBtn

// -----------------------------------------------------------------------------------
    
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
                        <form id="exModifyForm" action="/exhibition/modify" method="POST">
                            <p class='bnameSize'>전시회일정 수정</p>
                            <div class="fontLine"></div>
                            
                            <input type="hidden" name="currPage" value=${cri.currPage}>
                            <input type="hidden" name="amount" value=${cri.amount}>
                            <input type="hidden" name="pagesPerPage" value=${cri.pagesPerPage}>
            
                            <input type="hidden" name="exno" value=${schedule.exno}>
                            <table>
                                <tbody>
                                    <tr>
                                        <th>전시명</th>
                                        <td><input type="text" name="exname" value="${schedule.exname}" required></td>
                                    </tr>
                                    <tr>
                                        <th>전시시작일</th>
                                        <td><input type="date" name="exstart" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${schedule.exstart}"/>' required></td>
                                    </tr>
                                    <tr>
                                        <th>전시마감일</th>
                                        <td><input type="date" name="exend" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${schedule.exend}"/>' required></td>
                                    </tr>
                                    <tr>
                                        <th>전시내용</th>
                                        <td><textarea name="excontent" rows="15" value="${schedule.excontent}" required>${schedule.excontent}</textarea></td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="getBtn">
                                <div>
                                    <button type="submit" class="buttonstyle" id="modifyBtn">수정</button>
                                    
                                    <button type="button" class="buttonstyle" id="removeBtn">삭제</button>
                                </div>                
                                <button type="button" class="buttonstyle" id="exListBtn">목록</button>
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