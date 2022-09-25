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
    <link rel="stylesheet" href="/resources/css/apply_appform.css">    
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>

    <script src="/resources/js/apply_appform.js"></script>
	<script src="/resources/js/top.js"></script>
</head>

<style>
   
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
<script>
    $(function () {
        var result = '${__RESULT__}'

        if(result.length>0){
            alert(result);
        }//if
    });//.jq
</script>
        

<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">참가안내</h2>
                <ul id="parent">
                    <li><a class="chk" href="/apply/info">참가신청안내</a></li>
                    <li><a class="chk" href="/apply/app">참가신청</a></li>
                    <li><a class="chk" href="/apply/applystatus">참가신청확인</a></li>
                    <li><a class="chk" href="/apply/rule">참가규정</a></li>
                    <li><a class="chk" href="/apply/booth">부스안내</a></li>
                    <li><a class="chk" href="/apply/map">전시장배치도</a></li>
                    <li><a class="chk" href="/apply/companyList">참가기업목록</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 참가안내 > 참가신청 </div>
                    <h2 class="subName">참가신청</h2>
                </div>
                <div class="contentIn">
                    <div id="wrapper">
                        <p id="con_title">
                            참가신청 양식 작성
                        </p>
                        <form id="apply" action="/apply/applyform" method="POST">
                            <div id="apply_content">
                                
                                <h2>신청정보 입력</h2>
                                <div class="inner_content_wrap">
                                    <div id="member_info">
                                        <!-- 전시회 명 가져오기 select box -->
                                        <h4>전시회</h4>
                                        <select name="applyname" id="exname">
                                            <c:forEach items="${__EXHI__}" var="ex">
                                                <option value="${ex.exname}"> 
                                                    ${ex.exname} (
                                                        <fmt:formatDate value="${ex.exstart}" type="date"/> ~ 
                                                        <fmt:formatDate value="${ex.exend}" type="date"/>
                                                        )
                                                    
                                                </option>
                                            </c:forEach>
                                        </select>

                                        <!-- member info 가져오기 -->
                                        <!-- CBNO, FID, PHONE, EMAIL  가져오기-->
                                        <h4>아이디</h4>
                                        <input type="text" name="memberid" value="${__MEMBERINFO__.memberid}" readonly>
                                        <h4>사업자등록번호</h4>
                                        <input type="text" name="cbno" value="${__MEMBERINFO__.cbno}" readonly>
                                        <input type="hidden" name="fid" value="${__MEMBERINFO__.fid}">
                                        <h4>연락처</h4>
                                        <input type="tel" name="phone" value="${__MEMBERINFO__.phone}" readonly>
                                        <h4>이메일</h4>
                                        <input type="email" name="email" value="${__MEMBERINFO__.email}" readonly>
                                        
                                        <!-- APPLYCOMPANY 입력받기 -->
                                        <h4>회사명</h4>
                                        <input type="text" name="applycompany" value="">
                                    </div> <!--End member_info-->
                                </div>
                            </div> <!-- End apply_content-->

                                
                            <div id="booth_info1">
                                <h2>부스정보</h2>
                            </div>
                            <div class="inner_content_wrap">
                                <div id="boothSelect">
                                    <c:forEach items='${__BOOTH__}' var='boo'>
                                        <c:choose>
                                            <c:when test="${boo.bttype =='A' && boo.btisselected eq 'F'}">
                                                <button  type="button" class="bttypeIsA" id="boo${boo.btno}" value="${boo.btno}">A${boo.btno}</button>
                                                <input type="hidden" class="bttypeIsA" id="btprice${boo.btno}" name="btprice" value="${boo.btprice}" readonly>
                                            </c:when >
                                            <c:when test="${boo.bttype =='B' && boo.btisselected eq 'F'}">
                                                <button  type="button" class="bttypeIsB" id="boo${boo.btno}" value="${boo.btno}">B${boo.btno}</button>
                                            	<input type="hidden" class="bttypeIsB" id="btprice${boo.btno}" name="btprice" value="${boo.btprice}" readonly>
                                            </c:when>
                                            <c:otherwise>
                                                <button  type="button" class="isSelected" id="boo${boo.btno}" value="${boo.btno}">선택불가</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>  <!--End boothSelect-->
                            </div> <!--inner_content_wrap-->

                            <div id="booth_info2">
                                <input type="hidden" id="btno" name="btno" value="" readonly>
                        
                                        <h4 id="btnois">&nbsp;</h4>
                               			<h4 id="bttype">&nbsp;</h4>
                                		<h4 id="btprice">&nbsp;</h4>

                       
                            </div>  <!--booth_info2-->

                            <div id="buttons">
                                <button type="button" id="appBtn">신청</button>

                            </div>
                        </form>
                    </div>    <!-- wrapper end -->
                </div><!--content in-->
            </div>
        </div>

   	<span id="top_btn">top</span>   
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>