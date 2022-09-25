<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
    
    <head>
        <meta charset="UTF-8">
        <title>내가쓴댓글</title>
        
        <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
        <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
        <link href="/resources/css/mypage_replymanage.css" rel="stylesheet"  type="text/css">
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
        <script src="/resources/js/fullnav.js"></script>
        <script src="/resources/js/mypage_replymanage.js"></script>
        <script src="/resources/js/top.js"></script>
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
    $(function () {
        
        var result='${__RESULT__}';

        if(result.length>0){
            alert(result);
        }//if

        $('a.prev, a.next, a.end').on('click' , function (e) {
            console.debug();
            console.log('\t + this:', this);

            e.preventDefault(); // Event 에 의한 선택된 요소의 기본 동작을 금지! 

            var paginationForm = $('#paginationForm');

            paginationForm.attr('action', '/mypage/replymanage');
            paginationForm.attr('method', 'GET');

                                                    //a 태그의 href 속성을 끄집어내서
            //input 태그의 Value 속성의 값으로 집어 넣음. 
            paginationForm.find('input[name=currPage]').val( $(this).attr('href') );
            paginationForm.find('input[name=amount]').val( '${__PAGE__.cri.amount}');
            paginationForm.find('input[name=pagesPerPage]').val('${__PAGE__.cri.pagesPerPage}');

            paginationForm.submit();

        }); //onclick for Prev, Next button

        $('li.prev').on('click',function () {
            console.log('on click triggered.. ');

            var paginationForm = $('#paginationForm');

            paginationForm.attr('action', '/mypage/replymanage');
            paginationForm.attr('method', 'GET');

            paginationForm.find('input[name=currPage]').val( '1' );
            paginationForm.find('input[name=amount]').val( '${__PAGE__.cri.amount}');
            paginationForm.find('input[name=pagesPerPage]').val('${__PAGE__.cri.pagesPerPage}');

            paginationForm.submit();

        });//li.prev on click event

           // 검색
        $('#searchBtn').on('click',function () {
            console.log('searchBtn on click triggered');

            let searchForm = $('#replyForm');
            
            searchForm.attr('action', '/mypage/replymanage');
            searchForm.attr('method', 'GET');

            searchForm.find('select[name=bname]').val('');
            
            searchForm.append('<input type="hidden" name="type" value="C">');

            //검색 키워드 변수에 담기 
            let recon = $('#recontent').val();
            searchForm.append('<input type="hidden" name="keyword" value="'+recon+'">');

            searchForm.submit();
        });//sarch on click
    });//.jq
</script>


