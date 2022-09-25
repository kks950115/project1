<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>참가기업관리</title>

    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>

    <!-- amdin_apply.js -->
    <script src="/resources/js/admin_apply.js"></script>

</head>

<style>
	 button{
        
        width: 100px;
        height: 40px;
        line-height: 40px;
        
        
        color: white;
        border: 1px cornflowerblue solid;
        background-color: #005bbb;;

        cursor: pointer;

        margin: 10px 5px 10px 0;

    }
    table {
        width: 100%;
    }

    table, th, td {
        border: 1px solid rgb(201, 201, 201);
        border-collapse: collapse;
    }

    th {
        background-color: rgb(245, 245, 245);
        height: 50px;
        font-size: 20px;
        border-top: 3px solid #005bbb;

    }

    td {
        height: 40px;
        font-size: 15px;
        text-align: center;
    }
    td:first-child {
        color: #005bbb;
    }

    tr:hover {
        background-color: rgba(187, 187, 187, 0.1);
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
                <h2 class="asideMenu">관리페이지</h2>
                <ul id="parent">
                    <li><a class="chk" href="/mypage/adminInfo">기본정보변경</a></li>
                    <li><a class="chk" href="/admin/memberList?membertype=개인">회원관리</a></li>
                    <li><a class="chk" href="/admin/memberBoard">회원글관리</a></li>
                    <li><a class="chk" href="/admin/memberReply">회원댓글관리</a></li>
                    <li><a class="chk" href="/admin/apply">참가기업관리</a></li>
                    <li><a class="chk" href="/exhibition/list">전시일정관리</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 관리페이지 > 참가기업관리 </div>
                    <h2 class="subName">참가기업관리</h2>
                </div>
                <div class="contentIn">
                    <form id="apply">
                        <button type="button" id="agreeUpdateBtn">승인</button>
                        <button type="button" id="paymentUpadateBtn">결제확인</button>
                        <div id="list">
                            <table>
                                <thead>
                                    <tr>
                                        <th>선택</th>
                                        <th>참가번호</th>
                                        <th>참가전시회</th>
                                        <th>부스번호</th>
                                        <th>회사명</th>
                                        <th>사업자등록번호</th>
                                        <th>연락처</th>
                                        <th>이메일</th>
                                        <th>아이디</th>
                                        <th>승인여부</th>
                                        <th>결제여부</th>
                                        <th>결제번호</th>
                                    </tr>
                                </thead>
        
                                <tbody>
                                    <c:forEach items="${__APPLY__}" var ="app">
                                        <tr>
                                            <td><input type="checkbox" name="applyno" value="${app.applyno}"></td>
                                            <td>${app.applyno}</td>
                                            <td>${app.applyname}</td>
                                            <td>${app.btno}</td>
                                            <td>${app.applycompany}</td>
                                            <td>${app.cbno}</td>
                                            <td>${app.phone}</td>
                                            <td>${app.email}</td>
                                            <td>${app.memberid}</td>
                                            <td>${app.agrstate_tf}</td>
                                            <td>${app.payment_tf}</td>
                                            <td>${app.pno}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
        
                    </form>
                
                </div>
            </div>
        </div>

   
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>