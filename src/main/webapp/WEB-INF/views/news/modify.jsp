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
    #write_no{
        margin:50px 0 10px 0;
    }
    #write_title_wrap{
        width:100%;
        height:80px;
        background:#eee;
        border-top:3px solid #005bbb;
    }
    #write_title_wrap .write_title_area{
        width:100px;
        padding:10px;
        margin-top:20px;
        float:left;
        line-height:18px;
        text-align:center;
        font-size:20px;
        font-weight:bold;
    }
    
    #write_title_wrap .write_title{
        width:900px;
        margin-top:15px;
        padding:10px;
        float:left;
        font-size:18px;
        font-weight:bold;
    }
    #write_info{
        width:100%;
        height:50px;
        
    }
    
    #write_info .writer_area{
        width:85%;
        float:left;
        height:50px;
        line-height:50px;
        font-size:15px;
        text-indent:10px;
    }
    
    #write_info .readcnt_area{
        width:15%;
        float:right;
        height:50px;
        line-height:50px;
        font-size:15px;
        text-align:center;
        
    }
    
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
    }
    
    #removeBtn{
        float: left;
        margin-left:5px;
    }
    
    #listBtn{
        float: right;
    }
    
   #editor {
    min-height: 300px;
    min-width: 1194px;
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
 
    });//end jq
</script>

   <script>
        $(function (){
            console.clear();
            console.debug("jq start")
  

            $('#listBtn').on('click',function(){
                location.href= location.href="/news/listPerPage?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
             });
            
    
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
     
            });//onclick
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
                	<div class="wraper">
                        <form action="/news/modify" method="POST" id="form">
                       	 
				       		<input type="hidden" id="bno" name="bno" value="${board.bno}">
	                        <input type="hidden" id="reproot" name="reproot"  value="${board.reproot}">
	                       	<input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
	         				<input type="hidden" id="bname" name="bname" value="보도자료">
	                        <input type="hidden" id="fid" name="fid">
		                    <input type="hidden" id="notice_tf" name="notice_tf" value="F">
		                	<input type="hidden" id="public_tf" name="public_tf"  value="F">
							<input type="hidden" id="reply_tf" name="reply_tf"  value="F">
                          
                            <div id="write_no">글번호:${board.bno}</div>
		        		<div id="write_title_wrap">
			        		<div class="write_title_area">제목</div>
			        		<div><input type="text" name="title" class="write_title" value="${board.title}"></div>
		        		</div>
		        		<div id="write_info">
							<div class="writer_area">작성자:${board.memberid}</div>
							<div class="readcnt_area">조회수:${board.readcnt}</div>
						</div>
				
				        <textarea id="editor" name="content">${board.content}</textarea>
						
				        
						<div id="btn_wrap">
							    <c:if test="${__LOGIN__.membertype =='관리자'}">
                                    <button id="modifyBtn" class="btn" type="submit">수정</button>
                                    <button id="removeBtn" class="btn" type="button">삭제</button>
                                </c:if>
					        <button id="listBtn" class="btn" type="button">목록</button>
				        </div>
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