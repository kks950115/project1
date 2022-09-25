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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
	<script src="/resources/js/reply.js"></script>
    <script src="/resources/js/top.js"></script>
        
</head>

<style>
    .btn1 {
        width: 100px;
        height: 40px;

        border: 0;
        
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;
        
        cursor: pointer;
    }

    #bottom_space{
        line-height: 50px;
        height: 50px;
    }
    
    #listBtn{
        margin-top: 5px;
        float: right;
    }

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

<script>
    $(function () {
        console.clear();
        console.debug('jq started..!');
        
        //목록버튼 이벤트
        $("#listBtn").on('click', function () {
            console.log('#listBtn button clicked.');
            
            
            location.href = "/event/listPerPage?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage${cri.pagesPerPage}";
            
        }); // .onclick
        
        //수정버튼 이벤트
        $("#modifyBtn").on('click', function () {
            console.log('#modifyBtn button clicked..');

                    // location.href = "/board/modify?bno=${board.bno}";
                    location.href = "/event/modify?bno=${board.bno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage${cri.pagesPerPage}";
        }) // .onclick

        //삭제버튼 이벤트
        $('#removeBtn').on('click', function () {
            var result = confirm('정말 삭제하시겠습니까?');

            if(result) {
                let formObj = $('form');
                formObj.attr('action', '/event/remove?bno='+${board.bno});
                formObj.attr('method', 'POST');
                formObj.submit();
            }
        })
        let iframe = document.querySelector("#child-iframe");

        iframe.addEventListener('load', function () {
            iframe.height = iframe.contentWindow.document.body.scrollHeight +440+ 'px'; 
            console.log(iframe.height);
        });


    }); //jq

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
                    <div class="map">home > 커뮤니티 > 이벤트 </div>
                    <h2 class="subName">이벤트</h2>
                </div>
                <div class="contentIn">
                	
                    <!-- 여기에 게시판 넣으면 됩니다. -->
                    <iframe 
                        id="child-iframe" 
                        src="/event/get?bno=${board.bno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}" 
                        frameborder="0" 
                        width="1200" 
                        scrolling="no"></iframe>
                </div>


                <div id="bottom_space">
                    <div id="btn_area">
                        <c:set var="insert" value="${sessionScope.__LOGIN__}" />
                        <c:choose>
                            <c:when test="${insert.membertype eq '관리자'}">
                                <button type="button" class="btn1" id="modifyBtn">수정</button>
                                <button type="button" class="btn1" id="removeBtn">삭제</button>
                            </c:when>
                            
                            <c:otherwise>
                                &nbsp;
                            </c:otherwise>
                        </c:choose>
                        <button type="button" class="btn1" id="listBtn">목록</button>
                    </div>
                </div>
            </div>
        </div>

    <span id="top_btn">top</span>  
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>