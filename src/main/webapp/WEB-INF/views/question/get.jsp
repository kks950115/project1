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
    <!-- Summer note -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/summernote-lite.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
     
</head>

<style>
    #wrapper{
        width: 1200px;
        
        display: flex;
        flex-direction: column;

        
    }
    
    #board{
        width: 1100px;
        margin-top: 50px;
        margin-bottom: 20px;

        display: flex;
        flex-direction: column;

        font-weight: bold;
    }

    #title{
        width: 100%;
        height: 40px;
        font-size: 20px;

        display: flex;
        justify-content: space-between;

        border-top: 5px solid #005bbb;

    }

    #title span{
        margin: 0 5px;
    }

    #content_info{
        width: 100%;
        height: 40px;
        font-size: 15px;

        background-color: #eee;

        margin-bottom: 10px;

        display: flex;
        justify-content: space-between;
    }

    #content_info span{
        margin: 0 5px;
    }

    #board_content{
        width: 99%;
        min-height: 300px;
        font-size: 15px;

        border-top: 1px solid #999;
        border-bottom: 1px solid #999;

        padding: 30px 0 30px 10px;
    }

    button{
        border: none;
        width: 100px;
        height: 40px;
        line-height: 40px;
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;
        
    }

    #buttons{
        width: 1100px;

        display: flex;
        justify-content:  space-between;
    
    }

    .hideBtn{
        
        width: 100px;
        height: 40px;
    }

    #buttons :nth-child(4){
        
        padding: 0;
    }

    #reply{
        margin-top: 20px;
        width: 1097px;

        display: flex;
        justify-content: space-between;
    }

    #reply textarea{
        width: 700px;
    }

    #memberid{
        width: 100px;
        height: 40px;
    }

    #replylist{
        width: 1100px;
        background-color: #f5f3f3;
        margin-top: 10px;
        margin-bottom: 20px;
    }

    #replylist tr{
        border-bottom: 1px solid #eee;
    }

    #replylist tr td:nth-child(2){
        width: 700px;
    }

    #replylist tr td:nth-child(3){
        width: 100px;
    }

    #replyRemoveBtn {
        width: 50px;
        height: 22px;
        background-color: whitesmoke;
        color: black;
        font-size: 12px;
        
        line-height: 12px;
    }

    #replyRegister{
        border-top: 2px solid #005bbb;
        width: 1100px;
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
        
        var result = '${__RESULT__}';

        if(result.length>0){
            console.log("event trigered");
            alert(result);
        }//if

        $('#removeBtn').on('click', function () {
            let form =$("form");

            form.attr('action','/question/remove?bno=${__LIST__.bno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}');
            form.attr('method','POST');

            form.submit();
        });//onclick remove
        
        $('#listBtn').on('click',function () {
            location.href="/question/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}" 
        });//onclick

        $('#modifyBtn').on('click', function () {
            location.href="/question/modify?bno=${__LIST__.bno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
        });//onclick.

        $('#retrieveBtn').on('click',function () {
            location.href="/question/retrieve?bno=${__LIST__.bno}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}"
        })//onclick ret

        $('#summernote').summernote();

    })//end jq
