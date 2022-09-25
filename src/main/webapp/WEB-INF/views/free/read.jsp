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
	
    <script>
        $(function(){
            console.clear();
            console.debug('jq started.');

            $('#listBtn').on('click', function(){
                console.log('listBtn button clicked...');

                location.href="/free/board";
                
            });//onclick
            
            $('#modifyBtn').on('click', function(){
                console.log('listBtn button clicked...');
            
            	location.href="modify?bno=${__READ__.bno}";
            });//onclick
            
            $('#regBtn').on('click',function(){
                console.log('listBtn button clicked...');
                
                location.href = "/free/write?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
            });
            
            $('#removeBtn').on('click', function(){
                console.log('removeBtn button clicked...');
                var result = confirm('게시글을 삭제 하시겠습니까?');
                
                if(result) {
    				var obj = $('#form');
    				obj.attr('action','/free/remove');
    				obj.attr('method','POST');
    				obj.submit();
                }else{
                	return false;
                }
                

            });//onclick
            
    		if($('#member_id').val() == '') {
    			$('#recontent_text').attr('placeholder', '로그인 후 이용해주세요.');
    			$('#recontent_text').attr('readonly', true);
    			
    			$('#recontent_text').on('click', function(e){
    				alert('로그인이 필요합니다.');
    				location.href = "/login/login";
    			});//onclick
    			
    		};//if
            
            $('#replyWriteBtn').on('click', function(){
            	
            	var result = confirm('댓글을 등록 하시겠습니까?');
            	
                if(result) {
    				var obj = $('#replyForm');
    				obj.attr('action','/free/replyWrite');
    				obj.attr('method','POST');
    				obj.submit();
                }else{
                	return false;
                }
            	
            });//onclick
            
            $('.re_modifyBtn').on("click",function(){
				var obj = $('.re_modifyBtn');
				obj.attr('action','/free/replyModify');
				obj.attr('method','POST');
				obj.submit();
            	
            	
            });
            
            $('.re_removeBtn').on("click",function(){
            	var result = confirm('댓글을 삭제 하시겠습니까?');
            	
                if(result) {
    				var obj = $('.re_removeBtn');
    				obj.attr('action','/free/replyRemove');
    				obj.attr('method','POST');
    				obj.submit();
                }else{
                	alert('삭제가 취소 되었습니다.');
                	return false;
                }
            	
            });
            


        }); //jq
        
        function modify_btn(re_no, re_content, bno) {
        	
        	var html = '';
        	
        	html += '<div id="reply_box">';
        	html += '<textarea id="recontent" name="recontent" style="resize: none;">';
        	html += re_content;
        	html += '</textarea>';
        	html += '<input type="button" id="reply_submitBtn" onclick="update_reply('+re_no+', '+bno+')" value="댓글수정">';
        	html += '<div class="clear"></div>';
        	html += '</div>';
        	
        	$('#reply_content'+re_no).html(html);
        	
        	
        	$('#reply_modify_btn'+re_no).text('취소');
        	$('#reply_modify_btn'+re_no).removeAttr('onclick');
        	$('#reply_modify_btn'+re_no).attr('onclick', 'rollback('+re_no+', \''+re_content+'\', '+bno+');');
        	
        }//modify_btn
        
        function update_reply(re_no, bno) {
    		$.ajax({
    			url: '/notice/modifyReply',
    			type: 'post',
    			data: {'reno':re_no, 'recontent':$('#recontent').val(), 'bno':bno},
    			success: function() {
    				location.reload();
    			}//success
    		})//ajax
        }//update_reply
        
        function rollback(re_no, re_content, bno) {
        	var html = '';
        	
        	html += '<div style="white-space:pre;">';
        	html += re_content;
        	html += '</div>';
        	
        	$('#reply_content'+re_no).html(html);
        	
        	$('#reply_modify_btn'+re_no).text('수정');
        	$('#reply_modify_btn'+re_no).removeAttr('onclick');
        	$('#reply_modify_btn'+re_no).attr('onclick', 'modify_btn('+re_no+', \''+re_content+'\', '+bno+');');
        }//rollback
    </script>

    <style>
    
    	#btn_wrap{
    		width:100%;
    		height:50px;
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
		
		#reply_wrap{
			width:1200px;
			min-height:150px;
		}
		
		#text_wrap{
			width:1200px;
		}
		
		#text_wrap #recontent_text{    
			width: 1060px;
		    height: 90px;
		    float: left;
		    padding:10px;
		}
		
		#replyWriteBtn{
		    width: 108px;
		    height: 113px;
		    float: left;
		    border: 0;
		    text-align: center;
		    background: #005bbb;
		    color: #fff;
		    font-size: 15px;
		    margin-left: 10px;
		    cursor: pointer;
		}
		
		#reply_box{
			width:100%;
			margin-top:10px;
		}
		
		#reply_box #reply_info{
			height:50px;
			line-height:50px;
			background:#eee;
		}
		
		#reply_box #reply_info #re_memberid{
			width:20%;
			float:left;
			color:#005bbb;
			font-weight:bold;
			text-indent:10px;

		}
		
		#reply_box #reply_info #re_btn_wrap{
			width:60%;
			height:50px;
			float:left;
			
		}
		
		.re_modifyBtn{
			width:30px;
			height:30px;
			color:red;
		}
		
		.re_removeBtn{
			width:30px;
			height:30px;
			color:red;
		}
		
		#reply_box #reply_info #re_date{
			width:20%;
			float:left;
			font-weight:bold;
			text-align:center;
		}
		
		#re_content{
			width:90%;
			background:#fff;
			padding:10px;
		    white-space: pre;
		    font-size:16px;
		}
		
		
    </style>
