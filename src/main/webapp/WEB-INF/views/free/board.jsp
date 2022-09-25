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
	#totalCount{
		margin: 50px 0 10px 0;
	}

    table{
        width: 1200px;

        border-bottom: 1px ridge black;
        border-collapse: collapse;

        text-align: center;
    }

    th{	
    	font-size:20px;
    	height: 50px;
	    font-size: 20px;
	    border-top: 3px solid #005bbb;
        color: #000;
        background-color: #eee;
        
    }

    td{
        height: 40px;
	    font-size: 15px;
	    text-align: center;
    }

    #regBtn{
		width: 100px;
		height: 40px;
		line-hight: 40px;
		text-align:center;
		background:#005bbb;
		color:#fff;
		font-size:15px;
		border:0;
		cursor:pointer;
		float:right;
		margin-top:10px;
    }

    tr:hover{
        background-color: #eee;
    }

    a, a:link, a:visited{
        text-decoration: none;
        color: black;
        cursor: pointer;
    }
    
    td:nth-child(1){
    	color:#005bbb;
    }
    td:nth-child(2) {
	    text-align: left;
	    padding-left: 10px;
	    overflow: hidden;
	    text-overflow: ellipsis;
	    white-space: nowrap;
	}



    
    .insertDate{
  	 	width:170px;
    }
    
    table ul{
    	display:flex;
    	justify-content: center;
    }
    
    .updateDate{
    	width:170px;
    }

    #pagination{
        width: 100%;
        margin: 0 auto; 
        position: relative;
    }

    #pagination .page{
        display: flex;
        justify-content: center;
        margin:50px 0 20px 0;
        
    }

    #pagination li{
        float: left;
        width: 30px;
        height: 30px;
        text-align: center;
        list-style: none;
        line-height: 30px;
        font-size:16px;
        
        margin-right:10px;
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

    .currPage{
    	border: 1px solid #000;
    }
    .search1{
    	height:35px;
    }
    .search2{
    	height:30px;
    }
        
    .search3{
        display: inline-block;
        background-color: #005bbb;
        color: #fff;
        font-size: 15px;
        width: 100px;
        height: 40px;
		border:0;
        line-height: 40px;
        text-align: center;
    }


</style>

<script>
    $(function(){
        console.clear();
        console.debug('jq started');

        $('#regBtn').click(function(){
            console.debug('onClick on #regBtn clicked');

            location.href = "/free/write?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
            
        });
        
        
    });
</script>
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
                    <div class="map">home > 커뮤니티 > 자유게시판 </div>
                    <h2 class="subName">자유게시판</h2>
                </div>
                <div class="contentIn">
                
                <p id="totalCount">전체글 수 : ${pageMaker.totalAmount}</p>
		        <table border=1>
		            <thead>
		                <tr>
		                    <th width=7%>글번호</th>
		                    <th width=*>제목</th>
		                    <th width=10%>작성자</th>
		                    <th width=10%>등록일</th>
		                    <th width=7%>조회수</th>
		                </tr>
		            </thead>
		            
		            <c:forEach items="${__LIST__}" var="list" varStatus="i">
		                <tbody>
		                    <tr>
		                        <td>${pageMaker.totalAmount - (pageMaker.cri.currPage - 1) * pageMaker.cri.amount - i.index}</td>
		                        <td><a href="read?bno=${list.bno}">${list.title}</a></td>
		                        <td>${list.memberid}</td>
		                        <td class="insertDate"><fmt:formatDate pattern="yyyy/MM/dd" value="${list.insert_ts}" /></td>
		                        <td>${list.readcnt}</td>
		                    </tr>
		                    
		                </tbody>
		            </c:forEach> 
		        </table>
		        
		        <c:if test="${not empty __LOGIN__.memberid}">
					<button id="regBtn" type="button">글쓰기</button>
		        </c:if>
		        
		        <div id="pagination">
		            <form action="" id="pagenationForm">
		            
		                <input type="hidden" name="currPage">
		                <input type="hidden" name="amount">
		                <input type="hidden" name="pagesPerPage">
		                <input type="hidden" name="type">
		                <input type="hidden" name="keyword">
		                
		                <ul class="page">
		                	<c:set var="rep" value="${pageMaker.realEndPage}" />
		                	<c:set var="curr" value="${pageMaker.cri.currPage}"/>
		                	<fmt:formatNumber value="${curr}" type="number" var="currNumber" />
                            <li><a class="start" href="/free/board">첫페이지</a></li>
                         <c:choose>
	                         <c:when test="${curr eq 1}">
	                            <li><a class="prev" href="/free/board?currPage=1&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">이전</a></li>
	                         </c:when>
	                         <c:when test="${curr%10 eq 1}">
	                         	<li><a class="prev" href="/free/board?currPage=${pageMaker.startPage-10}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">이전</a></li>
	                         </c:when>
	                         <c:otherwise>
	                            <li><a class="prev" href="/free/board?currPage=${pageMaker.startPage}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">이전</a></li>
	                         </c:otherwise>
                   		 </c:choose>
		                    	
		                    <c:forEach
		                    	 begin="${pageMaker.startPage}"
		                    	 end="${pageMaker.endPage}" 
		                    	 var="pageNum" >
		
		                         <li class="${pageMaker.cri.currPage == pageNum ? 'currPage':''}">
			                         <a href="/free/board?currPage=${pageNum}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">
			                  		 ${pageNum}
			                  		 </a>
		                  		 </li>
		
		                    </c:forEach>
		             
		                    <c:choose>
		                    	<c:when test="${curr eq rep}">
		                    		<li><a class="next" href="/free/board?currPage=${pageMaker.realEndPage}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">다음</a></li>
		                    	</c:when>
		                    	<c:otherwise>
                            		<li><a class="next" href="/free/board?currPage=${pageMaker.endPage+1}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">다음</a></li>
		                    	</c:otherwise>
		                    </c:choose>
		
                            
                            
                            <li><a class="end" href="/free/board?currPage=${pageMaker.realEndPage}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">끝페이지</a></li>
		                    
		                </ul>
		            
		            </form>
		
		        </div>
		            <table>
		                <caption>
		                    <ul>
		                        <li>
		                            <form id="searchForm" action="/free/board" method="GET">
		                                <input type="hidden" name="currPage" value="1">
		                                <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
		                                <input type="hidden" name="pagesPerPage" value="${pageMaker.cri.pagesPerPage}">
		
		                                <select name="type" class="search1">
		                                    <option value="T" ${ ("T" eq pageMaker.cri.type) ? "selected" : "" }>제목</option>
		                                    <option value="C" ${ ("C" eq pageMaker.cri.type) ? "selected" : "" }>내용</option>
		                                    <option value="W" ${ ("W" eq pageMaker.cri.type) ? "selected" : "" }>작성자</option>
		                                </select>
		
		                                <input type="text" name="keyword" class="search2" value="${pageMaker.cri.keyword}">
		                                <button class="search3">검색</button>
		                            </form>
		                        </li>
		                    </ul>
		                </caption>
		                
		            </table>
                </div>
            </div>
        </div>

    <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>