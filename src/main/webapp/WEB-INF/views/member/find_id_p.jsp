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
     /* 입력 이메일 형식 유효성 검사 */
     function mailFormCheck(email){
         var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
         
         return form.test(email);
     }//mailFormCheck
    </script>

    <script>
	$(function(){
		
		$("#mail_button,#reMail_button").click(function(){
           	var email = $("#email_input").val(); //입력한 이메일 값	
           	console.log(email);
        	stopTimer();
			
        	if($('#email_input').val() == "" && $('#email_input').val().length == 0 ){
        		
	     		alert('이메일을 입력해주세요');
            }else{
		           
                if(mailFormCheck(email)){
             	   emailMsg.html("입력하신 이메일로 인증번호가 발송되었습니다.");
             	   emailMsg.css('display','block'); 
             	   
             		$.ajax({
                        url:"/member/emailChk",
                        type: 'post',
                        data: { "email" : $('#email_input').val() },
                        
                        success:function(result){
                            
                            if(result == "fail"){
                	            $('#mail_certified').show();
                	            $('#btnBox_certified').show();
                	            $('#btnBox_mail').hide();
                	            
                                $.ajax({
                                    url:"/member/send",
                                    type: 'POST',
                                    data: { "email" : $('#email_input').val() },
                                    success:function(data){
                                        
                                        alert('입력하신 이메일로 인증번호가 발송되었습니다.');
                                    	code = email;

                                    timer();
                                    }

                                }) //ajax
                            }else{
                            	alert('가입 되지 않은 아이디 입니다.');
                            }
                            //if-else
                            
                        }//fuction
    	            });//ajax
            	
                }else{

             	   emailMsg.html("이메일 형식이 올바르지 않습니다. 예)xxx@xxx.xxx");
             	   emailMsg.css('display','block');
             	   
                }//if-else
            }//if-else
        });//click
		
		var auth = $('#email_authKey');
    	var emailMsg = $(".email_chk");
    	
        $('#mailNumCheck_button').on('click',function(){
       	
       	var authKey = $("#email_authKey").val();
       	var email = $('#email_input').val();
       	var emailMsg = $(".mail_input_warn");
       	
       	console.log('user inputcode : ' + authKey);
       	console.log('user email : ' + email);
       	
    		$.ajax({
    			url: "/member/authKey",
    			type: 'POST',
    			data: { 'authKey': authKey , 'email' : email},
    			success:function(result){
    				console.log('checkresult : ' + auth);
    				if(result == 'success') {
    		               auth = result;
    		               console.log('success result : ' + auth);
    					alert('인증번호가 일치합니다.');
    					stopTimer();
    					
    				} else {
    		       		auth = 'fail';
    		               console.log('fail result : ' + auth);
    					alert('인증번호가 일치하지 않습니다.');
    				}//if-else
    			}//success
    				
    		});//ajax
        });//click
        $("#before_button").on('click',function(){
        	location.href="/member/find_type";
        })

	})//function
	

    </script>
    

    
    <script>
       var myTimer;
    
    function timer() {
	
        const startingMinutes = 10;				// 타이머 분 설정
	    let time = startingMinutes * 60;		// 타이머 분 * 60초
	
	        const countdownEl = document.getElementById('countdown');
	        
	        myTimer = setInterval(updateCountdown, 1000);
	
	        function updateCountdown(){
	        	
	            const minutes = Math.floor(time / 60);
	            let seconds = time % 60;
	
	            seconds = seconds < 10 ? '0' + seconds : seconds;
	
	            countdownEl.innerHTML = minutes + ":" + seconds;
	            if(time == 0){ 
	            	return;
	            }//if
	            time--;	
	            
	        }//updateCountdown
	        

    }//timer   
    
    function stopTimer(){
    	clearInterval(myTimer);
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
        
        #email_authKey{
            width: 70%;
            height: 50px;
            border-bottom: 1px solid #999;
        }
        
        #countdown{
            background-color: #fff;
            display: inline-flex;
            height: 51px;
            width: 29%;
            font-size: 14px;
            color:red;
            justify-content: center;
            align-items: center;
            border-bottom:1px solid #999;
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
                    <li><a class="change_btn" href="/member/find_pw_p">비밀번호찾기</a></li>
                </ul>
            </div>

            <div class="guideText">

                <h2 class="text_1">G-FAIR KOREA<br>개인회원 아이디찾기</h2>

            </div>

            <section>

                <form action="/member/find_id_p_result" method="POST">
                
                    <dl>
                        <dt class="join_title">이메일</dt>
                        <dd class="join_list"><input type="email" class="user_input" id="email_input" name="email" placeholder="이메일을 입력해주세요."></dd>
                        <span class="emailMsg"></span>
                    </dl>

                    <div id="mail_certified">
                        <input type="text" id="email_authKey" name="authKey" placeholder="인증번호를 입력해주세요." required> 
                        <span id="countdown"></span>
                    </div>

                
	                <div id="btnBox_certified">
	                <button class="btn" type="button" id="mailNumCheck_button">인증 확인</button>
	                <span class="emailMsg"></span>
	                <button class="btn" type="button" id="reMail_button">인증메일 재발송</button>
	                </div>
	
	                <div id="btnBox_mail">
	                    <button class="btn " type="button" id="mail_button">인증메일 발송</button>
	                </div>
	
	                
	                <div id="btnBox_areement">
	                    <button class="btn" type="button" id="before_button" >이전 화면</button>
	                    <button class="btn" type="submit" id="join_button">확인</button>
	                </div>
                    
                </form>

            </section>

        </div>

        
    </div>
    
</body>
</html>