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
    <link rel="stylesheet" href="/resources/css/companyGetPage.css">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
    <script src="/resources/js/top.js" type="text/javascript"></script>
</head>
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
    $(function(){
     
        //목록보기
        $('#exListBtn').on('click',function(){

            location.href = "/apply/companyList?applyname=${applyname}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";

        });//listBtn

    })
</script>

<script>
    // ==== 진성 좋아요 기능 ==== //
    // ==== 진성 좋아요 기능 ==== //
    // ==== 진성 좋아요 기능 ==== //

    $(function(){

        $('#hide_cp_img').val($('#companyImg').attr('src')); //참여기업 이미지 경로 가져오기


    	var cp_img = $('#hide_cp_img').val(); //기업 이미지 경로
        var cp_img_arr = getCookie('cp_img').split(','); //쿠키에 등록된 이미지 경로
        
        var applyno = ${param.applyno}; //요청파라미터(쿼리스트링)로 받은 신청 전시회 번호 
        var applynoarr = getCookie('cp_no').split(','); //쿠키에 등록된 신청 전시회 번호

        $('#cp_append').html(""); //좋아요 목록에 담긴 리스트 초기화

        //쿠키에 담긴 좋아요 리스트를 순회
        for(var i = 0; i < applynoarr.length; i++) {

        	//만약 담긴게 없다면 아무동작도 하지않음
            if(applynoarr[0].trim() == "") {
                break;
            }

        	//만약 현재페이지의 신청 전시회 번호랑, 쿠키에 등록된 전시회 번호가 같다면
        	//좋아요버튼(하트) 변경
            if(applyno == applynoarr[i]) {
                $('#cp_h_img').attr('src', '/resources/img/ico_h_on.png');
            }//if

        	//우측 좋아요 목록에 추가
            InputHtml(i);
            $('#cookie_img' + i).attr('src', cp_img_arr[i]);

        }//for
        
    })//end jq

    //쿠키 등록
    function setCookie(name, value, exp) {
        var date = new Date();
        date.setTime(date.getTime() + exp*24*60*60*1000);
        document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
    }

    //쿠키 얻어오기
	function getCookie(key) {

        var cookie = document.cookie;
        var cookie_arr = cookie.split(";");
        var cookie_json = {};

        if (cookie) {
            for (var i = 0, j = cookie_arr.length; i < j; i++) {

                var arr = cookie_arr[i].split("=");
                var _key = arr[0].trim();
                var _value = arr[1].trim();
                cookie_json[_key] = _value;

            }//for
        }//if

        if (cookie_json[key]) {
            return cookie_json[key];
        }//if
        
        return "";
    }//getCookie

    // 쿠키 입력
    function insCookie(key, value, days) {

        var cookie_value = getCookie(key);
        var cookie_arr = cookie_value.split(',');
        var cookie_arr = (cookie_value||'').split(',');

        if (!cookie_value || !cookie_arr.length) {
            cookie_arr = [];
        }//if

        // 3개 이상일때
        if (cookie_arr.length >= 3) {
            cookie_arr.push(value);
            cookie_arr.splice(0, 1);
        } else {
            cookie_arr.push(value);
        }//if-else

        var exdate = new Date();
        exdate.setDate(exdate.getDate() + days);
        //설정 일수만큼 현재시간에 만료값으로 지정
        var path = '/';
        var cookie = cookie_arr.join(",") + ((days == null) ? '' : ';    expires=' + exdate.toUTCString() + '; path=' + path);
        document.cookie = key + '=' + cookie;
        //alert(document.cookie);

    }//insCookie


    // 쿠키 삭제
    function delCookie(key, value, days) {

        var cookie_value = getCookie(key);
        var cookie_arr = cookie_value.split(",");

        if (!cookie_arr.length) {
            cookie_arr = [];
        }//if

        for (var i = 0, j = cookie_arr.length; i < j; i++) {

            if (cookie_arr[i] == value) {
                cookie_arr.splice(i, 1);
            }//if

        }//for

        var exdate = new Date();
        exdate.setDate(exdate.getDate() + days);
        //설정 일수만큼 현재시간에 만료값으로 지정
        var path = '/';
        var cookie = cookie_arr.join(",") + ((days == null) ? '' : ';    expires=' + exdate.toUTCString() + '; path=' + path);
        document.cookie = key + '=' + cookie;

    }//delCookie

	//좋아요(하트)버튼 클릭 시에 이미지 변경
    function h_imgChange() {
        var cp_img = $('#hide_cp_img').val();
        var cp_h_img = $('#cp_h_img').attr('src');
        var cp_no = $('#cp_no').val();

        if(cp_h_img == "/resources/img/ico_h_on.png") { //on 일때
            $('#cp_h_img').attr('src', "/resources/img/ico_h_off.png"); //off로 바꿈
            delCookie('cp_img', cp_img, 1);
            delCookie('cp_no', cp_no, 1);
        } else { //off일때
            $('#cp_h_img').attr('src', "/resources/img/ico_h_on.png"); //on으로 바꿈
            insCookie('cp_img', cp_img, 1);
            insCookie('cp_no', cp_no, 1);
        }//if-else

        //쿠키에 올라가있는 신청기업 이미지 경로들을 변수에 담음
        var cp_img_arr = getCookie('cp_img').split(',');
        //태그 초기화
        $('#cp_append').html("");

        //쿠키에 올라가있는 신청기업 이미지 경로들의 배열을 순회
        for(var i =0; i < cp_img_arr.length; i++) {
			//쿠키의 첫번째 이미지 경로가 비어있다면, 즉 좋아요 누른게 없다면 break
            if(cp_img_arr[0].trim() == "") {
                break;
            }//if
			
			//즉 좋아요(하트) 버튼 클릭 시에
			//우측 좋아요 목록에 추가
            InputHtml(i);
            $('#cookie_img' + i + "").attr('src', cp_img_arr[i]);

        }//for

    }//h_imgChange

    //좋아요(하트) 버튼을 클릭했을 때, 
    //우측 좋아요 목록 메뉴에 html 태그 생성 함수
    function InputHtml(seq) {
        var html = "<li id='list_" + seq + "'>" +
            "<a href='javascript: showCpImg("+ seq +");' id='cp_no" + seq + "'>" +
            "<img src='' width='100px' height='100px' id='cookie_img" + seq + "'/> " +
            "</a>" +
            "<em class='ico_c1'>기업</em>" +
            "</li>";

        $('#cp_append').append(html);
    }//InputHtml

    //쿠키에 올라가있는 신청번호를 통해
    //우측 좋아요 목록에 담긴 이미치에 링크를 걸어주는 함수
    function showCpImg(seq) {
        var cp_no_arr = getCookie('cp_no').split(',');

        if(seq == 0) {
            location.href = "/apply/companyInfo?applyno=" + cp_no_arr[0];
        } else if(seq == 1) {
            location.href = "/apply/companyInfo?applyno=" + cp_no_arr[1];
        } else if(seq == 2) {
            location.href = "/apply/companyInfo?applyno=" + cp_no_arr[2];
        }//if-else
    }//showCpImg

