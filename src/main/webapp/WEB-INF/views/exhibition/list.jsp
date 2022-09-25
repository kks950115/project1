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
    <link rel="stylesheet" href="/resources/css/exhibition.css">
    
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
     
        //일정등록
        $('#exRegBtn').on('click',function(){
            
            location.href = "/exhibition/register?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

        });//regBtn

        //목록보기
        $('#exListBtn').on('click',function(){

            location.href = "/exhibition/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

        });//listBtn

        // 페이징
        $('a.prev, a.next, a.end').on('click',function(e) {

            e.preventDefault();

            var paginationForm = $('#paginationForm');

            paginationForm.attr('action','/exhibition/list');
            paginationForm.attr('method','GET');

            paginationForm.find('input[name=currPage]').val($(this).attr('href'));
            paginationForm.find('input[name=amount]').val('${page.cri.amount}');
            paginationForm.find('input[name=pagesPerPage]').val('${page.cri.pagesPerPage}');
            paginationForm.submit();

        })//onclick

        $('#selectDelBtn').on('click',function(e){//체크박스 눌렀을 때
            e.preventDefault();
            
            if( $('input[name=exno]:checked').length >0 ){

                var result = confirm("정말 삭제하시겠습니까?");

                if(result){//확인 눌렀을 때
                    console.log("True")

                    var checkboxDelForm = $('#checkboxDelForm');
                    
                    checkboxDelForm.attr('action','/exhibition/remove');
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

        $('#calendarBtn').click(function(){
            location.href = "/exhibition/calendar";
        })

        // 체크박스 전체선택
        $("input:checkbox[name='exnoAll']").click(function(){
            if($(this).is(":checked")){
                $("input:checkbox[name='exno']").each(function() {
                    $(this).prop("checked",true);
                });
                
            }else{
                $("input:checkbox[name='exno']").each(function() {
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
                <h2 class="asideMenu">관리페이지</h2>
                <ul id="parent">
                    <li><a class="chk" href="/mypage/adminInfo">기본정보변경</a></li>
                    <li><a class="chk" href="/admin/memberList?membertype=개인">회원관리</a></li>
                    <li><a class="chk" href="/admin/memberBoard">회원글관리</a></li>
                    <li><a class="chk" href="/admin/memberReply">회원댓글관리</a></li>
                    <li><a class="chk" href="/admin/apply">참가기업관리</a></li>
                    <li><a class="chk" href="/exhibition/list">전시일정관리</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 관리페이지 > 전시일정관리 </div>
                    <h2 class="subName">전시일정관리</h2>
                </div>
                <div class="contentIn">
                    <div id="exhibitionWrap">
                        
                        <p id="totalCount">전체글 수 : ${page.totalAmount}</p>

                        <form id="checkboxDelForm">
                             <table>
                                 <thead class="exHeadLine">
                                     <tr>
                                         <th><input type="checkbox" name="exnoAll"></th>
                                         <th>번호</th>
                                         <th>전시명</th>
                                         <th>전시시작일</th>
                                         <th>전시마감일</th>
                                         <th>등록일</th>
                                     </tr>
                                 </thead>
                                 <tbody>
                                     <c:set var="num" value="${page.totalAmount - (page.cri.currPage - 1) * page.cri.amount}"></c:set>
                                     <c:forEach items="${exList}" var="ex">
                                         <tr>
                                             <td><input type="checkbox" name="exno" value="${ex.exno}"></td>
                                             <td>${num}</td>
                                             <td><a href="/exhibition/get?exno=${ex.exno}"><p class="ptitle">${ex.exname}</p></a></td>
                                             <td><fmt:formatDate pattern="yyyy/MM/dd" value="${ex.exstart}"/></td>
                                             <td><fmt:formatDate pattern="yyyy/MM/dd" value="${ex.exend}"/></td>
                                             <td><fmt:formatDate pattern="yyyy/MM/dd" value="${ex.exinsert}"/></td>
                                         </tr>
                                     <c:set var="num" value="${num - 1}"></c:set>
                                     </c:forEach>
                                 </tbody>
                             </table>
                             <div class="btn">
                                 <div>
                                     <button type="submit" id="selectDelBtn" class="buttonstyle">선택삭제</button>
                                     <button type="button" class="buttonstyle" id="exRegBtn">일정등록</button>&nbsp;&nbsp;
                                 </div>
                                 <div class="exreg">
                                     <button type="button" class="buttonstyle" id="calendarBtn">달력으로가기</button>
                                     <button type="button" class="buttonstyle" id="exListBtn">목록</button>
                                 </div>
                             </div>
                         
                         </form>    
                         <p>&nbsp;</p>
             
                         <div id="pagination">
                             <form action="/exhibition/list" id="paginationForm">
                                 <input type="hidden" name="currPage">
                                 <input type="hidden" name="amount">
                                 <input type="hidden" name="pagesPerPage">
             
                                 <ul>
                                     <!-- 무조건 처음페이지로 -->
                                    <li class="start"><a href="/exhibition/list?currPage=1&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyword=${page.cri.keyword}">첫페이지</a></li>

                                    <!-- 활성화x일때 처음 페이지로 -->
                                    <c:if test="${!page.prev}">
                                        <li class="prev"><a href="/exhibition/list?currPage=1&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyword=${page.cri.keyword}">이전</a></li>
                                    </c:if>

                                    <c:if test="${page.prev}">
                                        <li><a class="prev" href="${page.startPage-1}">이전</a></li>
                                    </c:if>
                                    <!--  -->
                                    <c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
                                        <li class="${page.cri.currPage == pageNum ? 'currPage' : ''}">
                                            <a href="/exhibition/list?currPage=${pageNum}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}&type=${page.cri.type}&keyword=${page.cri.keyword}">${pageNum}</a>
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
                                 <form action="/exhibition/list" method="GET" id="searchMenuForm">
                                     <input type="hidden" name="currPage" value="1">
                                     <input type="hidden" name="amount" value="${page.cri.amount}">
                                     <input type="hidden" name="pagesPerPage" value="${page.cri.pagesPerPage}">
                                     
                                     <select name="type" class="searchcss">
                                         <option>검색조건</option>
                                         <option value="T" ${("T" eq page.cri.type) ? 'selected' : ''}>전시명</option>
                                         <option value="C" ${("C" eq page.cri.type) ? 'selected' : ''}>내용</option>
                                         <option value="TC" ${("TC" eq page.cri.type) ? 'selected' : ''}>전시명+내용</option>
                                     </select>
             
                                     <input type="text" class="searchcss" name="keyword" value="${page.cri.keyword}">
                                     <button type="submit" id="searchBtn" class="buttonstyle">검색</button>
                                 </form>
                             </li>
                         </ul>
                     </div>
                </div>
            </div>
        </div>

        <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>