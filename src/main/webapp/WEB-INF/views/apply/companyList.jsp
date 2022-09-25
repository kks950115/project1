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
    <link href="/resources/css/companyList.css" rel="stylesheet" type="text/css" />
    
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


        $('#listBtn').on('click',function(){

            location.href = "/apply/companyList?currPage=${page.cri.currPage}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}";

        });//listBtn
    
        // 페이징
        $('a.prev, a.next, a.end').on('click',function(e) {

            e.preventDefault();

            var paginationForm = $('#paginationForm');

            paginationForm.attr('action','/apply/companyList');
            paginationForm.attr('method','GET');

            paginationForm.find('input[name=currPage]').val($(this).attr('href'));
            paginationForm.find('input[name=amount]').val('${page.cri.amount}');
            paginationForm.find('input[name=pagesPerPage]').val('${page.cri.pagesPerPage}');

            paginationForm.find('input[name=applyname]').val('${applyname}');

            paginationForm.submit();

        })//onclick

        //항목별 검색조회
        $('#exOption').change(function(){//
           
           exVal = $(this).val();
           
           console.log('exVal값:',exVal);

           var exValForm = $('#exValForm');
           exValForm.attr('action','/apply/companyList');
           exValForm.attr('method','GET');

           exValForm.append('<input type="hidden" name="currPage" value="1">');
           exValForm.append('<input type="hidden" name="amount" value="${page.cri.amount}">');
           exValForm.append('<input type="hidden" name="pagesPerPage" value="${page.cri.pagesPerPage}">');
           exValForm.append('<input type="hidden" name="applyname" value="'+exVal+'">');
           exValForm.submit();

       })//boardOption
    })//.jq
    
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
	$(function(){
	    var cp_img_arr = getCookie('cp_img').split(','); //쿠키에 등록된 이미지 경로
	    
	    var applynoarr = getCookie('cp_no').split(','); //쿠키에 등록된 신청 전시회 번호
	
	    $('#cp_append').html(""); //좋아요 목록에 담긴 리스트 초기화
	
	    //쿠키에 담긴 좋아요 리스트를 순회
	    for(var i = 0; i < applynoarr.length; i++) {
	
	    	//만약 담긴게 없다면 아무동작도 하지않음
	        if(applynoarr[0].trim() == "") {
	            break;
	        }
	
	    	//우측 좋아요 목록에 추가
	        InputHtml(i);
	        $('#cookie_img' + i).attr('src', cp_img_arr[i]);
	
	    }//for
	    
	})//end jq
	
	
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

                <!-- 게시판넣기 -->
                <div class="contentIn">
                    <p id="totalCount">전체 참여기업 수 : ${page.totalAmount}</p>
                    
                    <div class="selectDiv">
                        전시회별로 참가기업 조회하기
                        <form id="exValForm">
                            
                            <select name="applyname" id="exOption">
                                <option value=>전체보기</option>
                                <c:forEach items="${exList}" var="ex">
                                    <option value="${ex.exname}" ${(ex.exname eq applyname) ? 'selected' : ''}>${ex.exname}
                                        (<fmt:formatDate pattern="yyyy/MM/dd" value="${ex.exstart}"/> ~
                                        <fmt:formatDate pattern="yyyy/MM/dd" value="${ex.exend}"/>)
                                    </option>
                                </c:forEach>
                            </select>
                        </form>
                    </div>
                    
                    <ul class="companyWrap">
                        <c:forEach items="${companyList}" var="company" >
                            <li>
                                <a href="/apply/companyInfo?applyno=${company.applyno}&currPage=${page.cri.currPage}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}">
                                    <div class="companyImg">
                                        <img src='/resources/img${company.fpath}/${company.frename}_${company.forname}'>
                                    </div>
                                    <!-- 업체명 -->
                                    <p class="ptitle">${company.applycompany}</p>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>

                    <div class="reg">
                        <button type="button" class="buttonstyle" id="listBtn">목록</button>
                    </div>
        
                    <div id="pagination">
                        <form action="/anony/list" id="paginationForm">
                            <input type="hidden" name="currPage">
                            <input type="hidden" name="amount">
                            <input type="hidden" name="pagesPerPage">
                            <input type="hidden" name="applyname">
                            
                            <ul>
                                <li class="start"><a href="/apply/companyList?applyname=${applyname}&currPage=1&amount=12&pagesPerPage=${page.cri.pagesPerPage}">첫페이지</a></li>

                                <c:if test="${!page.prev}">
                                    <li class="prev"><a href="/apply/companyList?applyname=${applyname}&currPage=1&amount=12&pagesPerPage=${page.cri.pagesPerPage}">이전</a></li>
                                </c:if>

                                <c:if test="${page.prev}">
                                    <li><a class="prev" href="${page.startPage-1}">이전</a></li>
                                </c:if>
                                
                                <c:forEach var="pageNum" begin="${page.startPage}" end="${page.endPage}">
                                    <li class="${page.cri.currPage == pageNum ? 'currPage' : ''}">
                                        <a href="/apply/companyList?applyname=${applyname}&currPage=${pageNum}&amount=${page.cri.amount}&pagesPerPage=${page.cri.pagesPerPage}">${pageNum}</a>
                                    </li>
                                </c:forEach>
                                
                                <c:if test="${page.next}">
                                    <li><a class="next" href="${page.endPage+1}">다음</a></li>
                                </c:if>

                                <c:if test="${!page.next}">
                                    <li><a class="next" href="${page.realEndPage}">다음</a></li>
                                </c:if>

                                <li><a class="end" href="${page.realEndPage}">끝페이지</a></li>
                            </ul>
                        </form>
                    </div>
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

        <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>