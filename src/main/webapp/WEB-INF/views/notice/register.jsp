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
        // 취소(뒤로가기) 이벤트
        $('#backBtn').on('click', function(){
            window.history.back();
        })//onClick
        
    	$('#submit').on('click', function(e){
    		var content = CKEDITOR.instances['editor'].getData();
    		if(($('#title').val() == "" || $('#title').val().length == 0) && (content == "" || content.length == 0)) {
    			e.preventDefault();
    			alert('제목/내용을 입력해주세요.');
    			$('#title').focus();
    		}
    		else if($('#title').val() == "" || $('#title').val().length == 0) {
    			e.preventDefault();
    			alert('제목을 입력해주세요.');
    			$('#title').focus();
    		}
    		else if(content == "" || content.length == 0) {
    			e.preventDefault();
            	alert('내용을 입력해주세요.');
            	$('#editor').focus();
    		}
    	});
    	
    	
        $('#checkbox').on('click', function(){
            if($('#checkbox').is(':checked')){
                $('#checkbox_hidden').attr('value', 'T');
            } else {
                $('#checkbox_hidden').attr('value', 'F');
            }   
        })
    

       $('#file').change(function(){
            if($('#file').val() != "") {
                //============파일 확장자 검사==================//
                var ext = $('#file').val().split('.').pop().toLowerCase(); //파일 확장자만 추출해서 ext 변수에 저장 
                if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1 ) {
                    alert('gif / png / jpg / jpeg 파일만 업로드 가능합니다.');
                    $('#file').val('');
                    return false;
                }

                //=========================================//
                
                //============파일 용량 검사==================//
                var maxSize = 2 * 1024 * 1024; // 2 MB
                var fileSize = $('#file')[0].files[0].size;
                if(fileSize > maxSize) {
                    alert('첨부파일 업로드는 2MB 이내로 가능합니다.');
                    $('#file').val("");
                    return false;
                }
            }
       });
       

    });
</script>  

<style>

.contentIn form {
	margin-top: 50px;
}

table {
	width: 100%;
    border-collapse: collapse;
}

th {
	font-size: 15px;
}

.table_padding {
    padding: 20px;
}
thead {
	border-top: 3px solid #005bbb;
}

thead tr{ /* 제목 Input */
    background-color: #eee;
    border-top: 1px solid #ccc;
}
#title {
	width: 98%;
	height: 30px;
	font-size: 20px;
    border: 1px solid #ccc;
   	padding-left: 10px;
}

tbody tr {
    border-top: 1px solid #ccc;
}

tbody tr:nth-of-type(2n) {
    background-color: #eee;
}
tbody tr:last-child {
    border-bottom: 1px solid #ccc;
}


#backBtn {
	float: right;
}

#checkbox {
    width: 20px;
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

tfoot tr td {
	padding: 20px 0 20px 20px;
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
                	
                    <form action="/notice/register" method="POST" enctype="multipart/form-data">
				        <input type="hidden" name="currPage" value="${cri.currPage}">
				        <input type="hidden" name="amount" value="${cri.amount}">
				        <input type="hidden" name="pagesPerPage" value="${cri.pagesPerPage}">
                        
                        <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                        <input type="hidden" name="bname" value="공지사항">
                        <input type="hidden" name="public_tf" value="T">
                        <input type="hidden" name="reply_tf" value="F">

                        <table>
                            <thead>
                                <tr>
	                                <th>제목</th>
	                                <td class="table_padding"><input type="text" name="title" id="title"></td>
	                            </tr>
                            </thead>

                        	<tbody>
	                            <tr>
	                                <th>내용</th>
	                                <td class="table_padding"><textarea name="content" id="editor" ></textarea></td>
	
	                            </tr>
	                
	                            <tr>
	                                <th>파일첨부</th>
	                                <td class="table_padding"><input type="file" name="file" multiple="multiple" id="file"></td>
	                            </tr>
	                
	                            <tr>
	                                <th>공지등록</th>
	                                <td class="table_padding"><input type="checkbox" id="checkbox"></td>
	                                <td><input type="hidden" id="checkbox_hidden" name="notice_tf" value="F"></td>
	                            </tr>
                            </tbody>
                            
                            <tfoot>
	                            <tr>
	                            	<th><input type="submit" id="submit" class="btn" value="등록"></th>
	                                <td>
	                                	<button class="btn" type="button" id="backBtn">목록</button>	
	                                </td>
	                            </tr>
                            </tfoot>
                
                        </table>

                    </form>
                </div>
            </div>
        </div>

    <script>
        CKEDITOR.replace( 'editor', {
        	enterMode: CKEDITOR.ENTER_BR, //줄바꿈시에 P태그로 입력되는걸 -> </br> 태그로 치환
        	width: '98%',
        	height: '350'
        });
    </script>
    <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>