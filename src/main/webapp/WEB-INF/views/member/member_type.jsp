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

    $(function() {

        $('#before_button').on('click', function(){
            location.href="/member/agreement";
        });

    }); //end JQ
    
    </script>


    <style>
    	body {
    		background-color: #eff2f4;
    	}
    	    
		#wrap{
            width: 100%;
            height: 900px;
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
            text-align: center;
            margin-top: 50px;
            padding: 0 20%;
            font-size: 20px;
            font-weight: bold;
        }
        
        section{
            margin: 0 auto;
            padding: 50px;
            position: relative;
        }

        section ul{
            margin: 0 auto;

        }

        section li.member_choice{
            width: 100%;
            height: 80px;
            border: 1px solid #ddd;
            background-color: #f5f7fa;
            padding-top: 20px;
        }
        section li.member_choice a{
            display: block;
            width: 100%;
            height: 80px;

        }

        .memberIcon1{
            width: 48px;
            height: 48px;
            background-image: url(/resources/img/member.png);
            background-repeat: no-repeat;
            margin-left: 15px;
            float: left;
        }

        .memberIcon2{
            width: 48px;
            height: 48px;
            background-image: url(/resources/img/company.png);
            background-repeat: no-repeat;
            margin-left: 15px;
            float: left;
        }

        .memberType{
            font-size: 20px;
            font-weight: bold;
            padding-left: 50px;
            float: left;
            padding-top: 20px;
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

        .btn_area {
        	margin-top: 40px;
            text-align: center;
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
                    <li><img src="/resources/img/on_process_2.png" alt="">가입유형</li>
                    <li><img src="/resources/img/process_3.png" alt="">정보입력</li>
                    <li><img src="/resources/img/process_4.png" alt="">가입완료</li>
                </ul>
            </div>

            <div class="guideText">
                <h2>해당하는 유형을 선택하여<br>회원 가입을 진행하여 주세요</h2>
            </div>

            <section>
                <ul>
                    <li class="member_choice"><a href="/member/join_p"><div class="memberIcon1"></div><div class="memberType">개인회원 ( 일반정보 )</div></a></li>
                    <li class="member_choice"><a href="/member/checkCBNO"><div class="memberIcon2"></div><div class="memberType">기업회원 (전시회 참가 및 일반 정보)</div></a></li>

                </ul>
                    
                <p class="btn_area" id="btn_area">
                    <span><input type="button" value="이전" class="btn" id="before_button"/></span>
                </p>
            </section>
            
        </div>

        
    </div>
    
</body>
</html>