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
    <link href="/resources/css/myBoard.css" rel="stylesheet" type="text/css" />
    
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

        $('#listBtn').on('click',function(){

            location.href = "/myBoard/list?memberid=${__LOGIN__.memberid}&currPage=${page.cri.currPage}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}";

        });//listBtn

        $('#selectDelBtn').on('click',function(e){//체크박스 눌렀을 때
            e.preventDefault();

            if( $('input[name=bno]:checked').length >0 ){

                var result = confirm("정말 삭제하시겠습니까?");

                if(result){//확인 눌렀을 때
                    console.log("True")

                    var checkboxDelForm = $('#checkboxDelForm');
                    
                    checkboxDelForm.attr('action','/myBoard/remove');
                    checkboxDelForm.attr('method','POST');
                    
                    checkboxDelForm.submit();
                    
                } else {//취소 눌렀을 때
                    console.log("False")
                    return false;
                }//if-else

            } else {
                alert("선택된 것이 없습니다.")
            }//if-else

        })//selectDelBtn


        // 페이징
        $('a.prev, a.next, a.end').on('click',function(e) {

            e.preventDefault();

            var paginationForm = $('#paginationForm');

            paginationForm.attr('action','/myBoard/list');
            paginationForm.attr('method','GET');

            paginationForm.find('input[name=currPage]').val($(this).attr('href'));
            paginationForm.find('input[name=amount]').val('${page.cri.amount}');
            paginationForm.find('input[name=pagesPerPage]').val('${page.cri.pagesPerPage}');
            paginationForm.find('input[name=bname]').val('${page.cri.bname}');
            paginationForm.submit();

        })//onclick

        var boardVal='';


        $('#boardOption').change(function(){//
           
            boardVal = $(this).val();
            
            console.log('boardVal값:',boardVal);

            var selectBoardForm = $('#selectBoardForm');
            selectBoardForm.attr('action','/myBoard/list');
            selectBoardForm.attr('method','GET');

            selectBoardForm.append('<input type="hidden" name="memberid" value="${__LOGIN__.memberid}">');
            selectBoardForm.append('<input type="hidden" name="currPage" value="1">');
            selectBoardForm.append('<input type="hidden" name="amount" value="${page.cri.amount}">');
            selectBoardForm.append('<input type="hidden" name="pagesPerPage" value="${page.cri.pagesPerPage}">');
            selectBoardForm.append('<input type="hidden" name="bname" value="'+boardVal+'">');
            selectBoardForm.append('<input type="hidden" name="type" value="${page.cri.type}">');
            selectBoardForm.append('<input type="hidden" name="keyword" value="${page.cri.keyword}">');
            selectBoardForm.submit();

        })//boardOption


        // 체크박스 전체선택
        $("input:checkbox[name='bnoAll']").click(function(){
            if($(this).is(":checked")){
                $("input:checkbox[name='bno']").each(function() {
                    $(this).prop("checked",true);
                });
                
            }else{
                $("input:checkbox[name='bno']").each(function() {
                    $(this).prop("checked",false);
                });
                
            }
        });
    })//.jq
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
                    <div class="map">home > 마이페이지 > 내가쓴글</div>
                    <h2 class="subName">내가쓴글</h2>
                </div>

                <div class="contentIn">
                    <p id="totalCount">전체글 수 : ${page.totalAmount}</p>
                    <table>
                        <thead>
                            <form id="selectBoardForm"></form>
                                <tr>
                                    <th><input type="checkbox" name="bnoAll"></th>
                                    <th>번호</th>
                                    <th>제목</th>
                                    <th>내용</th>
                                    <th>등록일</th>
                                    <th>조회수</th>
                                    <th>
                                        <select id="boardOption" name="bname" class="searchcss">
                                            <option value=>전체게시판</option>
                                            <option value="anony" ${("anony" eq cri.bname) ? 'selected' : ''}>고객의소리</option>
                                            <option value="question" ${("question" eq cri.bname) ? 'selected' : ''}>질문게시판</option>
                                            <option value="자유게시판" ${("자유게시판" eq cri.bname) ? 'selected' : ''}>자유게시판</option>
        
                                        </select>
                                    </th>
                                </tr>
                            </form>
                        </thead>
                        <tbody>
                            <form id="checkboxDelForm">
                                <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
        
                                <c:set var="num" value="${page.totalAmount - ( page.cri.currPage - 1 ) * page.cri.amount}"/>
                                <c:forEach items="${list}" var="board">
                                    <tr>
                                        <td><input type="checkbox" name="bno" value="${board.bno}"></td>
                                        <td>${num}</td>

                                        <!-- 게시판명 -->
                                        <td>
                                            
                                            <c:choose>
                                                <c:when test="${board.bname =='자유게시판'}">
                                                    <a href="/free/read?bno=${board.bno}&bname=free&readcnt=${board.readcnt}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}">
                                                        <p class="ptitle">
                                                            <!-- 답글 -->
                                                            <c:forEach begin="1" end="${board.repstep}">
                                                                &nbsp;ㄴre:
                                                            </c:forEach>
                                                            <!-- 제목 -->
                                                            ${board.title}
                                                            <!-- 댓글수 -->
                                                            <c:if test="${board.renoCount > 0}">
                                                                [${board.renoCount}]
                                                            </c:if>
                                                        </p>
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="/${board.bname}/get?bno=${board.bno}&bname=${board.bname}&readcnt=${board.readcnt}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}">
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
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
        
                                        <td>
                                            <p class="ptitle">${board.content}</p>
                                        </td>
                                        <td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.insert_ts}"/></td>
                                        <td>${board.readcnt}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${board.bname eq 'anony'}">고객의소리</c:when>
                                                <c:when test="${board.bname eq 'question'}">질문게시판</c:when>
                                                <c:when test="${board.bname eq 'free'}">자유게시판</c:when>
                                                <c:otherwise>${board.bname}</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <c:set var="num" value="${num-1}"/>
                                </c:forEach>
                            </form>
                        </tbody>
                    </table>
                    <div class="getBtn">
                        <div><button type="button" id="selectDelBtn" class="buttonstyle">선택삭제</button></div>
                        <div><button type="button" id="listBtn" class="buttonstyle">목록</button></div>
                    </div>
                
                    <p>&nbsp;</p>
        
                    <div id="pagination">
                        <form action="/myBoard/list" id="paginationForm">
                            <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                            <input type="hidden" name="currPage">
                            <input type="hidden" name="amount">
                            <input type="hidden" name="pagesPerPage">
                            <input type="hidden" name="bname">
        
                            <ul>
                                <!-- 무조건 처음페이지로 -->
                                <li class="start"><a href="/myBoard/list?memberid=${__LOGIN__.memberid}&currPage=1&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyword=${page.cri.keyword}&bname=${page.cri.bname}">첫페이지</a></li>
                                <!-- 활성화x일때 처음 페이지로 -->
                                <c:if test="${!page.prev}">
                                    <li class="prev"><a href="/myBoard/list?memberid=${__LOGIN__.memberid}&currPage=1&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyword=${page.cri.keyword}&bname=${page.cri.bname}">이전</a></li>
                                </c:if>

                                <c:if test="${page.prev}">
                                    <li><a class="prev" href="${page.startPage-1}"><</a></li>
                                </c:if>
                                <!--  -->
                                <c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
                                    <li class="${page.cri.currPage == pageNum ? 'currPage' : ''}">
                                        <a href="/myBoard/list?memberid=${__LOGIN__.memberid}&currPage=${pageNum}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyword=${page.cri.keyword}&bname=${page.cri.bname}">${pageNum}</a>
                                    </li>
                                </c:forEach>
                                <!--  -->
                                <c:if test="${page.next}">
                                    <li><a class="next" href="${page.endPage+1}">다음</a></li>
                                </c:if>

                                <c:if test="${!page.next}">
                                    <li><a class="next" href="${page.realEndPage}">다음</a></li>
                                </c:if>

                                <li><a class="end" href="${page.realEndPage}">마지막페이지</a></li>
                            </ul>
                        </form>
                    </div>
                    <ul id="searchMenu">
                        <li>
                            <form action="/myBoard/list" method="GET" id="searchMenuForm">
                                <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                                <input type="hidden" name="currPage" value="1">
                                <input type="hidden" name="amount" value="${page.cri.amount}">
                                <input type="hidden" name="pagesPerPage" value="${page.cri.pagesPerPage}">
                                <input type="hidden" name="bname" value="${cri.bname}">
                                
                                <select name="type" class="searchcss">
                                    <option>검색조건</option>
                                    <option value="T" ${("T" eq page.cri.type) ? 'selected' : ''}>제목</option>
                                    <option value="C" ${("C" eq page.cri.type) ? 'selected' : ''}>내용</option>
                                    <option value="TC" ${("TC" eq page.cri.type) ? 'selected' : ''}>제목+내용</option>
                                </select>
        
                                <input type="text" class="searchcss" name="keyword" value="${page.cri.keyword}">
                                <button type="submit" id="searchBtn" class="buttonstyle">검색</button>
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