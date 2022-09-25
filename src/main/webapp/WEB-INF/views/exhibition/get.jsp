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
    <link rel="stylesheet" href="/resources/css/exhibition.css">
    
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
        //일정삭제
        $('#removeBtn').on('click',function(){
            $('form').attr('action','/exhibition/remove?exno=${schedule.exno}').attr('method','POST').submit();
                        
        });//removeBtn

        //수정하기
        $('#exModifyBtn').on('click',function() {

            location.href = "/exhibition/modify?exno=${schedule.exno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

        })//modifyBtn

        //목록보기
        $('#exListBtn').on('click',function(){

            location.href = "/exhibition/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

        });//listBtn

    })
</script>
<style>
    /* 테이블(전시정보) */
.exInfo {
    margin-top: 40px;
    margin-bottom: 40px;
    width: 99%;
}
.exInfo > tr,th {
    border-top: none;
}
.exInfo td {
    width: 600px;
}
.exInfo p {
    padding: 20px;

    text-align: center;
    font-size: 20px;
}
td:nth-child(2) {
    color: #000;
}
</style>
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
                    <!-- <div id="exWrapper"> -->
                        <div id="getPage">
                           <div class="subjectLine">
                                <!-- 글제목 -->
                                <div class="subject">
                                    <p>&nbsp;${schedule.exname}</p>
                                    <p>관리자&nbsp;</p>
                                </div>
                               
                                <!-- 등록일 / 수정일 / 조회수-->
                                <div class="regDate">
                                    &nbsp;등록일:<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${schedule.exinsert}"/>
                                    <c:if test="${schedule.exupdate != null}">
                                        &nbsp;&nbsp;&nbsp;수정일:<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${schedule.exupdate}"/>
                                    </c:if>
                                </div>
                           </div>
                            <div class="content">
                                <table class="exInfo">
                                    <tbody>
                                        <tr>
                                            <th>전 시 명</th>
                                            <td><p>${schedule.exname}</p></td>
                                        </tr>
                                        <tr>
                                            <th>전시시작일</th>
                                            <td><p><fmt:formatDate pattern="yyyy/MM/dd" value="${schedule.exstart}"/></p></td>
                                        </tr>
                                        <tr>
                                            <th>전시마감일</th>
                                            <td><p><fmt:formatDate pattern="yyyy/MM/dd" value="${schedule.exend}"/></p></td>
                                        </tr>
                                        <tr>
                                            <th>전시내용</th>
                                            <td><p>${schedule.excontent}</p></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class=btn>
                                <div>
                                    <c:if test="${__LOGIN__.memberid == 'admin'}">
                                        <button type="button" class="buttonstyle" id="exModifyBtn">수정</button>
                                        <button type="button" class="buttonstyle" id="removeBtn">삭제</button>&nbsp;&nbsp;
                                    </c:if>
                                </div>
                                <div>
                                    <button type="button" class="buttonstyle" id="exListBtn">목록</button>
                                </div>
                            </div>
                        </div>
                    <!-- </div> -->
                </div>
            </div>
        </div>

        <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>