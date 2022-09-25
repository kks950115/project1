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



    <script>
    
        $(function() {
            console.clear();
            console.debug('jq started...');

            $('#listBtn').click(function() {
                console.log('onclick for #listBtn clicked...');

                location.href = '/free/board';
            });//onclick for #listBtn
            
            

        });//jq
        
	
        
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
	
	<style>
		#write_title_wrap{
			width:100%;
			height:80px;
			background:#eee;
			border-top:3px solid #005bbb;
			margin:50px 0 10px 0;
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
		
		.btn{
			width: 100px;
			height: 40px;
			line-height: 40px;
			text-align:center;
			background:#005bbb;
			color:#fff;
			font-size:15px;
			border:0;
			cursor:pointer;
			margin-top:10px;
		}
		
		#submitBtn{
			float:left;
		}
		
		#listBtn{
			float:right;
		}
	</style>
<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">커뮤니티</h2>
                <ul id="parent">
                    <li><a class="chk" href="/notice/list">공지사항</a></li>
                    <li><a class="chk" href="/news/listPerPage">보도자료</a></li>
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
                    <form action="/free/write" method="post">
                       
                            <input type='hidden' name="bname"  value="자유게시판"/>
                            <input type='hidden' name="memberid" value="${__LOGIN__.memberid}"/>
                            
		        		<div id="write_title_wrap">
			        		<div class="write_title_area" placeholder="제목을 입력하세요">제목</div>
			        		<div><input type="text" name="title" class="write_title" value="${__READ__.title}"></div>
		        		</div>
                            
							<textarea id="editor" name="content" placeholder="내용을 입력하세요">${__READ__.content}</textarea>
						<table>
                            <tr>
                            	<div id="btn_wrap">
	                                <button type="submit" id="submitBtn" class="btn">등록</button>
	                                <button type="button" id="listBtn" class="btn">목록</button>
                                </div>
                            </tr>
                        </table>
                    </form>
		            <script>
			        CKEDITOR.replace( 'editor', {
			        	enterMode: CKEDITOR.ENTER_BR, //줄바꿈시에 P태그로 입력되는걸 -> </br> 태그로 치환
			        	width: '100%',
			        	height: '350'
			        });
			    	</script>
                </div>
    
           	</div>
        </div>
        
        <span id="top_btn">top</span>
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div><!-- wrap -->

</body>
</html>

    
</body>
</html>