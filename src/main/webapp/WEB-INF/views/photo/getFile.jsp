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
    <script src="/resources/js/top.js"></script>

</head>

<style>
    #container1{
        width: 1200px;
        margin-top: 50px;
        font-weight: bold;
    }
    .clear{
        clear: both;
    }

    #title_area{
        border-bottom: 1px solid rgb(201, 201, 201);
        border-top: 1px solid #6f2b89;
        height: 40px;
        line-height: 40px;
        font-size: 20px;
    }

    #title{
        margin-left: 10px;
        float: left;
        width: 70%;
    }
    
    #writer{
        float: right;
        width: 20%;
    }
    
    #date_area{
        background-color: #eee;
        font-size: 15px;
        height: 40px;
        line-height: 40px;

    }
    
    #register_date{
        margin-left: 10px;
        width: 85%;
        float: left;
    }

    #readCnt{
        width: 11%;
        float: right;
    }

    #top_space{
        margin-top: 10px;
    }

    #contents{
        min-height: 300px;
        border-top: 1px solid #999;
        border-bottom: 1px solid #999;
    }

    #wrote{
        padding: 30px 0 30px 10px;
    }

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
	    console.debug('jq started..!')

        //목록버튼
	    $("#listBtn").on('click', function () {
	        console.log('#listBtn button clicked.');
	
	        
	        location.href = "/photo/listPerPage?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
	
	    }); // .onclick
	    
        //삭제버튼
        $('#removeBtn').on('click', function () {
            console.log('removeBtn Clicked.');

            var result = confirm('정말 삭제하시겠습니까?');
            if(result){
                let formObj = $('form');
                formObj.attr('action', '/photo/remove/?fid='+${file.fid});
                formObj.attr('method', 'POST');
    
                formObj.submit();
            }//if

        });//onclick()

        //수정버튼
	    $("#modifyBtn").on('click', function () {
	        console.log('#modifyBtn button clicked..');
	
	        // location.href = "/board/modify?bno=${board.bno}";
	        location.href = "/photo/modify?fid=${file.fid}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
	    }); // .onclick
	})//end jq
</script>
<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">미디어센터</h2>
                <ul id="parent">
                    <li><a class="chk" href="/photo/listPerPage">포토갤러리</a></li>
                    <li><a class="chk" href="/news/listPerPage">보도자료</a></li>
                    
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 미디어 센터 > 포토갤러리 </div>
                    <h2 class="subName">포토갤러리</h2>
                </div>
                <div class="contentIn">
                    <!-- 여기에 게시판 넣으면 됩니다. -->
                    <div id="container1">

                        <!-- 제목, 작성자, 등록일, 수정일, 조회수 -->
                        <div id="tables">
                            <div id="title_area">
                                <div id="title">${board.title}</div>
                                <div id="writer">작성자 : ${board.memberid}</div>
                            </div>
                            <div class="clear"></div>
                            
                            <div id="date_area">
                                <div id="register_date">등록일 : <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${board.insert_ts}" /></div>
                                <div id="readCnt">조회수 : ${board.readcnt+1}</div>
                            </div>
                        </div>
                        <div id="top_space"></div>

                        <!-- 콘탠츠내용, 이미지 -->
                        <div id="contents">
                            <div id="wrote"><img src="/resources/img/${file.fpath}${file.frename}" alt=""></div>
                        </div>


                        <!-- 글수정, 답변, 목록 버튼 -->
                        <div id="bottom_space">
                            <div id="btn_area">
                                <button type="button" class="btn1" id="modifyBtn">수정</button>
                                <button type="button" class="btn1" id="removeBtn">삭제</button>
                                <button type="button" class="btn1" id="listBtn">목록</button>
                            </div>
                        </div>
                        <!-- <form action="#">
                            <table border="1">
                                <tr>
                                    <td>파일번호 : ${file.fid}</td>
                                </tr>
                                <tr>
                                    <td>파일이름 : ${file.forname}</td>
                                </tr>
                            </table>
                            <br>
                            <div>
                            </div>
                            <br>
                            <button type="button" id="modifyBtn">수정</button>
                            <button type="button" id="listBtn">목록보기</button>
                        </form> -->
                    </div>
                </div>
            </div>
        </div>

    <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>