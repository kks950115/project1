<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>G-FAIR KOREA</title>

    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/main.css" rel="stylesheet" type="text/css" />
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
    <script src="/resources/js/top.js"></script>
    
    <script src="/resources/js/movebanner.js" type="text/javascript"></script>
</head>

<script>

	$(function(){
		$('#back_btn').on('click', function(){
			window.history.back();
		})//onClick
	})//end jq
</script>

<style>
	#error_section {
		width: 100%;
		height: 600px;
		background-image: url(/resources/img/error.png);
		background-size: 900px;
		background-repeat: no-repeat;
		background-position: center;
	}
	#error_section img {
		
	}
	
	#btn_section {
        display: flex;
        justify-content: center;
	}
	
	#back_btn {
		margin-bottom: 25px;
	}
	
	.btn {
        width: 250px;
        height: 50px;

        border: 0;
        
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;
        
        cursor: pointer;
	}
</style>

<body>
    <div id="wrap">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    
    
    <div id="error_section">
    	
    </div>
    
    <div id="btn_section">
    	<button class="btn" id="back_btn" type="button">뒤로가기</button>
    </div>
    
    
    <div class="partner">
        <div class="partnerBox">
          <ul>
              <li><a href="https://www.bitcamp.co.kr/" title="비트캠프 새창으로 열림" target="_blank"><img src="/resources/img/partner1.png" alt="" /></a></li>
              <li><a href="#" title="쓰담쓰담 새창으로 열림" target="_blank"><img src="/resources/img/partner2.png" alt="" /></a></li>
              <li><a href="#" title="필미 새창으로 열림" target="_blank"><img src="/resources/img/partner3.png" alt="" /></a></li>
              <li><a href="#" title="포조 열림" target="_blank"><img src="/resources/img/partner4.png" alt="" /></a></li>
              <li><a href="https://www.kotra.or.kr/biz/" title="대한무역투자진흥공사 새창으로 열림" target="_blank"><img src="/resources/img/partner5.png" alt="" /></a></li>
              <li><a href="http://www.motie.go.kr/www/main.do" title="산업통상자원부 새창으로 열림" target="_blank"><img src="/resources/img/partner6.png" alt="" /></a></li>
              <li><a href="https://www.gg.go.kr/" title="경기도청 새창으로 열림" target="_blank"><img src="/resources/img/partner7.png" alt="" /></a></li>
              <li><a href="https://www.okta.net/okta/" title="세계한인무역협회 새창으로 열림" target="_blank"><img src="/resources/img/partner8.png" alt="" /></a></li>
              <li><a href="https://www.kintex.com/" title="킨텍스 새창으로 열림" target="_blank"><img src="/resources/img/partner9.png" alt="" /></a></li>
              <li><a href="https://www.mss.go.kr/site/smba/main.do" title="중소벤처기업부 새창으로 열림" target="_blank"><img src="/resources/img/partner10.png" alt="" /></a></li>
              <li><a href="https://www.gbsa.or.kr/index.do" title="경기도경제과학진흥원 새창으로 열림" target="_blank"><img src="/resources/img/partner11.png" alt="" /></a></li>
          </ul>
        </div>
      </div>
      <span id="top_btn">top</span>
      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div> <!--wrap-->        
</body>
</html>