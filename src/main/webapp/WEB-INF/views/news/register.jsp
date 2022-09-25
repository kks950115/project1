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
    <script src="//cdn.ckeditor.com/4.16.2/full/ckeditor.js"></script>
    <script src="/resources/js/top.js"></script>
    

</head>

<style>
	#wrap {
    margin: 0;
    width: 100%
    align-items: center;
    
}
body,input,textarea,select,button,table{
	font-family:'noto-sans';
	font-size:12px; 
	color:#333;
	}
.wraper {
    width: 1200px;
    margin-top: 50px;
    border-top: 2px solid #005bbb;
}

label {
    width: 54px;
    display: inline-block;
    width: 115px;
    text-align: center;
    font-size: 20px;
    height: 30px;
    height: min-content;
}

input#title {
    height: 30px;
    font-size: 15px;
    width: 1074px;

    font-weight: 500;
}
	
textarea#content {
   position: relative;
    left: -21px;
    top: 4px;
    font-size: 15px;
    width: -6px;
    min-height: 300px;
}
}

#container #content {
    width: 1073px;
    margin: 0 0 10px 20px;
    float: left;
}
#summitBtn,#listBtn {
    height: 40px;
    width: 100px;
    line-height: 40px;
    text-align: center;
    background-color: #005bbb;
    color: #fff;
    font-size: 15px;
    left: 990px;
    top: 4px;
    position:relative;
}

button#summitBtn {
    left: 117px;
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
        

        $('#listBtn').on('click',function () {
            location.href="/news/listPerPage?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
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
                	<div class="wraper">
                        <form action="/news/register" method="POST">
               				 <table>
		                        <input type="hidden" id="bno" name="bno" value="${board.bno}">
		                        <input type="hidden" id="reproot" name="reproot"  value="${board.reproot}">
		                       	<input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
		         				<input type="hidden" id="bname" name="bname" value="보도자료">
		                        <input type="hidden" id="fid" name="fid">
			                    <input type="hidden" id="notice_tf" name="notice_tf" value="F">
			                	<input type="hidden" id="public_tf" name="public_tf"  value="F">
								<input type="hidden" id="reply_tf" name="reply_tf"  value="F">
								
								<tr>	
			                        <td><label for="title">제목</label></td>
			                        <td><input type="text" id="title" name="title" placeholder="제목을 입력하세요." required></td>
		                   		</tr>
		            
			                    <tr>
			                        <td><label for="content">내용</label></td> 
			                   		 <td><textarea name="content" id="content" cols="48" rows="10" placeholder="내용을 입력하세요" required></textarea></td>
			                    </tr>
  
		                        <tr>
		                            <td colspan="2">
		                                    <button type="submit" id="summitBtn">등록</button> 
		                                    <button type="button" id="listBtn">목록</button>
		                                    
		                            </td>
		                        </tr>
                			</table>
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