<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


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

<script>
    $(function() {
        $('#listBtn').on('click', function() { 
            location.href = "/notice/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"; //이걸 가장많이쓴다.
         });
         
 		$('#modifyBtn').on('click', function(){
 			location.href="/notice/modify?bno=${board.bno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
 		});
 		
    	// 삭제버튼 이벤트
        $('#removeBtn').on('click', function() {
        	var result = confirm('정말로 삭제하시겠습니까?');
        	
        	if(result) {
        		let formObj = $('form');
                formObj.attr('action', '/notice/remove/?bno='+${board.bno});
                formObj.attr('method', 'POST');
                formObj.submit();	
        	}
        	else {
        		
        	} //if-else
        }); //onClick
 		
 		$('#answerBtn').on('click', function(){
 			location.href="/notice/answer?bno=${board.bno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
 		});//onclick
 		
		if($('#memberid').val() == '') {
			$('#recontent').attr('placeholder', '로그인 후 이용해주세요.');
			$('#recontent').attr('readonly', true);
			
			$('#recontent, #reply_submitBtn').on('click', function(e){	
				alert('로그인이 필요합니다.');
				e.preventDefault();
			});//onclick
			
		};//if
		
		
        $('.reply_delete_btn').on('click', function(e) {

            var result = confirm('정말로 삭제하시겠습니까?');

            if(result) {
                /* var reply_delete = $('#reply_delete');
                
                reply_delete.attr('action', '/notice/removeReply');
                reply_delete.attr('method', 'POST');
                
                reply_delete.find('input[name=bno]').val();
                reply_delete.find('input[name=reno]').val();
                
                reply_delete.submit(); */
            } else {
            	e.preventDefault();
            }//if-else
            


        });//onClick
        
        
    });//end jq
    
    
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
    #board {
        width: 1200px;

        margin-top: 50px;
        margin-bottom: 40px;
    }
    #board * {
   		font-weight: bold;
   	}

    #title_area {
        border-bottom: 1px solid rgb(201, 201, 201);

        height: 40px;
        
        border-top: 3px solid #005bbb;
    }
    
    .title_writer {
    	font-size: 20px;
        text-indent: 20px;
        line-height: 40px;
    }
    
    #title {
    	width: 85%;
    	float: left;
    }
    
    #writer {
    	width: 15%;
    	float: left;
    }
    
    
    
    
    #date_area {
    	height: 40px;
    	background: #eee;
    
    }
    
    .date_readCnt {
    	font-size: 15px;
        text-indent: 20px;
        line-height: 40px;
    }
    
    #date {
    	width: 89%;
    	float: left;
    }
    
    #readCnt {
    	width: 11%;
    	float: left;
    }


	#top_space {
		height: 10px;
	}
	
	#contents {
		min-height: 300px;
		border-top: 1px solid #eee;
		border-bottom: 1px solid #eee;
		padding: 30px 0 30px 10px;
	}

	#bottom_space {
		height: 20px;
	}



	.btn {
        width: 100px;
        height: 40px;

        border: 0;
        
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;
        
        cursor: pointer;
	}

	#removeBtn {
		margin-left: 5px;
	}
	#answerBtn {
		margin-left: 5px;
	}

	#listBtn {
		float: right;
	}
	
	

    a, a:link, a:visited {
        text-decoration: none;
        color: black;
        cursor: pointer;
    }
    
    
    
    .clear {
    	clear: both;
    }


    #reply_area {
        width: 1200px;
    }
    
    #reply_list_area {
    	border-top: 1px solid #ccc;
    	margin-bottom: 20px;
    }
    
    #reply_top {
    	margin-top: 10px;
    }
    
    
    #reply_memberid {
    	width: 80%;
        float: left;
    }
    #reply_date {
        float: left;
    }
    #reply_delete {
    	margin-left: 20px;
        float: left;
    }

    #reply_date_delete {
        float: left;
    	width: 20%;
    }

    .reply_content {
    	margin-top: 10px;
        background: #eee;
        padding: 10px;
    }

	#reply_box {
		width: 1200px;
		background: #eee;
		padding: 20px;
	}
	
	#recontent { /* textarea */
		width: 1040px;
		height: 90px;
		float: left;
	}
	
	#reply_submitBtn {
        width: 100px;
        height: 96px;
		float:left;
        border: 0;
        
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;
        margin-left:10px;
        
		cursor: pointer;
	}
	
	.reply_delete_btn {
		color: red;
		background-color: transparent;
		border: 0;
		cursor: pointer;
	}
	
	.reply_modify_btn {
		color: red;
		background-color: transparent;
		border: 0;
		cursor: pointer;
		margin-right: 5px;
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
                    <div class="map">home > 커뮤니티 > 공지사항 </div>
                    <h2 class="subName">공지사항</h2>
                </div>
                <div class="contentIn">
                	
                    <div id="board">

                        <div id="tables">

							<div id="title_area">
	                            <div class="title_writer" id="title">${board.title}</div><div class="title_writer" id="writer">작성자 : ${board.memberid}</div>
	                            <div class="clear"></div>
                           	</div>
                           	
                            <div id="date_area">
                            	<div class="date_readCnt" id="date">작성일 : <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${board.insert_ts}"/></div><div class="date_readCnt" id="readCnt">조회수 : ${board.readcnt}</div>
                            	<div class="clear"></div>
                            </div>
                            
                            <div id="top_space"></div>
                            
                            
                            
                            <!-- 내용 영역 -->
                            <div id="contents" >
                            	<%-- <% pageContext.setAttribute("newLine", "\n"); %>
                            	${fn:replace(board.content, newLine, '<br>')} --%>
                            	<c:set var="fid" value="${board.fid}" />
							    <c:choose>
							        <c:when test="${empty fid}">
							        	<div style="white-space: pre;">${board.content}</div>
							        </c:when>
							        <c:otherwise>
							            <img src="/notice/load_img?fid=${board.fid}" width="500px" height="auto" alt="게시글 이미지" id="board_img">
							            <br><br>
							            <div style="white-space: pre;">${board.content}</div>
							        </c:otherwise>
							    </c:choose>
                            	
                            </div>
                            
                            
                            <div id="bottom_space"></div>
                            
                            
                            <div id="reply_area">
	                       	    <c:forEach items="${reply}" var="reply">
	                       	    	<input type="hidden" id="reno" value="${reply.reno}" />
	                       	    
							        <div id="reply_list_area">
							        
							        	<div id="reply_top">
							        		<div id="reply_memberid">작성자 : ${reply.memberid}</div>
							        		
							        		<div id="reply_date_delete">
								        		<div id="reply_date">작성일 : <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${reply.redate}"/></div>
									            <form id="reply_delete" action="/notice/removeReply" method="POST">
									            	<input type="hidden" name="bno" value="${reply.bno}">
									            	<input type="hidden" name="reno" value="${reply.reno}">
									            	
												    <c:set var="insert" value="${sessionScope.__LOGIN__}" />
												    <%-- <c:choose>
												        <c:when test="${insert.memberid eq reply.memberid}">
												        	<button class="reply_delete_btn" type="submit">삭제</button>
												        </c:when>
												        <c:otherwise>
												            &nbsp;
												        </c:otherwise>
												    </c:choose> --%>
												    <c:if test="${insert.memberid eq reply.memberid || insert.membertype == '관리자'}">
												    	<button class="reply_modify_btn" id="reply_modify_btn${reply.reno}" type="button" onclick="modify_btn(${reply.reno}, '${reply.recontent}', ${reply.bno});">수정</button>
												    	<button class="reply_delete_btn" type="submit">삭제</button>
												    </c:if>
									            	
								            	</form>
							            	</div>
							            	<div class="clear"></div>
							        	</div>
							        	
							        	
							        	<div class="reply_content" id="reply_content${reply.reno}">
							        		<div style="white-space:pre;">${reply.recontent}</div>
							        	</div>
							            
						            </div>
						            
							    </c:forEach>
							    
							    
								<div id="reply_box">
								    <form action="/notice/writeReply" method="POST">
								    	<input type="hidden" name="bno" value="${board.bno}">
								    	<input type="hidden" id="memberid" name="memberid" value="${__LOGIN__.memberid}">
								    	
							    		<!-- <textarea id="recontent" name="recontent" rows="5" cols="147" style="resize: none;"></textarea> -->
								    	<textarea id="recontent" name="recontent" style="resize: none;"></textarea>
								    	
								    	<input type="submit" id="reply_submitBtn" value="댓글작성">
								    	<div class="clear"></div>
								    </form>
							    </div>
							    
							    
                            </div>
                            
                            
                            <div id="bottom_space"></div>
                            <div id="btn_area">
							    <c:set var="insert" value="${sessionScope.__LOGIN__}" />
							    <c:choose>
							        <c:when test="${insert.membertype eq '관리자'}">
							        	<button type="button" class="btn" id="modifyBtn">수정</button>
							        	<button type="button" class="btn" id="removeBtn">삭제</button>
							            <button type="button" class="btn" id="answerBtn">답글</button>
							        </c:when>
							        <c:otherwise>
							            &nbsp;
							        </c:otherwise>
							    </c:choose>
							    
							    <button type="button" class="btn" id="listBtn">목록</button>
							    <div class="clear"></div>
                            
                            </div>
                            
                        
                        </div>
                
                        
                    </div>
                
                </div>
            </div>
        </div>

    <span id="top_btn">top</span>  
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>