</script>

<script>
	//우측 좋아요로 담은 메뉴바 애니메이션 이벤트
	$(function(){
		
		var currentPosition = parseInt($(".fav_box").css("top")); 
		$(window).scroll(function() { 
			var position = $(window).scrollTop(); 
			$(".fav_box").stop().animate({"top":position+currentPosition+"px"},700); 
		});//scroll
		
	});//endjq

</script>

<style>
    /* ==== 진성 좋아요 기능 ==== */
    #cp_h_img {
        width: 27px;
        height: 22px;
    }

    .fav_box {
        position: absolute;
        top: 300px;
        right: 20px;
        height: 200px;
    }
    
    .fav_box ul {
    	width: 200px;
    	background: #eee;
    	border-radius: 0 0 10px 10px;
    	min-height: 150px;
    }
    
    .fav_box ul li:first-child {
    	padding-top: 25px;
    }
    
    .fav_box ul li:last-child {
    	padding-bottom: 25px;
    }

    .fav_box ul li {
    	margin: 0 auto;
    	padding: 10px;
        width: 150px;
        height: 100px;
        position: relative;
        text-align: center;
        line-height: 100px;
        overflow: hidden;

    }
    
    #cp_title {
   	    text-align: center;
	    background: #005bbb;
	    color: #fff;
	    font-size: 20px;
	    height: 50px;
	    line-height: 50px;
	    border-radius: 20px 20px 0 0;
    }
    /* ==== 진성 좋아요 기능 ==== */
    
</style>

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
                    <div class="map">home > 참가안내 > 참가기업목록 </div>
                    <h2 class="subName">참가기업목록</h2>
                </div>
                <div class="contentIn">
                    <div id="exWrapper">
                        
                        <div id="getPage">
                           <div class="subjectLine">
                                <!-- 글제목 -->
                                <div class="subject">
                                    <p>참가전시회명 : ${company.applyname}</p>
                                </div>
                               
                                <!-- 등록일 / 수정일 / 조회수-->
                                <div class="regDate">
                                    &nbsp;&nbsp;&nbsp;참가신청일:<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${company.applydate}"/>
                                </div>
                           </div>
                           <!-- 내용 -->
                            <div class="content">
                                <div class="companyImg"><img id="companyImg" src='/resources/img${company.fpath}/${company.frename}_${company.forname}'></div>
                                <table class="companyTable">
                                    <tbody>
                                        <tr>
                                            <th>업체명</th>
                                            <td>
                                                <p>
                                                    ${company.applycompany}
                                                    <a href="#" onclick="h_imgChange(); return false;">
                                                        <img src="/resources/img/ico_h_off.png" id="cp_h_img" >
                                                        <input type="hidden" id="hide_cp_img" value="">
                                                        <input type="hidden" id="cp_no" value="${param.applyno}">
                                                    </a>
                                                </p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>대표자</th>
                                            <td><p>${company.membername}</p></td>
                                        </tr>
                                        <tr>
                                            <th>이메일</th>
                                            <td><p>${company.email}</p></td>
                                        </tr>
                                        <tr>
                                            <th>홈페이지</th>
                                            <td><a href="#">http://www.bitcamp.org</a></td>
                                        </tr>
                                        <tr>
                                            <th>주소</th>
                                            <td><p>${company.memberaddress}</p></td>
                                        </tr>
                                        <tr>
                                            <th>소개</th>
                                            <td><p>우수한 상품 판매</p></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="reg">
                                <button type="button" class="buttonstyle" id="exListBtn">목록</button>
                            </div>
                        </div>
                    </div>


                    <!-- ==== 진성 좋아요 기능 ==== -->
                    <div class="fav_box">
                        <div id="cp_title">관심 기업</div>
                        <ul id="cp_append">
                            <!-- 여기에 기업 이미지, 정보가 생성됨 -->
                        </ul>
                    
                    </div>
                    <!-- ==== 진성 좋아요 기능 ==== -->


                </div>
            </div>
        </div>

        <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>