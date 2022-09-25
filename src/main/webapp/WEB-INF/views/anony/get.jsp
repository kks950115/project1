<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>

    <link href="/resources/css/anonyGetPage.css" rel="stylesheet" type="text/css"/>
    
    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css"/>
    
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

        // 버튼클릭관련
        $('#reregBtn').on('click',function(){
                    
            location.href = "/anony/retrieve?title=${board.title}&reproot=${board.reproot}&repstep=${board.repstep}&repindent=${board.repindent}&bname=${board.bname}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
            
        });//reregBtn
        
        $('#modifyBtn').on('click',function() {
            
            location.href = "/anony/modify?bno=${board.bno}&bname=${board.bname}&readcnt=${board.readcnt}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
            
        })//modifyBtn

        $('#listBtn').on('click',function(){
            
            location.href = "/anony/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
            
        });//listBtn

    
        //iframe 높이 자동조절
        let iframe = document.getElementById("child-iframe"); 

        iframe.addEventListener('load', function() { 
            iframe.height = iframe.contentWindow.document.body.scrollHeight +490+ 'px'; 
            console.log(iframe.height);
            // iframe.style.width = iframe.contentDocument.body.scrollWidth + 'px'; 
        });

    });//jq
    </script>
<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">커뮤니티</h2>
                <ul id="parent">
                    <li><a class="chk" href="/notice/list">공지사항</a></li>
                    <li><a class="chk" href="/question/list">질문게시판</a></li>
                    <li><a class="chk" href="/often/question">자주묻는질문</a></li>
                    <li><a class="chk" href="/anony/list">고객의소리</a></li>
                    <li><a class="chk" href="/free/board">자유게시판</a></li>
                    <li><a class="chk" href="/event/listPerPage">이벤트</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 커뮤니티 > 고객의소리 </div>
                    <h2 class="subName">고객의소리</h2>
                </div>
                
                <!-- 상세페이지 -->
                <div class="contentIn">
                    <iframe id="child-iframe" target="_parent" src="/anony/getPage?bno=${board.bno}&readcnt=${board.readcnt}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}" frameborder="0" width="1200" scrolling='no'></iframe>
                </div>

                <!-- 버튼 -->
                <form action="/anony/remove" method="POST">
                    <input type="hidden" name="bno" value="${board.bno}">
                
                    <div class=getBtn>
                        <div>
                            <c:if test="${__LOGIN__.memberid eq board.memberid}">
                                <button type="button" class="buttonstyle" id="modifyBtn">수정</button>
                            </c:if>
                            <c:if test="${__LOGIN__.memberid eq board.memberid or __LOGIN__.membertype eq '관리자'}">
                                <button type="submit" class="buttonstyle" id="removeBtn">삭제</button>
                            </c:if>
                            <c:if test="${__LOGIN__.memberid != null}">
                                <button type="button" class="buttonstyle" id="reregBtn">답글</button>
                            </c:if>
                        </div>
                        <div>
                            <button type="button" class="buttonstyle" id="listBtn">목록</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>