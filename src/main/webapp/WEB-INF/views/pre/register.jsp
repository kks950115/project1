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
    #container1{
        width: 1200px;
        margin-top: 50px;
        font-weight: bold;
    }

    h1{
        font-size: 25px;
        font-weight: bold;
    }

    .btn1 {
        width: 100px;
        height: 40px;

        border: 0;
        
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;
        
        cursor: pointer;
    }
    table{
        margin: 0 auto;
        width: 100%;
        border-collapse: collapse;
        font-size: 16px;
    }

    .buttons{
        width: 770px;
        margin-left: 500px;
    }

    .background_color{
        width: 150px;
        background-color: #eee;
        
    }

    .info{
        width: 300px;
        line-height: 40px;
        height: 40px;
    }

    #exname{
        width: 448px;
        height: 40px;
        font-size: 16px;
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
        

        $("#quitBtn").on("click", function () {
            window.history.back();
        });


        $("#submitBtn").on("click", function () {
            let exhiname = $('#exname').val();
            let exno = 0;
            console.log('exhiname: ', exhiname);

            <c:forEach items="${__EXHI__}" var="ex">
                if('${ex.exname}' == exhiname){
                    console.log('exno', '${ex.exno}'),
                    exno = '${ex.exno}',
                    $('#exno').attr('value', exno)
                }
            </c:forEach>

            if(exhiname == 'selected'){
                alert('전시회를 선택해주세요')
            }else{
                let formObj = $('#form')

                // formObj.attr('action', "/pre/registerAction");
                // formObj.attr('method', "POST");
                formObj.submit();
                
                alert('사전예약이 완료되었습니다.')

            }//if - else
        });
    })//end jq
