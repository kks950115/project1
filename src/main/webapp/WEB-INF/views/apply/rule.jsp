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
	#title_wrap{
		width:700px;
		margin:0 auto;
		padding:50px;
	}
	
	#ex_left{
		width:600px;
		height:1450px;
		float:left;
		
		margin-bottom:30px;
		border-bottom:1px solid #000;
	}
	
	#ex_right{
		width:600px;
		height:1450px;
		float:right;
		margin-bottom:30px;
		border-bottom:1px solid #000;
	}
	
	
	#title_wrap h3{
		font-size:30px;
		font-weight:1000;
		text-align:center;
		
	}
	.ex_box{
		width:560px;
		padding:20px;
	}
	.explanation{
		font-size:16px;
		padding-left:10px;
		margin-bottom:20px;
	}
	
	.add_explanation{
		font-size:14px;
		margin-bottom:10px;
		color:red;
	}
	
	h4{
		font-size:16px;
		font-weight:bold;
		color:#005bbb;
	}
	
	.ex_detail{
		width:600px;
		margin:20px auto;
		
	}
	
	table{
		border-collapse: collapse;
	}
	
	table td{
		height:50px;
		font-size:14px;
	}
	
	table .td_title_area{
		text-align:center;
		font-size:20px;
		font-weight:bold;
		background-color:#005bbb;
		color:#fff
	}
	
	table .td_area{
		text-align:center;
		font-size:18px;
		font-weight:bold;
		color:#005bbb;
	}
	
	
	table .td_title{
		width:170px;
		padding:5px;
		font-weight:600;
	}
	
	table .td_content{
		width:440px;
		padding:5px;
		
		font-weight:300;
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
                    <div class="map">home > 참가안내 > 참가규정 </div>
                    <h2 class="subName">참가규정</h2>
                </div>
                <div class="contentIn">
                
                	<div id="title_wrap">
                		<h3>G-FAIR KOREA 참가규정</h3>
                	</div>
                	
                	<div id="ex_left">
	                	<div class="ex_box">
	                	<h4>제1조 (용어의 정의)</h4>
	                	<ul>
	                		<li class="explanation">"전시회"라 함은 'G-FAIR KOREA'를 말한다.</li>
	                		<li class="explanation">"주최자"라 함은 '경기도', "주관자"라 함은 '경기도경제과학진흥원(GBSA)', '대한무역투자진흥공사(KOTRA)'를 말한다.</li>
	                		<li class="explanation">"참가자"라 함은 “전시회” 참가신청을 하고 「G-FAIR KOREA」사무국으로부터 참가승인을 받은 회사, 조합, 단체, 개인 등을 말한다.</li>
	                	</ul>
	                	</div>
	                	
	                	<div class="ex_box">
	                	<h4>제2조 (참가 신청과 승인)</h4>
	                	<ul>
	                		<li class="explanation">참가신청 최소면적은 9m²(3m×3m/부스)이며 9m²의 배수로 추가 신청할 수 있다.</li>
	                		<li class="explanation">"참가자"는 참가신청서를 "주관자"에게 제출하고, "주관자"로부터 참가비 입금일을 기준으로 참가신청이 성립된 것으로 간주한다.</li>
	                	</ul>
	                	</div>
	                	
	                	<div class="ex_box">
	                	<h4>제3조 (참가비 및 부스)</h4>
	                	<ul>
	                		<li class="explanation">참가비는 A타입부스는 <strong>1,000,000원</strong>/(VAT별도), B타입부스는 <strong>2,000,000원</strong>/(VAT별도), "주관자"에 의해 할인율을 적용할 수 있다.</li>
	                		<li class="explanation">"참가자"는 참가신청서를 "주관자"에게 제출하고, "주관자"로부터 참가비 입금일을 기준으로 참가신청이 성립된 것으로 간주한다.</li>
	                	</ul>
	                	</div>
	                	
	           	        <div class="ex_box">
	                	<h4>제4조 (전시장 사용기간)</h4>
	                	<ul>
	                		<li class="explanation">전시장 사용기간은 개최 기준으로 하며, 전시준비 및 철거에 필요한 시간을 별도로 추가하여 제공할 수 있다.</li>
	                		<li class="explanation">전시장 개장시간은 매일 10:00~17:00 로 한다.</li>
	                		<li class="explanation">준비 및 철거 기간 중 전시장 사용시간은 08:00~17:00로 하며, "참가자"는 이를 반드시 준수하여야 한다. 단, 시간외 사용이 불가피할 경우에는 시간외 사용료를 해당 "참가자"가 부담하여야 한다.</li>
	                	</ul>
	                	</div>
	                	
	                	<div class="ex_box">
	                	<h4>제5조 (부스배정)</h4>
	                	<ul>
	                		<li class="explanation">"주관자"는 전시품목의 특성, 참가규모, 신청접수순서 및 기타 합리적인 기준에 의거하여 배정 및 변경 할 수 있다.</li>
	                		<li class="explanation">"참가자"는"주관자"의 사전승낙 없이 배정받은 전시면적의 일부 또는 전부를 타 업체에 전대 또는 교환할 수 없다.</li>
	                	</ul>
	                	</div>
	                	
	                	<div class="ex_box">
	                	<h4>제6조 (전시준비 및 철거)</h4>
	                	<ul>
	                		<li class="explanation">"참가자"는 배정된 부스위치에 지정된 준비기간(전시회 개장 1일전) 내에 부스설치 및 전시품 반입 등 전시 준비를 완료하여야 한다.</li>
	                		<li class="explanation">"참가자"는 "전시회"폐막 후 전시장 철거기간 내 전시장치물 및 전시품 일체를 완전히 철거하고 원상 복구하여야 한다. 기간 내에 철거하지 않았을 경우 "참가자"는 지연에 따른 손실이나 전시장에 대한 손상, 추가비용에 대해"주관자"에게 보상해야 한다.</li>
	                	</ul>
	                	</div>
                	</div>
                	
                	<div id="ex_right">
	                	<div class="ex_box">
	                	<h4>제7조 (전시실 관리 및 전시 제한)</h4>
	                	<ul>
	                		<li class="explanation">"참가자"는 참가신청서에 명시한 전시품을 전시하고 상주요원을 배치하여야 하며, "주관자"는 전시회의 이미지와 배치되는 전시품에 대해 전시를 제한할 수 있다.</li>
	                		<li class="explanation">"주관자"는"참가자"와 참관객의 권익을 보호하기 위하여 전시장 경비를 운용하나, "참가자"의 전시물품 또는 관련 장비의 최종적인 관리책임은 "참가자"에 있으며 전시물품에 대한 보험가입 등은 "참가자"임의로 한다.</li>
	                		<li class="explanation">"주관자"는 "전시회"의 성격과 배치되는 전시품 전시, 과도한 음향 사용, 통로 이벤트 행사를 제한 또는 금지할 수 있으며, "주관자"의 별도 허가 없이 전시 장내 판매 행위는 원칙적으로 금지한다.</li>
	                		<li class="explanation">전시장 장치물의 자재는 소방법규에 따라 불연 처리되어야 하며, "주관자"는 필요시 시정을 요구할 수 있다.</li>
	                		<li class="explanation">"참가자"는 전시기간 중 배정된 부스 및 부스 주위 통로 주위를 청결하게 유지할 책임이 있다.</li>
	                		<li class="explanation">독립부스는 구조물의 높이가 5M를 초과할 수 없으며 높이 규정을 숙지하지 못할 시 책임은 "참가자"에게 있다.</li>
	                		<li class="explanation">전시장 내 전시품에 대한 도난 발생 시 전적인 책임은 "참가자"에게 있다.</li>
	                	</ul>
	                	</div>
	                	
	                	<div class="ex_box">
	                	<h4>제8조 (참가신청 취소 및 환불규정)</h4>
	                	<ul>
	                		<li class="explanation">"참가자"가 신청(승인)한 전시부스의 전부 또는 일부의 사용을 거부하거나, 신청부스에 대한 참가비를 납부하지 않을 경우에 "주관자"는 일방적으로 참가신청을 해지할 수 있다.</li>
	                		<li class="explanation">참비를 완납한 "참가자"가 회사내부의 사정에 따라 참가취소가 불가피하여 서면으로 취소요청을 할 경우 다음과 같이 환불할 수 있다.</li>
							<li class="add_explanation">전시개최일 전일기준 60일이 초과한 시점에서 취소한 경우, "주관자"는 참가비 전액을 "참가자"에게 지불한다.</li>
							<li class="add_explanation">전시개최일 전일기준 30일~60일 중에 취소했을 경우, "참가자"는 기납부한 참가비의 50%를 환불받을 수 있다.</li>
							<li class="add_explanation">전시개최일 전일기준 30일 미만 시점에 취소했을 경우, 이미 납부한 참가비는 반환되지 않는다.</li>
	                	</ul>
	                	</div>
	
	                	<div class="ex_box">
	                	<h4>제9조 (전시회 변경)</h4>
	                	<ul>
	                		<li class="explanation">"주관자"가 전시회 개최를 취소하는 경우 이미 납부한 참가비 전액을 "참가자"에게 반환한다.단, "주관자"가 국가 위기 상황이나 천재지변 등 불가항력적인 사정으로 개최일 및 장소를 변경하거나 축소 또는 취소하는 경우 참가신청과 관련된 보상을 청구할 수 없다.</li>
	                		<li class="explanation">"주관자"는 필요한 경우 참가규정에 명시되지 않은 보충규정을 제정할 수 있으며, "참가자"는 이를 준수하여야 한다.</li>
	                		<li class="explanation">"참가자"는 KINTEX의 재규정을 준수하여야 한다.</li>
	                	</ul>
	                	</div>
	                	
	
	                	<div class="ex_box">
	                	<h4>제10조 (규정의 해석 및 분쟁해결)</h4>
	                	<ul>
	                		<li class="explanation">본 규정의 해석에 관하여 "주관자"와 "참가자"간의 이견이 있을 경우 "주관자"의 해석과 결정에 따라야 한다.</li>
	                		<li class="explanation">"전시회"에 관하여 발생하는 권리 및 의무에 대한 분쟁은 대한상사중재원의 중재판정에 따른다.</li>
	                	</ul>
	                	</div>
                	</div>
                	<div class="ex_detail">
                	<h4>참가기업 부스 배치 규정 세부 사항 안내</h4>
                	<ul>
                		<li class="explanation">G-FAIR KOREA 2021 (대한민국우수상품전시회) 참가기업의 부스 배치는 조기신청 기준(참가비 납부 포함), 재참가 기준, 연속참가 기준, 부스 종류(독립부스 우선) 등 G-FAIR KOREA 참가기업 부스 배치 원칙에 따라 배치된다.</li>
                	</ul>
               			<div>
               				<h4>개별 관 개요</h4>
                			<table border="1">
	               				<tr>
	               					<td colspan="2" class="td_title_area">2021년 개별 관 개요</td>
	               				</tr>
	               				
	               				<tr>
	               					<td class="td_area">관 구분</td>
	               					<td class="td_area">세부 품목군</td>
	               				</tr>
	               				
	               				<tr>
	               					<td class="td_title">주방용품관(Dining)</td>
	               					<td class="td_content">농·축산물, 유기농식품, 가공식품, 주방용품, 조리기구, 제빵기구, 식기류 등</td>
	               				</tr>
	               				
	               				<tr>
	               					<td class="td_title">생활용품관(Living)</td>
	               					<td class="td_content">영·유아용품, 문구류, 인테리어, 가구, 패브릭, 홈데코, 조명, 반려동물용품, 생활가전, 아이디어상품, IT상품 등</td>
	               				</tr>
	               				
	               				<tr>
	               					<td class="td_title">뷰티용품관(Beauty)</td>
	               					<td class="td_content">화장품, 미용용품, 의류, 가방, 벨트, 지갑, 악세사리, 쥬얼리 등</td>
	               				</tr>                				                				                				
	
	               				<tr>
	               					<td class="td_title">건강용품관(Healthcare)</td>
	               					<td class="td_content">헬스케어, 수면, 레저, 스포츠, 건강기능식품, 여행용품, 의약품, 위생용품 등</td>
	               				</tr>
               				</table>
               				
               				<p class="add_explanation">※ 위 사항을 적용하여 킨텍스 제1전시장 1~2홀 입구부터 시작되는 메인 통로를 기점으로 순차적 부스 배치 기준을 원칙으로 설정하고, 참가기업의 부스 이동 및 희망 위치 반영은 불가하며 원칙에 의거하여 부스 배정 후 “참가자”에게 부스 위치 안내 진행</p>
               				<p class="add_explanation">1.동종제품군 2.독립부스(4개 이상 신청기업) 3.복수부스(조립부스 2~3개 신청기업) 4.입금일과 신청일</p>
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