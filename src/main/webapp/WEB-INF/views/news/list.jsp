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
		margin-top: 50px;
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
		position: relative;
   		bottom: -513px;
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
    $(function () {
            
            console.clear();
            console.debug("start ");
            
            $('#regBtn').on('click',function(){
            	location.href = "/news/register"
            });

            $('a.prev, a.next').on('click',function (e) {
                console.debug("onclicked a. next and a.prec ");
                console.log("/t+ this:"+ this);  

                e.preventDefault(); 

                var paginationForm = $('#paginationForm'); 
                paginationForm.attr('action','/listPerPage');
                paginationForm.attr('method','GET');   //버튼이 눌려서 가는 요청이 컨트롤러로 가도록 한다. 
        
                paginationForm.find('input[name=currPage]').val($(this).attr('href'));
                paginationForm.find('input[name=amount]').val('${pageMaker.cri.amount}');
                paginationForm.find('input[name=pagesPerPage]').val('${pageMaker.cri.pagesPerPage}');
      
                paginationForm.submit();
            // on  click prev / next 
    	
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
                <h2 class="asideMenu">미디어센터</h2>
                <ul id="parent">
                    <li><a class="chk" href="/photo/listPerPage">포토갤러리</a></li>
                    <li><a class="chk" href="/news/listPerPage">보도자료</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 미디어센터 > 보도자료 </div>
                    <h2 class="subName">보도자료</h2>
                </div>
                      <div class="contentIn">
              	<div class="wrapper">
					<table border =1 >
                        <thead>
                            <tr>
                                <th width=7%>글번호</th>
                                <th width=*>제목</th>
                                <th width=10%>작성자</th>
                                <th width=10%>등록일</th>
                                <th width=7%>조회수</th>
                            </tr>
                        </thead>

					         <c:set var="number" value="${pageMaker.totalAmount - (pageMaker.cri.currPage - 1) * pageMaker.cri.amount}"/>
                                <c:forEach items="${list}" var="board" >
                                        <tr>                
                                            <td>${number}</td>
                                            <td><a href ="/news/get?bno=${board.bno}">
                                            <c:out value="${board.title}"/></a></td>
                                            <td><c:out value="${board.memberid}"/></td>
                                            <td><fmt:formatDate pattern="yyyy/MM/dd" value="${board.insert_ts}"/></td>
                                            <td><c:out value="${board.readcnt}"/></td>
                                        </tr>
                                <c:set var="number" value="${number-1}"/>
                                </c:forEach>

                                 <c:if test="${__LOGIN__.membertype == '관리자'}">
                                    <button id="regBtn" type="button">글쓰기</button>
                                </c:if>
					</table>
			</div>

<!--페이징 처리 -->
 
	       <div id="pagination">
		            <form action="" id="pagenationForm">
		            
		                <input type="hidden" name="currPage">
		                <input type="hidden" name="amount">
		                <input type="hidden" name="pagesPerPage">
		                
		                <ul class="page">
		                	<c:set var="rep" value="${pageMaker.realEndPage}" />
		                	<c:set var="curr" value="${pageMaker.cri.currPage}"/>
		                	<fmt:formatNumber value="${curr}" type="number" var="currNumber" />
                            <li><a class="start" href="/news/listPerPage">첫페이지</a></li>
                         <c:choose>
	                         <c:when test="${curr eq 1}">
	                            <li><a class="prev" href="/news/listPerPage?currPage=${pageNum}=1&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}">이전</a></li>
	                         </c:when>
	                         <c:when test="${curr%10 eq 1}">
	                         	<li><a class="prev" href="/news/listPerPage?currPage=${pageMaker.startPage-10}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}">이전</a></li>
	                         </c:when>
	                         <c:otherwise>
	                            <li><a class="prev" href="/news/listPerPage?currPage=${pageMaker.startPage}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}">이전</a></li>
	                         </c:otherwise>
                   		 </c:choose>
		                    	
		                    <c:forEach
		                    	 begin="${pageMaker.startPage}"
		                    	 end="${pageMaker.endPage}" 
		                    	 var="pageNum" >
		
		                         <li class="${pageMaker.cri.currPage == pageNum ? 'currPage':''}">
			                         <a href="/news/listPerPage?currPage=${pageNum}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}">
			                  		 ${pageNum}
			                  		 </a>
		                  		 </li>
		
		                    </c:forEach>
		             
		                    <c:choose>
		                    	<c:when test="${curr eq rep}">
		                    		<li><a class="next" href="/news/listPerPage?currPage=${pageMaker.realEndPage}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}">다음</a></li>
		                    	</c:when>
		                    	<c:otherwise>
                            		<li><a class="next"href="/news/listPerPage?currPage=${pageMaker.realEndPage}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}">다음</a></li>
		                    	</c:otherwise>
		                    </c:choose>
                            <li><a class="end" href="/news/listPerPage?currPage=${pageMaker.realEndPage}&amount=${pageMaker.cri.amount}&pagesPerPage=${pageMaker.cri.pagesPerPage}">끝페이지</a></li>
		                </ul>
		            
		            </form>
		
		        </div>
		            <table>
		                <caption>
		                    <ul>
		                        <li>
		                            <form id="searchForm" action="/news/listPerPage" method="GET">
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