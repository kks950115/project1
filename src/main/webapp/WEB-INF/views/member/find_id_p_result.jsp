<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>


<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디찾기</title>
    <link rel="stylesheet" href="/resources/css/common.css">
    
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    
    <script>
    
        $(function() {
            $('#login_button').on('click', function(){
                location.href = "/login/login";
            });
   
        }); //end jq
    
    
    
    </script>
    
    <style>
    	body {
    		background-color: #eff2f4;
    	}
    	
        #wrap{
            width: 100%;
            height: 750px;
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
            margin-bottom: 50px;
        }

        #container .guideText h2{
            margin-top: 50px;
            text-align: center;
            font-size: 20px;
            font-weight: bold;
        }
        
        .text_1{
        	font-size: 18px;
        	text-align:center;
        }


        section{
            margin: 0 auto;
            padding: 50px;
            margin-bottom: 80px;
        }
    
        .join_title{
            margin-top: 10px;
            margin-bottom: 40px;
            font-size: 15px;
            color: #005bbb;
            font-weight: bold;
            
        }

        section dl dd.join_list{
            height: 40px;
            border-bottom: 1px solid #999;
            
        }
        section input{
        	border: none;
        }

        section input.user_input{
            width: 100%;
            height: 40px;
            margin-bottom: 15px;
        }

        .btn{
	        width:100%;
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

        .result_area {
            margin-bottom: 20px;
        }

        #find_id {
            padding: 40px 0;
            background-color: rgb(240, 240, 240);
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

                <h2 class="text_1">지페어 코리아 개인회원 아이디찾기</h2>

            </div>

            <section>


                
                <dl class="result_area">
                    <dt class="join_title">아이디 결과</dt>
                    <dt class="text_1" id="find_id"><strong>아이디 :&nbsp;&nbsp;&nbsp;&nbsp;</strong>${id}</dt>
                </dl>

                
                <button class="btn" type="button" id="login_button" >로그인</button>
                


            </section>

        </div>

        
    </div>
    
</body>
</html>