</script>
<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">관람정보</h2>
                <ul id="parent">
                    <li><a class="chk" href="/pre/guide">사전관람안내</a></li>
                    <li><a class="chk" href="/pre/agreement">사전관람신청</a></li>
                    <li><a class="chk" href="/pre/verify">사전관람신청확인</a></li>
                </ul>
            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 관람정보 > 사전관람신청 </div>
                    <h2 class="subName">사전관람신청</h2>
                </div>
                <div class="contentIn">
                	
                    <!-- 여기에 게시판 넣으면 됩니다. -->
                    <div id="container1">
                        <form action="/pre/registerAction" method="POST" id="form">
                            <table border="1">
                                <tbody>
                                    <tr>
                                        <th class="background_color">
                                            <label for="applyer">성명</label>
                                        </th>
                                        <td>
                                            <div class="info">
                                                &nbsp;<input type="hidden" id="applyer" name="applyer" value="${__LOGIN__.membername}" readonly>${__LOGIN__.membername}
                                            </div>
                                        </td>
                                        <th class="background_color"><label for="email">전자우편</label></th>
                                        <td>
                                            <div class="info">
                                                &nbsp;<input type="hidden" class="info" id="email" name="email" value="${__LOGIN__.email}" readonly>${__LOGIN__.email}
                                            </div>
                                        </td>
                                    </tr>   
                                    <tr>
                                        <th class="background_color"><label for="phone">휴대전화</label></th>
                                        <td>
                                            <div class="info">
                                                &nbsp;<input type="hidden" class="info" id="phone" name="phone" value="${__LOGIN__.phone}" readonly>${__LOGIN__.phone}
                                            </div>
                                        </td>
                                        
                                        <th class="background_color"><label for="appname">전시회</label></th>
                                        <td>
                                            <div class="info">
                                                <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                                                <select name="appname" id="exname">
                                                    <option value="selected">전시회 선택</option>
                                                    <c:forEach items="${__EXHI__}" var="ex">
                                                        <option value="${ex.exname}">${ex.exname} (
                                                            <fmt:formatDate value="${ex.exstart}" type="date"/> ~
                                                            <fmt:formatDate value="${ex.exend}" type="date"/>
                                                            )
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                                <input type="hidden" name="exno" id="exno" value="">

                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="background_color">
                                            <label for="c213">회사분류</label>
                                        </th>
                                        <td colspan="3">
                                            <div>
                                                &nbsp;<input type="checkbox" value="a" name="fnCode1_new" id="c213_1" class="i_radio">
                                                <label for="c213_1">정부/공공기관</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="b" name="fnCode1_new" id="c213_2" class="i_radio">
                                                <label for="c213_2">서비스업</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="c" name="fnCode1_new" id="c213_3" class="i_radio">
                                                <label for="c213_3">제조업</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="d" name="fnCode1_new" id="c213_4" class="i_radio">
                                                <label for="c213_4">협회/단체</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="e" name="fnCode1_new" id="c213_5" class="i_radio">
                                                <label for="c213_5">무역업(바이어)</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="f" name="fnCode1_new" id="c213_6" class="i_radio">
                                                <label for="c213_6">학교/연구/교육기관</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="g" name="fnCode1_new" id="c213_7" class="i_radio">
                                                <label for="c213_7">유통업체</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="h" name="fnCode1_new" id="c213_8" class="i_radio">
                                                <label for="c213_8">기타</label>
                                                <br>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="background_color">
                                            <label for="c214">업무분야</label>
                                        </th>
                                        <td colspan="3">
                                            <div>
                                                &nbsp;<input type="checkbox" value="a" name="fnCode2_new" id="c214_1" class="i_radio">
                                                <label for="c214_1">사무/경영/관리</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="b" name="fnCode2_new" id="c214_2" class="i_radio">
                                                <label for="c214_2">학생</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="c" name="fnCode2_new" id="c214_3" class="i_radio">
                                                <label for="c214_3">판매/영업/마케팅</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="d" name="fnCode2_new" id="c214_4" class="i_radio">
                                                <label for="c214_4">주부</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="e" name="fnCode2_new" id="c214_5" class="i_radio">
                                                <label for="c214_5">기술/연구개발</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="f" name="fnCode2_new" id="c214_6" class="i_radio">
                                                <label for="c214_6">자영업자</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="g" name="fnCode2_new" id="c214_7" class="i_radio">
                                                <label for="c214_7">생산/품질관리</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="h" name="fnCode2_new" id="c214_8" class="i_radio">
                                                <label for="c214_8">기타</label>
                                                <br>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="background_color">
                                            <label for="c215">참관목적</label>
                                        </th>
                                        <td colspan="3">
                                            <div>
                                                &nbsp;<input type="checkbox" value="a" name="fnCode3_new" id="c215_1" class="i_radio">
                                                <label for="c215_1">정보수집/창업정보</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="b" name="fnCode3_new" id="c215_2" class="i_radio">
                                                <label for="c215_2">일반관람</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="c" name="fnCode3_new" id="c215_3" class="i_radio">
                                                <label for="c215_3">시장/신상품 정보조사</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="d" name="fnCode3_new" id="c215_4" class="i_radio">
                                                <label for="c215_4">차기전시회참가</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="e" name="fnCode3_new" id="c215_5" class="i_radio">
                                                <label for="c215_5">구매상담/신규 거래선 확보</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="f" name="fnCode3_new" id="c215_6" class="i_radio">
                                                <label for="c215_6">기타</label>
                                                <br>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="background_color">
                                            <label for="c216">인지경로</label>
                                        </th>
                                        <td colspan="3">
                                            <div>
                                                &nbsp;<input type="checkbox" value="a" name="fnCode4_new" id="c216_1" class="i_radio">
                                                <label for="c216_1">TV광고(지상파)</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="b" name="fnCode4_new" id="c216_2" class="i_radio">
                                                <label for="c216_2">TV광고 (케이블)</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="c" name="fnCode4_new" id="c216_3" class="i_radio">
                                                <label for="c216_3">TV프로그램/뉴스</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="d" name="fnCode4_new" id="c216_4" class="i_radio">
                                                <label for="c216_4">라디오광고</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="e" name="fnCode4_new" id="c216_5" class="i_radio">
                                                <label for="c216_5">신문/잡지/전단지</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="f" name="fnCode4_new" id="c216_6" class="i_radio">
                                                <label for="c216_6">지하철/버스 영상광고</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="g" name="fnCode4_new" id="c216_7" class="i_radio">
                                                <label for="c216_7">버스외부 광고</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="h" name="fnCode4_new" id="c216_8" class="i_radio">
                                                <label for="c216_8">인터넷/SNS/홈페이지</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="h" name="fnCode4_new" id="c216_9" class="i_radio">
                                                <label for="c216_9">모바일 초청장/캔고루</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="h" name="fnCode4_new" id="c216_10" class="i_radio">
                                                <label for="c216_10">홍보물(초청장/브로슈어/포스터)</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="h" name="fnCode4_new" id="c216_11" class="i_radio">
                                                <label for="c216_11">옥외광고(홍보탑/전광판/육교현판/가로등배너)</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="h" name="fnCode4_new" id="c216_12" class="i_radio">
                                                <label for="c216_12">생활접정형 광고(편의점, 마트 외)</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="h" name="fnCode4_new" id="c216_13" class="i_radio">
                                                <label for="c216_13">거래업체/유관기관/지인소개</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="h" name="fnCode4_new" id="c216_14" class="i_radio">
                                                <label for="c216_14">기타</label>
                                                <br>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="background_color">
                                            <label for="c217">관심분야</label>
                                        </th>
                                        <td colspan="3">
                                            <div>
                                                &nbsp;<input type="checkbox" value="a" name="fnCode5_new" id="c217_1" class="i_radio">
                                                <label for="c217_1">생활용품</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="b" name="fnCode5_new" id="c217_2" class="i_radio">
                                                <label for="c217_2">주방용품</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="c" name="fnCode5_new" id="c217_3" class="i_radio">
                                                <label for="c217_3">뷰티용품</label>
                                                <br>
                                                &nbsp;<input type="checkbox" value="d" name="fnCode5_new" id="c217_4" class="i_radio">
                                                <label for="c217_4">건강용품</label>
                                                <br>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <br>
                            <div class="buttons">
                                <button type="button" class="btn1" id="submitBtn">등록</button>
                                <button type="button" class="btn1" id="quitBtn">취소</button>
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