</script>
<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">고객센터</h2>
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
                    <div class="map">home > 고객센터 > 질문게시판 </div>
                    <h2 class="subName">질문게시판</h2>
                </div>
                <div class="contentIn">
                	
                    <div id="wrapper">


                        <form action="/question/list">
                            <input type="hidden" name="currPage">
                            <input type="hidden" name="amount">
                            <input type="hidden" name="pagesPerPage">
                            
                            <div id="board">
        
                                <c:choose>
                                    <c:when test="${__LIST__.public_tf == 'T' || (__LIST__.memberid == __LOGIN__.memberid || __LOGIN__.membertype eq '관리자')}">
                                        
                                        <div id="title">
                                            <span>
                                                <c:if test="${__LIST__.public_tf == 'F'}">[비공개]</c:if> ${__LIST__.title} 
                                            </span>
                                            
                                            <span>
                                                작성자 :  ${__LIST__.memberid}
                                            </span>
                                        </div>
                                        <div id="content_info">
                                            <span>
                                                등록일 : <fmt:formatDate value="${__LIST__.insert_ts}" pattern="yyyy/MM/dd"/>
                                                <c:if test="${not empty __LIST__.update_ts}">수정일 : </c:if><fmt:formatDate value="${__LIST__.update_ts}" pattern="yyyy/MM/dd"/>
                                            </span>
                                            <span>
                                                조회수 : ${__LIST__.readcnt+1}
                                            </span>
                                        </div>
                                        <div id="board_content">
                                            ${__LIST__.content}
                                            
                                            <c:if test="${__FILE__.fid>0}">
                                                
                                                <img src="/fileupload/${__FILE__.fpath}${__FILE__.frename}" alt="" width="700" >
             
                                            </c:if>
                                        </div>
        
                                    </c:when>
                                   
                                    <c:when test="${__LIST__.public_tf == 'F' && (__LIST__.memberid != __LOGIN__.memberid )}">
                                        <div id="title">
                                            <span>
                                                <c:if test="${__LIST__.public_tf == 'F'}">[비공개]</c:if> ${__LIST__.title}
                                            </span>
                                            
                                            <span>
                                                작성자 :  ${__LIST__.memberid}
                                            </span>
                                        </div>
                                        <div id="content_info">
                                            <span>
                                                등록일 : <fmt:formatDate value="${__LIST__.insert_ts}" pattern="yyyy/MM/dd"/>
                                                <c:if test="${not empty __LIST__.update_ts}">수정일 : </c:if><fmt:formatDate value="${__LIST__.update_ts}" pattern="yyyy/MM/dd"/>
                                            </span>
                                            <span>
                                                조회수 : ${__LIST__.readcnt+1}
                                            </span>
                                        </div>
                                        <div id="board_content">
                                            비공개 글 입니다. 
                                        </div>
                                    </c:when>
                                </c:choose>
                           
                            </div>
                            <div id="buttons">
                                <div>
                                    <c:choose>
                                        <c:when test="${__LOGIN__.memberid == __LIST__.memberid || __LOGIN__.membertype eq '관리자'}">
                                            <button type="button" id="modifyBtn">수정</button>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="hideBtn">&nbsp;</div>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <c:choose>
                                        <c:when test="${__LOGIN__.memberid == __LIST__.memberid || __LOGIN__.membertype eq '관리자'}">
                                            <button type="button" id="removeBtn">삭제</button>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="hideBtn">&nbsp;</div>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${__LOGIN__.membertype eq '관리자'}">
                                            <button type="button" id="retrieveBtn">답글</button>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="hideBtn">&nbsp;</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>


                                <button type="button" id="listBtn">목록</button>
                            </div>
                            
                        </form>
                 
                        <c:if test="${__LIST__.public_tf != 'F' && not empty __LOGIN__.memberid}" >
                            <p>댓글</p>
                            <form action="/question/replyRegister" method="POST" id="replyRegister">
                                <div id="reply">
                                    <input type="hidden" name="bno" value="${__LIST__.bno}">
                                    <textarea name="recontent" id="recontent" cols="50" rows="3" placeholder="댓글 내용을 입력하세요">
                                    </textarea>
                                    <input type="text" name="memberid" size="10" value="${__LOGIN__.memberid}" readonly id="memberid">
                                    <button type="submit" id="replyRegisterBtn">등록</button>
                                </div>
                            </form>
        
                              <!-- 이미 작성된 댓글  -->
                            <form action="/question/replyRemove" method="POST">
                                <table id="replylist">
                                  
                                        <c:forEach items="${__REPLY__}" var="re">
                                            <tr>
                                                <td>
                                                    <input type="hidden" name="bno" value="${re.bno}">
                                                    <input type="hidden" name="reno" value="${re.reno}">
                                                </td>
                                                <td colspan="2">${re.recontent}</td>
                                                <td>${re.memberid}</td>
                                                <td>
                                                    <fmt:formatDate value="${re.redate}" pattern="yyyy/MM/dd"/>
                                                </td>

                                                <td>
                                                    <c:if test="${__LOGIN__.memberid eq re.memberid}">
                                                        <button type="submit" id="replyRemoveBtn">삭제</button>
                                                    </c:if>
                                                </td>
                                                
                                            </tr>
                                        </c:forEach>
                                 
                                </table>
                            </form>
                        </c:if>
                   
                </div>
                
                </div>
            </div>
        </div>

   	<span id="top_btn">top</span>  
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>