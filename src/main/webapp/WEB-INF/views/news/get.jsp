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
    
    #btn_wrap{
        width:100%;
        height:50px;
    }
    
    .btn{
        width: 100px;
        height: 40px;
        line-hight: 40px;
        text-align:center;
        background:#005bbb;
        color:#fff;
        font-size:15px;
        border:0;
        cursor:pointer;
        margin-top:10px;
    
    }
    

    #modifyBtn{
        float: left;
        margin-left:5px;
    }
    
    #removeBtn{
        float: left;
        margin-left:5px;
    }
    
    #regBtn{
        float:left;
        margin-left:5px;
    
    }
    
    #listBtn{
        float: right;
    }
    
    .read_no{
        margin-top: 50px;
        border-bottom:3px solid #005bbb;
        padding-bottom:5px;
    }
    
    #read_Wrap{
        width:100%;
    }
    
    #title_wrap{
        width:100%;
        height:40px;
        background:#fff;
    }
    
    
    #title_wrap .title_area{
        width:85%;
        float:left;
        height:40px;
        line-height:40px;
        
        font-size:20px;
        font-weight:bold;
    }
    
    #title_wrap .writer_area{
        width:15%;
        float:right;
        font-size:20px;
        height:40px;
        line-height:40px;
        text-align:center;
    }
    

    
    #date_wrap{
        width:100%;
        height:40px;
        background:#eee;
        
    }
    
    #date_wrap .reg_date{
        width:85%;
        float:left;
        height:40px;
        line-height:40px;
        font-size:15px;
        
    }
    
    #date_wrap .readcnt{
        width:15%;
        float:right;
        font-size:15px;
        height:40px;
        line-height:40px;
        text-align:center;
        
    }
    
    #content_wrap{
        min-height:300px;
        border-top: 1px solid #eee;
        border-bottom: 1px solid #eee;
        padding: 30px 0 30px 10px;
        font-size:15px;
        margin:10px 0 20px 0;
    }
    
</style>

<script>
   	  $(function(){
        console.clear();
        console.debug("start");
        
        $('#listBtn').on('click',function () {
            console.log("modifyBtn button clicked"); 
            
            location.href="/news/listPerPage?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
        });
        
        
        $('#modifyBtn').on('click', function(){
          console.log("modifyBtn button clicked"); 
          
          location.href="/news/modify?bno=${board.bno}"
          
         });// .onclick  
         
        $('#removeBtn').on('click',function(){
       		var result = confirm('게시글을 삭제 하시겠습니까?');
       		
       		if(result){
   			 	var formObj = $('#form');
                formObj.attr('action',"/news/remove");
                formObj.attr('method',"post");
                formObj.submit();
       		}else{

       		}
       		
            });
         
         
    })//end jq
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
</head>

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
                	<div class="wraper">
                        <form id="form">
                        <input type="hidden" id="bno" name="bno" value="${board.bno}">
                        <div class="read_no">글번호: ${board.bno}</div>
                            <div id="title_wrap">
                                <div class="title_area">${board.title}</div>
                                <div class="writer_area">작성자:${board.memberid}</div>
                            </div>

                            <div id="date_wrap">
                                <div class="reg_date">작성일:<fmt:formatDate pattern="yyyy/MM/dd"  value="${board.insert_ts}"/></div>
                                <div class="readcnt">조회수:${board.readcnt}</div>
                                </div>
                            <div id="content_wrap">${board.content}</div>
                    
                            <div id="btn_wrap">

                                   <c:if test="${__LOGIN__.membertype == '관리자'}">
                                   <button id="modifyBtn" class="btn" type="button">수정</button>
                                   <button id="removeBtn" class="btn" type="button">삭제</button>
                                </c:if>	    
                                <button id="listBtn" class="btn" type="button">목록</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div><!--containerIn-->
        </div>

   	<span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>