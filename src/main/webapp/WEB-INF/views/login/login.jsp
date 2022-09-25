<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>


<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="/resources/css/common.css">
    
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    
    <script>
        
        $(function(){

            $('#memberid').keyup(function(){
                if($('#memberid').val() == "" && $('#memberid').val().length == 0) {
                    $('.id_error').show();
                    $('.id_error').css('color', 'red');
                    $('.id_error').text('아이디를 입력해주세요.');
                } else {
                    $('.id_error').text('');
                    $('.id_error').css('display', 'none');
                }
            });

            $('#memberpw').keyup(function(){
                if($('#memberpw').val() == "" || $('#memberpw').val().length == 0) {
                    $('.pw_error').show();
                    $('.pw_error').css('color', 'red');
                    $('.pw_error').text('비밀번호를 입력해주세요.');
                } else {
                    $('.pw_error').text('');
                    $('.pw_error').css('display', 'none');
                }  
            });



            $('#loginPage_button').on('click', function(e) {

                if($('#memberid').val() == "" || $('#memberid').val().length == 0) {
                    e.preventDefault();
                    $('.id_error').show();
                    $('.id_error').css('color', 'red');
                    $('.id_error').text('아이디를 입력해주세요.');
                    $('#memberid').focus();
                } else {
                    $('.id_error').text('');
                    $('.id_error').css('display', 'none');
                }

                if($('#memberpw').val() == "" || $('#memberpw').val().length == 0) {
                    e.preventDefault();
                    $('.pw_error').show();
                    $('.pw_error').css('color', 'red');
                    $('.pw_error').text('비밀번호를 입력해주세요.');
                    $('#memberpw').focus();
                } else {
                    $('.pw_error').text('');
                    $('.pw_error').css('display', 'none');
                }   

                if(($('#memberid').val() == "" || $('#memberid').val().length == 0) && ($('#memberpw').val() == "" || $('#memberpw').val().length == 0)) {
                    $('#memberid').focus();
                } else {

                }
                
            })
            

        })
    
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
            padding-top: 50px;
            
            margin: 0 auto;
        }
        #container .step ul {
            width: 550px;
            height: 50px;
            margin: 0 auto;
            border-bottom: solid 1px black;
        }

        #container .step ul li{
            width: 49%;
            height: 50px;
            float: left;
            
            text-align: center;
            font-size: 16px;
            color: #000;

            line-height: 50px;        
            
        }

        #container .guideText{
            margin-top: 25px;
            margin-bottom: 25px;
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

        /*===== 에러 메시지 =====*/
        .id_error {
            display: none;
        }

        .pw_error {
            display: none;
        }
        /*===== 에러 메시지 =====*/

        .join_title{
            margin:10px 0;
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

        #bottom_area {
            float: right;
        }
        .clear {
            clear: both;
        }

        .btnBox {
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .line {
            width: 50%;
            margin: 0 auto;
            border-bottom: solid 1px #999;
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
                
            </div>

            <div class="guideText">
                <div class="text_1"><strong>G-FAIR KOREA</strong>에 방문하신걸 환영합니다.<br>로그인 후 서비스를 이용해주세요.</div>

            </div>
            
            <div class="line"></div>
            
            <section>


                <form action="/login/loginPost" method="POST">       
                    

                    <dl>
                        <dt class="join_title">아이디</dt>
                        <dd class="join_list">
                            <input type="text" class="user_input" id="memberid" name="memberid" placeholder="아이디를 입력해주세요.">
                        </dd>
                        <span class="id_error"></span>
                    </dl>

                    <dl>
                        <dt class="join_title">비밀번호</dt>
                        <dd class="join_list">
                            <input type="password" class="user_input" id="memberpw" name="memberpw" autocomplete="off" placeholder="비밀번호를 입력해주세요.">
                        </dd>
                        <span class="pw_error"></span>
                    </dl>

                    <p></p>
        
                    <div class="btnBox">         
                        <button type="submit" id="loginPage_button" class="btn" >로그인</button>           
                    </div>

                    <div id="bottom_area">
                        <a href="/member/agreement">회원가입</a>
                        &nbsp;&nbsp;
                        <a href="/member/find_type">아이디/비밀번호 찾기</a>
                    </div>
                    <div class="clear"></div>
                </form>


            </section>

        </div>

        
    </div>
    
</body>
</html>