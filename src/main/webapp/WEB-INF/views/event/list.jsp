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

    #board{
        width: 100%;

        margin-top: 20px;
        margin-bottom: 40px;

        font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
        font-size: 14px;
    }

    table{
        width: 100%;

    }

    table, th, td {
        border: 1px solid rgb(201, 201, 201);
        border-collapse: collapse;
    }

    th {
        background-color: rgb(245, 245, 245);
        height: 50px;
        font-size: 20px;
        border-top: 3px solid #005bbb;

    }

    td {
        height: 40px;
        font-size: 15px;
        text-align: center;
    }
    

    td:first-child {
        color: #005bbb;
    }

    tr:hover {
        background-color: rgb(250, 250, 250);
    }

    a, a:link, a:visited {
        text-decoration: none;
        color: black;
        cursor: pointer;
    }


    td:nth-child(2) {
        text-align: left; 
        padding-left: 10px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .clear{
        clear: both;
    }

    /* paging */
    #pagination {
        width: 95%;
        margin: 0 auto;
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

    #totalCount {
        margin-bottom: 10px;
    }

    #search_area {
        display: flex;
        justify-content: center;
        margin-top: 20px;
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

    #registerBtn{
        float: right;

        margin-top: 10px;

        width: 100px;
        height: 40px;

        border: 0;
        
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;
        
        cursor: pointer;
    }

    #searchBtn{
        width: 100px;
        height: 40px;

        border: 0;
        
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;
        
        cursor: pointer;
    }


    #write_btn {
        display: flex;
        justify-content: right;

        margin: 10px 0;
    }
    #write_btn a {
        display: block;

        background-color: #005bbb;
        color: #fff;
        font-size: 15px;

        width: 100px;
        height: 40px;

        line-height: 40px;
        text-align: center;
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

    #including_img{
        width: 80px;
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
        
        $('#registerBtn').on('click', function () {
            location.href = '/event/register';
        })
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
                    <div id="board">
                        <div id="tables">
                            <p id="totalCount">전체글 수 : ${pageMaker.totalAmount}</p>

                            <table>
                                <thead>
                                    <tr>
                                        <th width="7%" scope="col">번호</th>
                                        <th width="*" scope="col">제목</th>
                                        <th width="10%" scope="col">작성자</th>
                                        <th width="10%" scope="col">등록일</th>
                                        <th width="10%" scope="col">조회수</th>
                                        <th>첨부파일</th>
                                    </tr>
                                </thead>

                                <c:forEach items="${list}" var="event" varStatus="i">
                                    <tbody>
                                        <tr class="event">
                                            <td>${pageMaker.totalAmount - (pageMaker.cri.currPage - 1) * pageMaker.cri.amount - i.index}</td>
                                            <td><a 
                                                href="/event/subGet?bno=${event.bno}&currPage=${pageMaker.cri.currPage}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}">
                                                <c:out value="${event.title}"/></a></td>
                                            <td>${event.memberid}</td>
                                            <td><fmt:formatDate pattern="yyyy/MM/dd" value="${event.insert_ts}" /></td>
                                            <td>${event.readcnt}</td>
                                            <td id="including_img">
                                            	<c:if test="${event.fid != null}">
                                            		<img src="/resources/file.png">
                                            	</c:if>                                            
                                            </td>
                                            
                                        </tr>
                                    </tbody>
                                </c:forEach>
                            </table>

                        </div>

                        <div>
                            <c:set var="insert" value="${sessionScope.__LOGIN__}" />
                            <c:choose>
                                
                                <c:when test="${insert.membertype eq '관리자'}">
                                    <button class="btn" id="registerBtn" >글쓰기</button>
                                </c:when>

                                <c:otherwise>
                                    &nbsp;
                                </c:otherwise>

                            </c:choose>
                        </div>
                        <div class="clear"></div>

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
                                    <li><a class="start" href="/event/listPerPage">첫페이지</a></li>
                                    <li><a class="prev" href="/event/listPerPage?currPage=${pageMaker.startPage}">이전</a></li>
                                    <!-- begin ~ end 까지 반복하고, 현재의 번호값은 var속성에 넣어준다 -->
                                    <c:forEach begin="${pageMaker.startPage}" 
                                                end="${pageMaker.endPage}" 
                                                var="pageNum">
            
                                        <li>
                                            <a 
                                                class="${pageMaker.cri.currPage == pageNum? 'currPage' : ''}" 
                                                href="/event/listPerPage?currPage=${pageNum}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">
                                                ${pageNum}
                                            </a>
                                        </li>
                                    </c:forEach>
            
                                    <!-- <c:if test="${pageMaker.next}">
                                        <li class="next"><a class="next" href="${pageMaker.endPage + 1}">Next</a></li>
                                    </c:if> -->
                                    <li><a class="next" href="/event/listPerPage?currPage=${pageMaker.endPage}">다음페이지</a></li>
                                    <li><a class="end" href="/event/listPerPage?currPage=${pageMaker.realEndPage}">끝페이지</a></li>
            
                                </ul>
                            </form>
                        </div>
                        <div id="search_area">
                            <li>
                                <form action="/event/listPerPage" method="GET" id="searchForm">
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
                                    
                                    <button class="btn" id="searchBtn">검색</button>
                                </form>
                            </li>
                        </div>
                    </div>
                    <p>${result}</p>
                    </div>
                </div>
            </div>
        </div>

    <span id="top_btn">top</span>  
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>