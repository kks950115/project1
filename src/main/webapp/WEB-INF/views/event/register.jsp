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
        border-bottom: 3px solid rgb(201, 201, 201);
        border-top: 3px solid #005bbb;
        height: 40px;
        line-height: 40px;
        font-size: 20px;
    }
    
    #title_input{
        width: 40%;
    }

    #textarea{
        margin-top: 10px;
        margin-bottom: 10px;
        width: 40%;
    }
    #writer{
        float: right;
        width: 20%;
    }

    .uploadDiv{
        width: 40%;
    }

    .btn {
        width: 100px;
        height: 40px;

        border: 0;
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;

        cursor: pointer;
	}
    .btn_area{
        margin-top: 10px;
    }

    #listBtn{
        float: right;
    }

    input[type="file"]{
        display: none;
    }

    .buttonstyle {
        right: 0px;
        height: 50px;
        width: 100px;
        
        margin: 20px 0px 10px 0px;

        font-size: 15px;
        font-weight: bold;

        color: white;
        background-color: #005bbb;
    }

    .uploadDiv{
        width: 100%;
        height: 50px;
        line-height: 50px;
        border-bottom: 1px solid rgb(201, 201, 201);
    }
    
    .custom-file-upload {
        
        padding: 10px;
        border: 1px solid #005bbb;
        padding: 6px 12px;
        cursor: pointer;

        font-size: 15px;
        color: #005bbb;
        font-weight: bold;

        background-color: white;
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
        
        $("#listBtn").on('click', function () {
	        console.log('#listBtn button clicked.');
	
	        
	        location.href = "/event/listPerPage?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
	
	    }); // .onclick

        $('#registerBtn').on('click', function (e) {
            console.debug('registerBtn clicked.');
            var value = $('input[name="uploadFile"]').val();

            if(value == ''){
                e.preventDefault();
                alert('이미지를 첨부하여주세요.')
            }else{
                $('#registerBtn').unbind();
            }
        });
    })//end jq
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
                    <div id="container1">
                        <form action="/event/register" method="POST" enctype="multipart/form-data">
                            <!-- 어느화면에서든, 게시판 목록 페이지로 이동시, 반드시 아래 3개의 기준 전송파라미터를 전송시키기위해,
                                hiiden 값으로 설정 -->
                            <input type="hidden" name="currPage" value="${cri.currPage}">
                            <input type="hidden" name="amount" value="${cri.amount}">
                            <input type="hidden" name="pagesPerPage" value="${cri.pagesPerPage}">

                            
                            <input type="hidden" name="bname" value="이벤트게시판">
                            <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                            <input type="hidden" name="reproot" value="${board.reproot}">
                            <input type="hidden" name="repstep" value="${board.repstep}">
                            <input type="hidden" name="repindent" value="${board.repindent}">
                            <input type="hidden" name="readcnt" value="0">
                            <input type="hidden" name="notice_tf" value="F">
                            <input type="hidden" name="reply_tf" value="F">


                            <div id="title_area">
                                <input type="text" name="title" id="title_input" placeholder="제목을 입력하세요">
                                <span id="writer">작성자 &nbsp;&nbsp; ${__LOGIN__.memberid}</span>
                            </div>
                            
                            
                            <div>
                                <textarea  
                                    name="content" 
                                    id="textarea" 
                                    cols="48" 
                                    rows="10" 
                                    placeholder="내용을 입력하세요"></textarea>
                            </div>

                            <!-- 파일첨부 -->
                            <div class="uploadDiv">
                                <label class="custom-file-upload">파일업로드
                                    <input class="buttonstyle" type="file" name="uploadFile" accept="image/*" required>
                                </label>
                            </div>
                            <div class="btn_area">
                                <button type="summit" class="btn" id="registerBtn">등록</button>
                                <button type="button" class="btn" id="listBtn">목록</button>
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