</head>
<body>

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
                <li><a class="chk" href="/news/listPerPage">보도자료</a></li>
                <li><a class="chk" href="/question/list">질문게시판</a></li>
                <li><a class="chk" href="/often/question">자주묻는질문</a></li>
                <li><a class="chk" href="/anony/list">고객의소리</a></li>
                <li><a class="chk" href="/free/board">자유게시판</a></li>
                <li><a class="chk" href="/event/listPerPage">이벤트</a></li>
            </ul>

        </div> <!-- aside -->
        <div id="content">
            <div class="title">
                <div class="map">home > 커뮤니티 > 자유게시판 </div>
                <h2 class="subName">자유게시판</h2>
            </div> <!-- title -->
            <div class="contentIn">
            	<form id="form">
            		<input type="hidden" name="bno" value="${__READ__.bno}" />
	           		<div class="read_no">
						   글번호: ${__READ__.bno}
					</div><!-- read_no -->
	           		
	            	<div id="read_Wrap">
	            		<div id="title_wrap">
						    <div class="title_area">
								${__READ__.title}
							</div><!--title_area-->

						    <div class="writer_area">
								작성자:${__READ__.memberid}
							</div><!--writer_area-->
					    </div><!-- title_wrap -->
					    
					    <div id="date_wrap">
							<div class="reg_date">
								작성일:<fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${__READ__.insert_ts}"/>
							</div><!-- reg_date -->

							<div class="readcnt">
								조회수:${__READ__.readcnt}
							</div><!-- readcnt -->
					    </div><!-- date_wrap -->
					    
					    <div id="content_wrap">${__READ__.content}</div>
					</div> <!-- read_Wrap -->
				</form><!-- form -->

				<div id="reply_wrap">
					<c:forEach items="${__replyList__}" var="replyList">
					<div id="reply_box">
						<div id="reply_info">
							<div id="re_memberid">작성자:${replyList.memberid}</div>
							
							<div id="re_btn_wrap">
								<form id="re_button_form"action="/free/replyRemove" method="post">
									<input type="hidden" name="reno" value="${replyList.reno}" />
									<input type="hidden" name="bno" value="${replyList.bno}" />
									
									<c:if test="${replyList.memberid eq __LOGIN__.memberid}">
									<button class="re_modifyBtn" type="button">수정</button>
									
									<button class="re_removeBtn" type="submit">삭제</button>
									</c:if>
								</form>
							</div>					
							<div id="re_date">작성일:<fmt:formatDate value="${replyList.redate}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
						</div>
						<div id="re_content">${replyList.recontent}</div>
						
					</div>
					</c:forEach>
					
					<c:set var="reply_login" value="${__LOGIN__.memberid}" />
					<form id="replyForm" action="/free/replyWrite" method="post">

						<div id="text_wrap">
							<input type="hidden" value="${__READ__.bno}" name="bno" />
							<input id="member_id"type="hidden" value="${reply_login}" name="memberid" />
							<textarea id="recontent_text" name="recontent"></textarea>
							<button id="replyWriteBtn" type="submit">댓글작성</button>
						</div><!-- text_wrap  -->
						
					</form><!--replyForm-->
				</div><!--reply_wrap-->
					    
			    <div id="btn_wrap">
			    	<c:set var="login" value="${sessionScope.__LOGIN__}" />
			    	<c:choose>
			    		<c:when test="${__READ__.memberid eq login.memberid}">				    		
					    	<button id="modifyBtn" class="btn" type="button">수정</button>	
				       		<button id="removeBtn" class="btn" type="button">삭제</button>
			    		</c:when>
			    		<c:otherwise>&nbsp;</c:otherwise>
			    	</c:choose>

			        <c:if test="${not empty __LOGIN__.memberid}">
				    <button id="regBtn" class="btn" type="button">글쓰기</button>
				    </c:if>		    
				    <button id="listBtn" class="btn" type="button">목록</button>
				</div><!-- btn_wrap-->

            </div> <!-- contentIn  -->
        </div><!-- content  -->
	</div><!-- container -->
    <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div> <!--wrap-->

</body>
</html>