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
            var emailCheck = 'fail';

            $('.email_error').css('display','none');
            $('#mail_button, #reMail_button').on('click', function(){
    
                stopTimer();
    
                var isEmailOK = isEmail($('#email').val()); //이메일 정규식이 맞으면..
                if(isEmailOK == true) { //이메일 정규식일때 
    
                    $('.email_error').text('');
                    $('.email_error').css('display','none');
    

    
                    $.ajax({
                        url: '/member/isExistEmail',
                        type: 'post',
                        data: {'email':$('#email').val()},
                        success: function(result){
                            if(result == 'ok') {

                                $('#mail_certified').show();
                                $('#btnBox_certified').show();
                                $('#btnBox_mail').hide();

                                $.ajax({
                                    url : "/member/sendMail",
                                    type : "post",
                                    data : {'email':$('#email').val()},
                                    success : function(data){
                                        console.log(data)
                                        alert('메일발송완료');
                                        
                                        startTimer();
                                        
                                    }, error : function() {
                                        alert('메일발송오류');
                                    }//success-error
                                });//ajax
                            } else {
                                $('.email_error').show();
                                $('.email_error').css('color','red');
                                $('.email_error').text('사용할 수 없는 이메일입니다.');
                            }	
                        }
                        
                    })
                    
    
                } else {
                    $('.email_error').show();
                    $('.email_error').css('color','red');
                    $('.email_error').text('올바른 이메일 형식을 입력해주세요.');
                }//if-else
    
    
            });//onclick
            
            
            $('#checkBtn').on('click', function() {
                
                var inputCode = $('#codeCheck').val();
                var userEmail = $('#email').val();
                $.ajax({
                    url : "/member/emailCertification",
                    type : "POST",
                    data : {'inputCode' : inputCode, 'userEmail' : userEmail},
    
                    success : function(result) {
                        console.log("코드체크결과 : " + result);
                        if(result == "ok") {
                            alert('인증완료');
                            emailCheck = result;

                            if(emailCheck = 'ok') {
                                $('#reMail_button').attr('disabled', true);
                            }
    
                            $('.email_error').css('display','none');
                            $('.email_error').text('');
    
                            $('#email').attr('readonly', true);
                            $('#codeCheck').attr('readonly', true);
                            $('#sendBtn').attr('disabled', true);
                            $('#checkBtn').attr('disabled', true);
                            
                            stopTimer();
                            
                        } else {
                            alert('인증실패, 올바른 코드를 입력해주세요.');
                            
                        }//if-else
                    }//success
    
                })//end ajax
                
            });
    
    
            //찾기버튼 눌렀을때
            $('#signup_btn').on('click', function(e){
                
                var pattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-0-9a-zA-Z]([-_\.]?[0-0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
                if(!pattern.test($('#email').val())) {
                    e.preventDefault();
                    $('.email_error').show();
                    $('.email_error').css('color','red');
                    $('.email_error').text('올바른 이메일 형식을 입력해주세요.');
                } else if(emailCheck != 'ok'){
                    e.preventDefault();
                    $('.email_error').show();
                    $('.email_error').css('color','red');
                    $('.email_error').text('이메일 인증이 필요합니다.');
                } else {
                    $('.email_error').css('display','none');
                    $('.email_error').text('');
                }

            });//onClick


            $('#before_button').on('click',function() {
                location.href = "/member/find_type";
            });
    
    
    
    
    
        }); //end jq
    
        function isEmail(value){
            var regExp = /^[0-9a-zA-Z-_\.]*@[0-0-9a-zA-Z]([-_\.]?[0-0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
            return regExp.test(value);
        }//이메일 정규식 체크
    
    
        var mytimer;
        function startTimer() {
    
            $('#codeCheck').attr('disabled', false);
            $('#checkBtn').attr('disabled', false);

            count = 600;
            mytimer = setInterval(function() {
                timer();
            }, 1000);
        }
        function stopTimer() {
            clearInterval(mytimer);
    
            var inputCode = $('#codeCheck').val();
            var userEmail = $('#email').val();
            $.ajax({
                url: "/member/removeSession",
                type: "POST",
                data : {'inputCode' : inputCode, 'userEmail' : userEmail},
                success: function(result) {
                    console.log(result);
                    if(result == "ok"){
                        $('#codeCheck').attr('disabled', true);
                        $('#checkBtn').attr('disabled', true);
                        
                    }
                }
            })//ajax
    
        }
        //var count = 20;
        
        function timer() {
            count--;
    
            if(count <= 0) {
                //clearInterval(counter);
                stopTimer();
    
                document.getElementById('timer').innerHTML = "0:00";
                
                return;
            }
            var min = Math.floor(count/60);
            var sec = count - (min*60);
            if(sec < 10){
                sec = "0" + sec;
            }
            document.getElementById("timer").innerHTML = min + ":" + sec;
    
        }
    
    
    
    
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
        .email_error {
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


        #mail_button{
            width: 98%;
        }
        
        .btn{
	        width:48%;
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

        #codeCheck{
            width: 70%;
            height: 50px;
            border-bottom: 1px solid #999;
        }
        
        #mail_certified{
            display: none;
        }
        
        #btnBox_certified{
            display: none;
        }


        #timer{
            background-color: #fff;
            display: inline-flex;
            height: 50px;
            width: 29%;
            font-size: 14px;
            color:red;
            justify-content: center;
            align-items: center;
            border-bottom:1px solid #999;
        }

        .change_btn {
            display: block;
            height: 100%;
        }

        #this_btn {
            border-bottom: solid 2px #005bbb;
            font-weight: bold;
            color: #005bbb;
        }
        
        #btnBox_mail {
            margin-top: 20px;
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
                    <li><a class="change_btn" id="this_btn">아이디찾기</a></li>
                    <li><a class="change_btn" href="/member/find_pw_c">비밀번호찾기</a></li>
                </ul>
            </div>



            <div class="guideText">

                <h2 class="text_1">G-FAIR KOREA<br>기업회원 아이디찾기</h2>

            </div>

            <section>

                <form action="/member/find_id_c" method="POST">
                
                    <dl>
                        <dt class="join_title">이메일</dt>
                        <dd class="join_list"><input type="email" class="user_input" id="email" name="email" placeholder="이메일을 입력해주세요."></dd>
                        <span class="email_error"></span>
                    </dl>

                    <div id="mail_certified">
                        <input type="text" id="codeCheck" name="codeCheck" placeholder="인증번호를 입력해주세요."> 
                        <span id="timer"></span>
                    </div>

                
	                <div id="btnBox_certified">
	                <button class="btn" type="button" id="checkBtn">인증 확인</button>
	                <button class="btn" type="button" id="reMail_button">인증메일 재발송</button>
	                </div>
	
	                <div id="btnBox_mail">
	                    <button class="btn" type="button" id="mail_button">인증메일 발송</button>
	                </div>


                    <div id="btnBox_areement">
	                    <button class="btn" type="button" id="before_button" >이전 화면</button>
	                    <button class="btn" type="submit" id="signup_btn">확인</button>
	                </div>
                    
                </form>

            </section>

        </div>

        
    </div>
    
</body>
</html>