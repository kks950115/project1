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
    <link href="/resources/css/anonyBoard.css" rel="stylesheet" type="text/css" />
    
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

       $('#regBtn').on('click',function(){

            location.href = "/anony/register?bname=anony&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

        });//regBtn

        $('#listBtn').on('click',function(){

            location.href = "/anony/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

        });//listBtn
    
        // 페이징
        $('a.prev, a.next, a.end').on('click',function(e) {

            e.preventDefault();

            var paginationForm = $('#paginationForm');

            paginationForm.attr('action','/anony/list');
            paginationForm.attr('method','GET');

            paginationForm.find('input[name=currPage]').val($(this).attr('href'));
            paginationForm.find('input[name=amount]').val('${page.cri.amount}');
            paginationForm.find('input[name=pagesPerPage]').val('${page.cri.pagesPerPage}');
            paginationForm.submit();

        })//onclick

    })//.jq
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

                <!-- 게시판넣기 -->
                <div class="contentIn">
                    <p id="totalCount">전체글 수 : ${page.totalAmount}</p>
                    <table border="1">
                        <thead>
                            <tr>
                                <th class="noStyle">번호</th>
                                <th>제목</th>
                                <th class="writerStyle">작성자</th>
                                <th class="dateStyle">등록일</th>
                                <th class="noStyle">조회수</th>
                                <th>첨부파일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="number" value="${page.totalAmount - (page.cri.currPage - 1) * page.cri.amount}"/>
                            <c:forEach items="${list}" var="board" >
                                <tr>
                                    <td>${number}</td>
                                    <td>
                                        <a href="/anony/get?bno=${board.bno}&readcnt=${board.readcnt}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}">
                                            <p class="ptitle">
                                                <!-- 답글 -->
                                                <c:forEach begin="1" end="${board.repstep}">
                                                    &nbsp;ㄴre:
                                                </c:forEach>
                                                <!-- 제목 -->
                                                ${board.title}
                                                <c:if test="${board.renoCount > 0}">
                                                    [${board.renoCount}]
                                                </c:if>
                                            </p>
                                        </a>
                                    </td>
        
                                    <c:choose>
                                        <c:when test="${board.public_tf eq 'F'.toString()}">
                                            <td>비공개</td>
                                        </c:when>
                                        <c:otherwise>
                                            <td>${board.memberid}</td>
                                        </c:otherwise>
                                    </c:choose>
        
                                    <td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.insert_ts}"/></td>
                                    <td>${board.readcnt}</td>
                                    <!-- 파일fid여부로 첨부파일 알려주기 -->
                                    <td>
                                        <c:if test="${board.fid != null}">
                                            <img src="/resources/file.png">
                                        </c:if>
                                    </td>
                                </tr>
                                <c:set var="number" value="${number-1}"/>
                            </c:forEach>
                        </tbody>
                    </table>
                    <p>&nbsp;</p>
        
                    <div class="reg">
                        <c:if test="${__LOGIN__.memberid != null and __LOGIN__.memberid != ''}">
                            <button type="button" class="buttonstyle" id="regBtn">글쓰기</button>&nbsp;&nbsp;
                        </c:if>
                        <button type="button" class="buttonstyle" id="listBtn">목록</button>
                    </div>
        
                    <p>&nbsp;</p>
                    <div id="pagination">
                        <form action="/anony/list" id="paginationForm">
                            <input type="hidden" name="currPage">
                            <input type="hidden" name="amount">
                            <input type="hidden" name="pagesPerPage">
                            
                            <ul>
                                <li class="start"><a href="/anony/list">첫페이지</a></li>

                                <c:if test="${!page.prev}">
                                    <li class="prev"><a href="/anony/list">이전</a></li>
                                </c:if>

                                <c:if test="${page.prev}">
                                    <li><a class="prev" href="${page.startPage-1}">이전</a></li>
                                </c:if>
                                
                                <c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
                                    <li class="${page.cri.currPage == pageNum ? 'currPage' : ''}">
                                        <a href="/anony/list?currPage=${pageNum}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyword=${page.cri.keyword}">${pageNum}</a>
                                    </li>
                                </c:forEach>
                                
                                <c:if test="${page.next}">
                                    <li><a class="next" href="${page.endPage+1}">다음</a></li>
                                </c:if>

                                <c:if test="${!page.next}">
                                    <li><a class="next" href="${page.realEndPage}">다음</a></li>
                                </c:if>

                                <li><a class="end" href="${page.realEndPage}">끝페이지</a></li>
                            </ul>
                        </form>
                    </div>
                    <ul id="searchMenu">
                        <li>
                            <form action="/anony/list" method="GET" id="searchMenu">
                                <input type="hidden" name="currPage" value="1">
                                <input type="hidden" name="amount" value="${page.cri.amount}">
                                <input type="hidden" name="pagesPerPage" value="${page.cri.pagesPerPage}">
                                
                                <select name="type" class="searchcss">
                                    <option>검색조건</option>
                                    <option value="T" ${("T" eq page.cri.type) ? 'selected' : ''}>제목</option>
                                    <option value="C" ${("C" eq page.cri.type) ? 'selected' : ''}>내용</option>
                                    <option value="W" ${("W" eq page.cri.type) ? 'selected' : ''}>작성자</option>
                                    <option value="TC" ${("TC" eq page.cri.type) ? 'selected' : ''}>제목+내용</option>
                                </select>
        
                                <input type="text" class="searchcss" name="keyword" value="${page.cri.keyword}">
                                <button type="submit" class="buttonstyle">검색</button>
                            </form>
                        </li>
                    </ul>
                
                </div>
            </div>
        </div>

        <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>