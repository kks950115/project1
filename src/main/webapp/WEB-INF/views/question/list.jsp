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
 #wrapper {
        width: 1200px;
        
        display: flex;
        flex-direction: column;
        justify-content: space-around;
        
    }

    input.search2{
        display: block;
        width: 200px;
        height: 35px;

       
        
    }

    select.search1{
        width: 100px;
        height: 40px;
    }
    
    .search1,.search2{
        margin-left: 5px;
    }
   

    thead {
        padding: 10px;

        color: black;
        background-color: #f4f6f7;

        font-size: 16px;
    }

    td{
        padding: 3px;
        
    }

    tr:hover{
        background-color: #f4f6f7;
    }

    a, a:link, a:visited {
        text-decoration: none;

        color: black;

        cursor: pointer;
    } 


    #pagination {
        width: 95%;
        height: 70px;
        
        display: flex;
        justify-content: center;
    }

    #pagination li{
        display: inline-block;
        width: 30px;
        height: 30px;
    }
    #pagination li a{

        width: 30px;
        height: 30px;
        
        display: inline-block;

        text-align: center;
        line-height: 30px;

        /* border: 1px solid #ddd; */

    }

    /* .prev, .next{
        width: 70px !important;
        height: 30px;
        color: white;
        background-color: #005bbb;
    } */

    #top{
        width: 95%;
        height: 50px;
        
    }

    #searchForm{
        
        height: 70px;

        display: flex;
        justify-content: center;
    }
    button{
        
        width: 100px;
        height: 40px;
        line-height: 40px;
        
        
        color: white;
        border: 1px cornflowerblue solid;
        background-color: #005bbb;;

        cursor: pointer;

    }
    
    li.currPage{
        border: 1px solid black;
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
    #count_list{
        padding: 20px 0 10px 0;

    }

   
    button:hover {
    cursor: pointer;
    }

    #buttons{
        display: flex;
        justify-content: flex-end;

        margin: 10px 0 10px 0;
    }

    /* ===================================================== */

    table {
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
        background-color: rgba(187, 187, 187, 0.1);
    }

    a, a:link, a:visited {
        text-decoration: none;
        color: black;
        cursor: pointer;
    }

    /* 제목 */
    td:nth-child(2) {
        text-align: justify;
        text-align: left; 
        padding-left: 10px;
        /* width: 500px; */

    }
  
    /* no*/
    td:nth-child(1){
        width: 70px;
    }
    /* 조회수  */
    td:nth-child(5)  {
        width: 100px;
    }
    /* 작성자,등록일 */
    td:nth-child(3),td:nth-child(4) {
        width: 130px;
    }
    /* 파일첨부 */
    th:nth-child(6) {
        font-size: 17px;
        width: 80px;
    }


    #lockImg{
        padding: 5px 0 0;
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
        

        var result = '${__RESULT__}';

        if(result.length>0){
            console.log("event trigered");
            alert(result);
        }//if

        $('#registerBtn').on('click',function () {
            location.href="/question/register";
        });//onclick

        $('a.prev, a.next, a.end').on('click' , function (e) {
            console.debug();
            console.log('\t + this:', this);

            e.preventDefault(); // Event 에 의한 선택된 요소의 기본 동작을 금지! 

            var paginationForm = $('#paginationform');

            paginationForm.attr('action', '/question/list');
            paginationForm.attr('method', 'GET');

                                                    //a 태그의 href 속성을 끄집어내서
            //input 태그의 Value 속성의 값으로 집어 넣음. 
            paginationForm.find('input[name=currPage]').val( $(this).attr('href') );
            paginationForm.find('input[name=amount]').val( '${__PAGE__.cri.amount}');
            paginationForm.find('input[name=pagesPerPage]').val('${__PAGE__.cri.pagesPerPage}');

            paginationForm.submit();

        }); //onclick for Prev, Next button
       
        
        $('li.prev, li.start').on('click',function () {
            console.log('on click triggered.. ');

            var paginationForm = $('#paginationform');

            paginationForm.attr('action', '/question/list');
            paginationForm.attr('method', 'GET');

            paginationForm.find('input[name=currPage]').val( '1' );
            paginationForm.find('input[name=amount]').val( '${__PAGE__.cri.amount}');
            paginationForm.find('input[name=pagesPerPage]').val('${__PAGE__.cri.pagesPerPage}');

            paginationForm.submit();

        });//li.prev on click event
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
                    <div class="map">home > 고객센터 > 질문게시판 </div>
                    <h2 class="subName">질문게시판</h2>
                </div>
                <div class="contentIn">
                	
                    <div id="wrapper">
                            
                        <p id="count_list">전체 글 수 : ${__PAGE__.totalAmount}</p>

                        <table border="1">
                            
                            <thead>
                                <tr>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>등록일</th>
                                    <th>조회수</th>
                                    <th>첨부파일</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:set var="no" value="${__PAGE__.totalAmount - (__PAGE__.cri.currPage - 1) * __PAGE__.cri.amount}"/>
                                <c:forEach items="${__LIST__}" var="list">
                                    <tr>
                                        <td>${no}</td>
                                        
                                        
                                        <td>
                                          
                                          <c:if test="${list.repindent>0}" >
                                            <c:forEach begin ="1" end="${list.repindent}">
                                                <%= "&nbsp;&nbsp;" %>
                                            </c:forEach>
                                            RE:
                                          </c:if>  
                                            <a href="/question/get?bno=${list.bno}&currPage=${__PAGE__.cri.currPage}&amount=${__PAGE__.cri.amount}&pagesPerPage=${__PAGE__.cri.pagesPerPage}">${list.title}</a>
                                            <c:if test="${list.public_tf == 'F'}"><img src="/resources/img/question_lock_icon.png" width="15" height="15" id="lockImg"></c:if> 
                                        </td>

                                        <td>${list.memberid}</td>
                                        
                                        <td>
                                            <fmt:formatDate value="${list.insert_ts}" pattern="yyyy/MM/dd"/>
                                        </td>
                                        <td>${list.readcnt}</td>
                                        <td>
                                            <c:if test="${not empty list.fid}">
                                                <img src="/resources/file.png">
                                            </c:if>
                                        </td>
                                    </tr>
                				<c:set var="no" value="${no-1}"/>
                                </c:forEach>
                            </tbody>
                        </table>

                        
                        <div id="buttons">
                            <c:if test="${not empty __LOGIN__.memberid}">
                                <button type="button" id="registerBtn">글쓰기</button>

                            </c:if>
                        </div>
                        
                        <!-- paging -->
                        <div id="pagination">
                            <form id="paginationform">
                                <input type="hidden" name="currPage">
                                <input type="hidden" name="amount">
                                <input type="hidden" name="pagesPerPage">
                                
                                <ul>

                                    <li class="start"><a href="/question/list">첫페이지</a></li>

                                    <c:if test="${!__PAGE__.prev}">
                                        <li class="prev"><a href="/question/list">prev</a></li>
                                    </c:if>

                                    <c:if test="${__PAGE__.prev}">
                                        <li class="prev"><a class="prev" href="${__PAGE__.startPage-1}">Prev</a></li>
                                    </c:if>
                                    
                                    <c:forEach 
                                        begin="${__PAGE__.startPage}" 
                                        end="${__PAGE__.endPage}" 
                                        var="pageNum">

                                        <li class="${__PAGE__.cri.currPage == pageNum? 'currPage' : ''}">
                                            
                                            <a 	class="${__PAGE__.cri.currPage == pageNum? 'currPage' : ''}" 
                                            href="/question/list?currPage=${pageNum}&amount=${__PAGE__.cri.amount}&pagesPerPage=${__PAGE__.cri.pagesPerPage}&type=${__PAGE__.cri.type}&keyword=${__PAGE__.cri.keyword}">
                                            ${pageNum}
                                            </a>
                                        
                                        </li>
                                    </c:forEach>
                                
                                    <c:if test="${__PAGE__.next}" >
                                        <li class="next"><a href="${__PAGE__.endPage+1}">Next</a></li>
                                    </c:if>

                                    <c:if test="${!__PAGE__.next}">
                                        <li><a class="next" href="${__PAGE__.realEndPage}">Next</a></li>
                                    </c:if>

                                    <li><a class="end" href="${__PAGE__.realEndPage}">끝페이지</a></li>
                                </ul>
                            </form>
                        </div>

                        <!-- =================search================= -->
                        <form id="searchForm" action="/question/list" method="GET">
            
                            <input type="hidden" name="currPage"        value="1">
                            <input type="hidden" name="amount"          value="${__PAGE__.cri.amount}">
                            <input type="hidden" name="pagesPerPage"    value="${__PAGE__.cri.pagesPerPage}">
                            
                            <select name="type" class="search1">
                                <option>검색조건</option>
                                <option value="T" ${ ("T" eq __PAGE__.cri.type) ? "selected" : ""}>제목</option>
                                <option value="C" ${ ("C" eq __PAGE__.cri.type) ? "selected" : ""}>내용</option>
                                <option value="W" ${ ("W" eq __PAGE__.cri.type) ? "selected" : ""}>작성자</option>
                                <option value="TC" ${ ("TC" eq __PAGE__.cri.type) ? "selected" : ""}>제목+내용</option>
                            </select>
        
                            <input type="text" name="keyword" class="search2" value="${__PAGE__.cri.keyword}">
        
                            <button class="search1">검색</button>
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