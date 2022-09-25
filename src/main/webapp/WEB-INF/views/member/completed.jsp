<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>


<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="/resources/css/common.css">
    
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    
    <script type="text/javascript">
    $(document).ready(function(){
    	$('#loginPage_button').click(function(){
    		$(location).attr('href','/login/login');
    	});//click
    });//ready
    
    </script>
    
    <style>
    	body {
    		background-color: #eff2f4;
    	}
    	    
		#wrap{
            width: 100%;
            height: 950px;
            background-color: #eff2f4;
        }

        .logo{
            width: 200px;
            padding: 50px;
            margin: 0 auto;
        }

        .logo a{
            display: block;
            
        }

        #container{
            width: 100%;
            max-width: 680px;
            min-width:400px;
            height:600px;
            background-color: #fff;
            padding: 0px;
            margin: 0 auto;
        }

        #container .step{
            width: 100%;
            height: 140px;
            
            margin: 0 auto;
        }
        #container .step ul {
            width: 550px;
            height: 180px;
            margin: 0 auto;
        }

        #container .step ul li{
            width: 82px;
            height: 100px;
            float: left;
            padding: 27px;
            text-align: center;
            font-size: 16px;
            color: #000;
        }

        #container .guideText{
            margin-bottom: 30px;
        }

        #container .guideText h2{
            margin-top: 50px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
        }
        
        section{
            margin: 0 auto;
            padding: 20px;
        }

        .img_box{
            text-align: center;

        }
        
        .text_box{
        	width: 350px;
        	height: 50px;
        	margin: 0 auto;
        }
        
        .text_1{
        	font-size: 18px;
        	text-align:center;
        }
        .text_2{
        	font-size: 16px;
        	text-align:center;
        	color:#555;
        }

        .btnBox{
            margin: 0 auto;
            width: 350px;
        }

        .btn{
	        width:350px;
		    background-color: #005bbb;
            height: 50px;
            text-align: center;
		    color:#fff;
            border: none;
		    padding: 15px 0;
		    text-align: center;	
		    text-decoration: none;
		    display: inline-block;
		    margin: 4px;
		    cursor: pointer;
        }

    </style>

</head>
<body>

    <div id="wrap">
        <div class="logo">
            <a href="/">
                <img src="/resources/img/logo.png" alt="">
            </a>
        </div>

        <div id="container">

            <div class="step">
                <ul>
                    <li><img src="/resources/img/process_1.png" alt="">약관동의</li>
                    <li><img src="/resources/img/process_2.png" alt="">가입유형</li>
                    <li><img src="/resources/img/process_3.png" alt="">정보입력</li>
                    <li><img src="/resources/img/on_process_4.png" alt="">가입완료</li>
                </ul>
            </div>

            <div class="guideText">

                <h2 class="text_1">지페어 코리아 <strong>회원가입</strong>이 완료되었습니다.</h2>

            </div>

            <section>
				<div class="img_box"><img src="/resources/img/check.png" alt=""></div>
                <div class="text_box">
	                <h3 class="text_2"><strong>로그인</strong> 후 더 많은 서비스를 이용할 수 있습니다.</h3>
                </div>
                <div class="btnBox">         
                    <button type="submit" id="loginPage_button" class="btn" >로그인 페이지 이동</button>           
            	</div>
            </section>

        </div>

        
    </div>
    
</body>
</html>