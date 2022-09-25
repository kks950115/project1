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

    #agreementBtn_area{
        margin-top: 10px;
        display: flex;
        justify-content: center;
    }

    #contents{
        font-size: 16px;
        padding: 30px 0 30px 10px;
    }

    h1{
        font-weight: bold;
    }
    h2{
        font-weight: bold;
    }

    .font_color{
        color: red;
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
        

        // var agreement = $('input:radio[name=public_tf]:checked').val();
        // var agreement1 = $('input[name=public_tf]').is(':checked');

        // $('#agreementBtn').on('click', function () {

        //     if(agreement1 == true){
        //         location.href = "/pre/register";

        //     }else{
        //         alert('동의 하세요')
        //     }
        // })

        $('#agreementBtn').on('click', function () {
            console.debug("#agreementBtn Clicked.");
            var value = $('input[name="agreement"]:checked').val();


            if(value != "T"){
                alert('약관에 동의를 해야지만 신청서 작성이 가능합니다. ');

            }else{
                location.href = "/pre/register";
            }// if - else
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
                    <div id="agreement_form">
                        <form action="/pre/agreement">
                            <input type="hidden" name="bno" value="${board.bno}">
                            <div id="contents">
                                <h1 class="font_color">
                                    10월 27일(월)까지 사전참관신청가능 (전시기간 10.28~30 동안은 현장등록만 가능합니다.)
                                </h1>
                                <br>
                                <h1>
                                    중소기업 지원사업 통합관리시스템 정보 활용을 위한 동의서
                                </h1>
                    
                                <h2>□ 목적</h2>
                                <p>
                                    ①정부와 지자체 중소기업 지원사업의 효율적 수행을 위해 운영하는 “중소기업 지원사업 통합관리시스템” 에서 신청기업 및 지원기업 지원이력 정보의 수집‧조회 및 활용<br>
                                    ②동 통합관리시스템에서 관리하는 기업정보의 확인, 지원효과 분석, 통계관리 등 효율적인 중소기업 정책 수립을 위해 국세청‧관세청‧고용부 등에서 보유하고 있는 과세정보 등의 수집‧활용<br>
                                    ③ 기업지원사업 참여자가 제출한 일련의 서류에 대한 정보활용 및 지원기관의 자료 제출요청 및 갱신에 임함<br>
                                </p>
                                <br>
                                <h2>□ 수집‧조회 및 활용 정보</h2>
                                <p>
                                    ① (이력정보) 신청일, 지원금액 등 수혜정보와 사업자등록번호 등 개인·기업 식별정보<br>
                                    ② (과세정보 및 행정정보 등) 중소기업 지원사업에 신청한 기업의 국세기본법 제81조의13의 과세정보로서 매출액, 납입자본금, 자산총액, 부채총액, 영업이익, 당기순이익 및 창ㆍ휴ㆍ폐업일, 소득세 원천징수 인원 등, 관세법 제116조에 따른 수출액 등, 고용보험법 제2조의1의 피보험자수 등<br>
                                    ③ (신용정보) 지원사업 참여자에 한해 지원자격 심사 및 사후관리를 위하여 신용조회회사 또는 신용정보 집중기관으로부터 귀하의 신용정보를 조회할 수 있음 (신용정보의 이용 및 보호에 관한 법률, 제 32조)<br>
                                </p>
                                <br>
                                <h2>□ 수집‧조회 및 활용 기관</h2>
                                <p>
                                    ◦ 해당 지원사업 소관부처(집행기관 포함), 중소기업 통합관리시스템 운영기관<br>
                                </p>
                                <br>
                                <h2>□ 동의 효력기간</h2>
                                <p>
                                    ◦ 사업자가 사업 신청시 본 동의서를 제출한 시점 이후<br>
                    
                                    * 제공된 목적달성 후에는 중소기업 지원사업 통합관리시스템의 효율적인 운영을 위해 필요한 범위 내에서만 보유‧이용<br>
                    
                                    ◦ 기업정보 수집 시점 : 신청 및 수혜기업의 사업 신청 이전 3개년부터 참여 이후 5년간<br>
                    
                                    * 보유 정보가 없을 경우 수집하지 않음<br>
                    
                    
                                    ※ 본 동의서식의 동의서 징구는 민법 제114조의 행정행위의 대리권 행사방식의 현명주의를 적용하여, 중소기업 지원사업의 효율적인 운영을 위해 본 사업의 소관부처 및 수행기관이 대신하여 받는 것임을 알려 드립니다.<br>
                    
                                    ※ 본인은 위 목적으로 동의서에 적시된 정보 및 기관에 한해 본인의 기업정보를 수집ㆍ조회 및 활용하는 것에 동의합니다.<br>
                    
                                    ※ 본인은 위 각 정보의 수집/조회/활용에 관한 자세한 설명을 듣고, 본 동의서 내용을 충분히 이해하고 동의하였습니다.<br>
                    
                                    본인은 위 목적으로 동의서에 적시된 정보 및 기관에 한해 본인의 기업정보를 수집․조회 및 활용하는 것에 동의합니다.<br><br>
                                    <div style="text-align:center;">
                                    	<input  id="agreementT" type="radio" name="agreement" value="T" ><label style="margin-right:60px;" for="agreementT">예</label>
                                    	<input  id="agreementF" type="radio" name="agreement" value="F" checked><label for="agreementF">아니요</label>
                                	</div>
                                </p>
                            </div>
                            <div id="agreementBtn_area">
                                <button type="button" class="btn" id="agreementBtn" >확인</button>
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