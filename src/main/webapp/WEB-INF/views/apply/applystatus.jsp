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
    
    <link rel="stylesheet" href="/resources/css/apply_applystatus.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
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
        var result = '${__RESULT__}';

        if(result.length>0){
            alert(result);
            
        }//if

        var redirect = '${__RESULT_REDIRECT__}';
        var membertype = "${__LOGIN__.membertype == '개인'}";
        
        if(membertype =='true'){
            alert('기업회원만 이용가능한 메뉴입니다.');
            history.back();
        }else if (redirect.length>0 ) {
            alert(redirect);
            history.back();
        }//if-else if

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
                    <div class="map">home > 참가안내 > 참가신청확인 </div>
                    <h2 class="subName">참가신청확인</h2>
                </div>
                <div class="contentIn">
                    <div id="wrapper">
            
                        <c:choose>
                            
                            <%--1. 참가 신청 관리자 승인 전 --%>
                            <c:when test="${__APPLY__[0].agrstate_tf eq 'F'}">
                                <div id="inner_con">
                                    <div id="apply_status">
                                        <div id="status">
                                            <span class="st" id="now_status"><h4>승인 대기</h4></span>
                                            <span><h4><img src="/resources/img/applystatus_arrow.png" alt="" width="70" height="70"></h4></span>
                                            <span class="st"><h4>결제 대기</h4></span>
                                            <span><h4><img src="/resources/img/applystatus_arrow.png" alt="" width="70" height="70"></h4></span>
                                            <span class="st"><h4>결제 완료</h4></span>
                                        </div>
                                        <div id="status2">
                                            <span><strong>참가신청 양식</strong>을 작성 완료하였습니다.</span>
                                            <span></span>
                                            <span>승인 완료 후<strong>결제 대기</strong> 상태입니다.</span>
                                            <span></span>
                                            <span><strong>결제 완료</strong>되었습니다.</span>
                                        </div>
                                    </div>


                                    <h3>${__APPLY__[0].applycompany} 님은 현재 관리자 승인 대기중입니다.</h3>

                                    <div id="info">
                                       <h4>${__APPLY__[0].applycompany} 님의 전시회 신청 정보입니다.</h4> 

                                       <div id="information">
                                           <h4>전시회명</h4>
                                           <h5>${__APPLY__[0].applyname}</h5>
                                           <h4>연락처</h4>
                                           <h5>${__APPLY__[0].phone}</h5>
                                           <h4>사업자등록번호</h4>
                                           <h5>${__APPLY__[0].cbno}</h5>
                                       </div>
                                       
                                        
                                    </div>
                                </div>    
                            </c:when >

                            <%--3. 결제 완료시! 결제 테이블에 있는 DB 정보 보여줌. --%>
                            
                            <c:when test="${__APPLY__[0].payment_tf eq 'T'}">
                                <div id="inner_con">

                                    <div id="apply_status">
                                        <div id="status">
                                            <span class="st"><h4>승인 대기</h4></span>
                                            <span><h4><img src="/resources/img/applystatus_arrow.png" alt="" width="70" height="70"></h4></span>
                                            <span class="st"><h4>결제 대기</h4></span>
                                            <span><h4><img src="/resources/img/applystatus_arrow.png" alt="" width="70" height="70"></h4></span>
                                            <span class="st"  id="now_status"><h4>결제 완료</h4></span>
                                        </div>
                                        <div id="status2">
                                            <span><strong>참가신청 양식</strong>을 작성하였습니다.</span>
                                            <span></span>
                                            <span><strong>결제 대기</strong> 상태입니다.</span>
                                            <span></span>
                                            <span><strong>결제 완료</strong>되었습니다.</span>
                                        </div>
                                    </div>

                                    <h3>${__APPLY__[0].applycompany} 님의 결제가 완료 되었습니다. </h3>

                                    <div id="info">
                                       <h4>${__APPLY__[0].applycompany} 님의 전시회 신청 정보입니다.</h4> 

                                       <div id="information">
                                            <h4>전시회명</h4>
                                            <h5>${__APPLY__[0].applyname}</h5>
                                            <h4>연락처</h4>
                                            <h5>${__APPLY__[0].phone}</h5>
                                            <h4>사업자등록번호</h4>
                                            <h5>${__APPLY__[0].cbno}</h5>
                                            <h4>결제번호</h4>
                                            <h5>${__PAYMENT__.pno}</h5>
                                            <h4>부스번호</h4>
                                            <h5>${__PAYMENT__.btno}</h5>
                                            <h4>가격</h4>
                                            <h5>${__PAYMENT__.btprice}</h5>
                                       </div>

                                       <h6 id="app_not">※전시회 취소 및 변경은 관리자에게 문의하세요 (02-123-45678) </h6>
                                    </div>
                                </div>  
                            </c:when >
                            
                            <%--2. 참가 신청 승인 완료시! 결제 정보 보여줌. 무통장 입금 --%>
                            <c:when test="${__APPLY__[0].agrstate_tf eq 'T'}">
                                <div id="inner_con">
                                    
                                    <div id="apply_status">
                                        <div id="status">
                                            <span class="st"><h4>승인 대기</h4></span>
                                            <span><h4><img src="/resources/img/applystatus_arrow.png" alt="" width="70" height="70"></h4></span>
                                            <span class="st" id="now_status"><h4>결제 대기</h4></span>
                                            <span><h4><img src="/resources/img/applystatus_arrow.png" alt="" width="70" height="70"></h4></span>
                                            <span class="st"><h4>결제 완료</h4></span>
                                        </div>
                                        <div id="status2">
                                            <span><strong>참가신청 양식</strong>을 작성 완료하였습니다.</span>
                                            <span></span>
                                            <span>승인 완료 후<strong>결제 대기</strong> 상태입니다.</span>
                                            <span></span>
                                            <span><strong>결제 완료</strong>되었습니다.</span>
                                        </div>
                                    </div>

                                    <h3>${__APPLY__[0].applycompany} 님의 관리자 승인이 완료 되었습니다. </h3>

                                    <div id="info">
                                       <h4>${__APPLY__[0].applycompany} 님의 결제 정보입니다.</h4> 

                                       <div id="information">
                                           <h4>결제번호</h4>
                                           <h5>${__PAYMENT__.pno}</h5>
                                           <h4>부스번호</h4>
                                           <h5>${__PAYMENT__.btno}</h5>
                                           <h4>가격</h4>
                                           <h5>${__PAYMENT__.btprice}</h5>
                                           <h4>입금처</h4>
                                           <h5>예금주 : 지페어 농협 1234-5678-910</h5>
                                       </div>
                                    </div>
                                </div>  
                            </c:when >

                           
                            
                        </c:choose>
                    </div>
                </div><!--content in-->
            </div>
        </div>

   	<span id="top_btn">top</span> 
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>