<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">마이페이지</h2>
                <ul id="parent">
                    <li><a class="chk" href="/mypage/myInfo">회원정보변경</a></li>
                    <li><a class="chk" href="/mypage/modifypassword">비밀번호변경</a></li>
                    <li><a class="chk" href="/myBoard/list?memberid=${__LOGIN__.memberid}">내가쓴글</a></li>
                    <li><a class="chk" href="/mypage/replymanage">내가쓴댓글</a></li>
                    <li><a class="chk" href="/mypage/dropauth">회원탈퇴</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 마이페이지 > 내가쓴댓글</div>
                    <h2 class="subName">내가쓴댓글</h2>
                </div>

                <div class="contentIn">
                    <div id="wrapper">
                        <p> 총 댓글 수 : ${__PAGE__.totalAmount}</p>
                        <div id="con_reply">
                            <form action="/mypage/replydelete" method="POST" id="replyForm">
                                <table border="1">
                                    <thead>
                                        <tr>
                                            <th>선택</th>
                                           
                                            <th>
                                                <select name="bname" id="bname">
                                                    <option value="null">전체보기</option>
                                                    <option value="question"    ${ ("question"  eq __PAGE__.cri.bname) ? "selected" : ""}>질문게시판</option>
                                                    <option value="anony"       ${ ("anony"     eq __PAGE__.cri.bname) ? "selected" : ""}>고객의소리</option>
                                                    <option value="자유게시판"        ${ ("free"      eq __PAGE__.cri.bname) ? "selected" : ""}>자유게시판</option>
                                                </select>
                                            </th>
                                            
                                            <th>댓글내용</th>
                                            <th>날짜</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${__REPLY__}" var="reply">
                                            <tr>
                                                <td><input type="checkbox" name="reno" value="${reply.reno}"></td>
                                                <!-- 게시판 이름  -->
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${reply.bname eq 'anony'}">고객의소리</c:when>
                                                        <c:when test="${reply.bname eq 'question'}">질문게시판</c:when>
                                                        <c:when test="${reply.bname eq '자유게시판'}">자유게시판</c:when>
                                                        <c:otherwise>${reply.bname}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${reply.bname eq '자유게시판'}"><a href="/free/read?bno=${reply.bno}">${reply.recontent}</a></c:when>
                                                        <c:otherwise><a href="/${reply.bname}/get?bno=${reply.bno}">${reply.recontent}</a></c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <td><fmt:formatDate value="${reply.redate}" pattern="yyyy/MM/dd"/></td>
                                                
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <button type="submit" id="deleteBtn">선택삭제</button>
                            </form>   
                        </div> 
                        
                        <!-- pagination -->
                        <div id="pagination">
                            <form action="/mypage/replymanage" id="paginationForm">
                                <input type="hidden" name="currPage">
                                <input type="hidden" name="amount">
                                <input type="hidden" name="pagesPerPage">
                                
                                <ul>
                                    <!-- 무조건 처음페이지로 -->
                                    <li ><a class="start" href="/mypage/replymanage?currPage=1&amount=${__PAGE__.cri.amount}&pagesPerPage=${__PAGE__.cri.pagesPerPage}">처음</a></li>
                                    
                                    
                                    <!-- 활성화x일때 처음 페이지로 -->
                                    <c:if test="${!__PAGE__.prev}">
                                        <li class="prev"><a href="/mypage/replymanage?currPage=1&amount=${__PAGE__.cri.amount}&pagesPerPage=${__PAGE__.cri.pagesPerPage}">이전</a></li>
                                    </c:if>
                                    
                                    <c:if test="${__PAGE__.prev}">
                                        <li><a class="prev" href="${__PAGE__.startPage-1}">이전</a></li>
                                    </c:if>
                                    <!--  -->
                                    
                                    <!-- paiging for -->
                                    <c:forEach var="pageNum" begin="${__PAGE__.startPage}" end="${__PAGE__.endPage}">
                                        <li class="${__PAGE__.cri.currPage == pageNum ? 'currPage' : ''}">
                                            <a href="/mypage/replymanage?currPage=${pageNum}&amount=${__PAGE__.cri.amount}&pagesPerPage=${__PAGE__.cri.pagesPerPage}">${pageNum}</a>
                                        </li>
                                    </c:forEach>
                                    <!-- end forEach -->
                                    
                                    <!-- next btn  -->
                                    <c:if test="${__PAGE__.next}">
                                        <li ><a class="next" href="${__PAGE__.endPage+1}">next</a></li>
                                    </c:if>
                                    
                                    <c:if test="${!__PAGE__.next}">
                                        <li ><a class="next" href="${__PAGE__.realEndPage}">next</a></li>
                                    </c:if>
                                    
                                    <!-- real End btn -->
                                    <li ><a class="end" href="${__PAGE__.realEndPage}">끝</a></li>
                                </ul>
                            </form>
                        </div> <!-- end pagination-->
                        
                        <div id="searchBox">
                            <!-- <input type="hidden" name="currPage"        value="1">
                            <input type="hidden" name="amount"          value="${__PAGE__.cri.amount}">
                            <input type="hidden" name="pagesPerPage"    value="${__PAGE__.cri.pagesPerPage}"> -->
                    
                            <!-- <input type="hidden" name="type" value="C"> -->
                            <input type="text" id="recontent" name="keyword" value="${__PAGE__.cri.keyword}" placeholder="검색할 댓글 내용을 입력하세요">
                            
                            <button type="button" id="searchBtn">검색</button>
                            
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