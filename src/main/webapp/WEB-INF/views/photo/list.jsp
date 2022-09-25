<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>

    <!-- <link href="/resources/css/photo_list.css" rel="stylesheet" type="text/css" /> -->
    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
    <!-- <script src="/resources/js/photo_list.js"></script> -->
    <script src="/resources/js/top.js"></script>

</head>

<style>

    A:link{text-decoration: none; color: #646464;}
    A:visited{text-decoration: none; color: #646464;}
    A:active{text-decoration: none; color: #646464;}
    A:hover{cursor: pointer;}

    #photo_area{
        margin: 0 auto;
        width: 1200px;

        font-family: 
            'Lucida Sans', 
            'Lucida Sans Regular', 
            'Lucida Grande', 
            'Lucida Sans Unicode', 
            Geneva, 
            Verdana, 
            sans-serif;
    }



    #photo_zone{
        margin-top: 10px;
        margin-bottom: 50px;

        display: flex;
        flex-wrap: wrap;

        width: 100%;
    }


    .ex_img{
        padding: 20px 25px 3px 25px;
    }

    .thumbnail{
        width: 250px;
        height: 230px;
    }
    
    #thumb_title{
        width: 99%;

        margin-top: 5px;
        
        font-size: 20px;
        font-weight: bold;
        
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        
        text-align: center;
    }
    
    #photo_zone > ul{
        display: flex;
        flex-wrap: wrap;
        
        
        list-style: none;


        /* justify-content: center; */
        /* justify-content: space-between; */
    }
    
    #photo_zone > ul > li{
        margin-bottom: 30px;
    }
    /* #photo_zone > ul > li{
        display: flex;
        width: 250px;
        height: 230px;
        margin-top: 50px;
        margin-bottom: 50px;

        justify-content: center;
        align-items: center;
        
    } */


    #topmenu{
        height: 50px;   
        border-bottom: 1px solid #999;
        margin-bottom: 10px;
    }

    .btn1{
        width: 100px;
        height: 40px;

        border: 0;
        
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;

        cursor: pointer;
    }

    input[type="file"]{
        display: none;
    }

    .uploadDiv{
        display: flex;

        justify-content: space-between;

        margin-top: 30px;

        width: 100%;
        height: 50px;
        line-height: 50px;

        border-bottom: 3px solid #005bbb;
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

    #regBtn{
        margin-top: 5px;
        float: right;
    }
    /* paging */
    #pagination {
        width: 100%;
        margin: 0 auto;
        position: relative;
    }

    #pagination ul {
        display: flex;
        justify-content: center;

    }

    #pagination li {
        float: left;
        width: 30px;
        height: 30px;
        text-align: center;
        list-style: none;
        line-height: 30px;
        font-size:16px;
        
        margin-right:10px;
    }

    .currPage {
        border: 1px solid #000;
    }

    #totalAmount{
        line-height: 50px;
        float: left;
    }


    #search_area {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }
    
    

    #pagination li a{
        display:block;

    }
    .start{
		text-indent:-9999em;
		background-image: url(/resources/img/btn_pagination.png);
        background-repeat: no-repeat;
        background-size: 120px 30px;
        border:1px solid #eee;

	}

    .prev{
		text-indent:-9999em;
		background-image: url(/resources/img/btn_pagination.png);
        background-repeat: no-repeat;
        background-size: 120px 30px;
        background-position:-30px;
        border:1px solid #eee;
	}

    .next{		
		text-indent:-9999em;
		background-image: url(/resources/img/btn_pagination.png);
        background-repeat: no-repeat;
        background-size: 120px 30px;
        background-position:-60px;
        border:1px solid #eee;
	
	}

    .end{
		text-indent:-9999em;
		background-image: url(/resources/img/btn_pagination.png);
        background-repeat: no-repeat;
        background-size: 120px 30px;
        background-position:-90px;
        border:1px solid #eee;
	
	}

    .start a .prev a, .next a .end a{
    	display:block;
        
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
        
        $("#registerBtn").on("click", function (e) {
            console.debug("regBtn Clicked.");

            location.href="/photo/register";
        
    }); //onclick #regBtn
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
                    <div class="map">home > 미디어센터 > 포토갤러리 </div>
                    <h2 class="subName">포토갤러리</h2>
                </div>
                <div class="contentIn">
                	
                    <!-- 여기에 게시판 넣으면 됩니다. -->
                    <div id="photo_area">
                        <div class="uploadDiv">
                            <span id="totalCount">전체글 수 : ${pageMaker.totalAmount}</span>

                            <c:set var="insert" value="${sessionScope.__LOGIN__}" />
                            <c:choose>

                                <c:when test="${insert.membertype eq '관리자'}">
                                    <button class="btn1" id="registerBtn" >글쓰기</button>
                                </c:when>
                                
                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>

                            </c:choose>
                        </div>
                        
                        <div id="photo_zone">
                            <ul>
                                <c:forEach items="${list}" var="photo">
                                    <li>
                                        <a href="/photo/getFile?fid=${photo.fid}">
                                            <div class="ex_img">
                                                <img src="/resources/img/${photo.fpath}${photo.frename}" class="thumbnail" alt="">
                                            </div>
                                            <!-- 제목 -->
                                            <p id="thumb_title">${photo.title}</p>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
            
                        <div id="pagination">
                            <form action="" id="paginationForm">
                                <!-- 어느화면에서든, 게시판 목록 페이지로 이동시, 반드시 아래 3개의 기준 전송파라미터를 전송시키기위해,
                                hiiden 값으로 설정 -->
                                <input type="hidden" name="currPage">
                                <input type="hidden" name="amount">
                                <input type="hidden" name="pagesPerPage">
                                <input type="hidden" name="type">
                                <input type="hidden" name="keyword">
                                <ul>
                                    <!-- <c:if test="${pageMaker.prev}">
                                        <li class="prev"><a class="prev" href="${pageMaker.startPage - 1}">Prev</a></li>
                                    </c:if> -->
                                    <li><a class="start" href="/photo/listPerPage">첫 페이지</a></li>
                                    <li><a class="prev" href="/photo/listPerPage?currPage=${pageMaker.startPage}">이전</a></li>
                                    <!-- begin ~ end 까지 반복하고, 현재의 번호값은 var속성에 넣어준다 -->
                                    <c:forEach begin="${pageMaker.startPage}" 
                                                end="${pageMaker.endPage}" 
                                                var="pageNum">
                                        <li>
                                            <a 
                                                id="mmw"
                                                class="${pageMaker.cri.currPage == pageNum? 'currPage' : ''}" 
                                                href="/photo/listPerPage?currPage=${pageNum}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">
                                                ${pageNum}
                                            </a>
                                        </li>
                                    </c:forEach>
            
                                    <!-- <c:if test="${pageMaker.next}">
                                        <li class="next"><a class="next" href="${pageMaker.endPage + 1}">Next</a></li>
                                    </c:if> -->
                                    <li><a class="next" href="/photo/listPerPage?currPage=${pageMaker.endPage}">다음페이지</a></li>
                                    <li><a class="end" href="/photo/listPerPage?currPage=${pageMaker.realEndPage}">끝페이지</a></li>
                                </ul>
                            </form>
                        </div>

                        <div id="search_area">
                            <li>
                                <form action="/photo/listPerPage" method="GET" id="searchForm">
                                    <input type="hidden" name="currPage" value="1">
                                    <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                                    <input type="hidden" name="pagesPerPage" value="${pageMaker.cri.pagesPerPage}">

                                    <select name="type" id="search1">
                                        <option value="T" ${ ( "T" eq pageMaker.cri.type ) ? "selected" : ""}>제목</option>
                                        <option value="C" ${ ( "C" eq pageMaker.cri.type ) ? "selected" : ""}>내용</option>
                                        <option value="W" ${ ( "W" eq pageMaker.cri.type ) ? "selected" : ""}>작성자</option>
                                        <option value="TC" ${ ( "W" eq pageMaker.cri.type ) ? "selected" : ""}>제목+내용</option>
                                    </select>

                                    <input type="text" name="keyword" class="search2" value="${pageMaker.cri.keyword}">
                                    
                                    <button class="btn1" id="searchBtn">Search</button>
                                </form>
                            </li>
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