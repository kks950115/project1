<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>


<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정보입력</title>
    <link rel="stylesheet" href="/resources/css/common.css">

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/top.js"></script>
    
    <script>           	    
        /* 입력 이메일 형식 유효성 검사 */
        function mailFormCheck(email){
            var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
            
            return form.test(email);
        }//mailFormCheck
    </script>

	<script>
	
        var auth = 'fail';
	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample4_postcode').value = data.zonecode;
	                document.getElementById("sample4_roadAddress").value = roadAddr;
	                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr !== ''){
	                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("sample4_extraAddress").value = '';
	                }
	
	                var guideTextBox = document.getElementById("guide");
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';
	
	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                }
	            }
	        }).open();
	    }

    

    //* 유효성 검사 통과 유무 변수 *//
    var memberId = false;
    var memberIdChk = false;
    var pwChk = false;
    var pwReChk = false;
    var pwSameChk = false;
   	var memberNameChk = false;
   	var phoneChk = false;
   	var emailChk = false;
   	var emailNumChk = false;
   	var addressChk = false;
    var code = "";						 //이메일 전송 인증번호를 저장하기 위함
   	
   	
   	$(function(){
		
    	//id 중복 검사
        $('#id_input').on("propertychange change keyup paste input", function(){
        
            var id = $('#id_input').val();			//#id_input에 입력되는 값
            var memberData = {memberid : id}		//컨트롤러에 넘길 데이터 이름 : 데이터(#id_input에 입력된 값)
      
            
            $.ajax({
                url:"/member/memberIdChk",
                type:'post',
                data : memberData,
                success : function(result){
                    
                    if(result != 'fail'){
                        $('.possible_id').css("display","inline-block");
                        $('.begin_id').css("display","none");
                        $('.warning').css("display","none");
                        id = true;
                    }else{
                        $('.begin_id').css("display","inline-block");
                        $('.possible_id').css("display","none");
                        $('.warning').css("display","none");
                        id = false;
                    };//if-else
                }
            });//ajax
        });//on
        
        //연락처 중복 검사
        $('#phone_input').on("propertychange change keyup paste input", function(){
        	
        	$.ajax({
        		url:"/member/phoneChk",
        		type:"post",
        		data: { phone : $('#phone_input').val() },
        		success : function(result){
        			
        			if(result != 'fail'){
        				$('.phone_chk').css('display','none');
        			}else{
        				$('.phone_chk').css('display','block');
        			}//if-else
        		}//function
        			        			
        	})//ajax
        });//function
        
        /*비밀번호 확인 일치 유효성 검사*/
        $('#pwChk_input').on("propertychange change keyup paste input", function(){
        	var pw = $('#pw_input').val();
        	var pwck = $('#pwChk_input').val();
        	$('.final_pwck_chk').css('display','none');
        	
        	if(pw==pwck){
                $('.pwck_input_re_1').css('display','block');
                $('.pwck_input_re_2').css('display','none');
                pwckcorCheck = true;
            }else{
                $('.pwck_input_re_1').css('display','none');
                $('.pwck_input_re_2').css('display','block');
                pwckcorCheck = false;
            }        
        });
        
        //메일 중복 가입 체크 후 발송
        var checkBox = $("#email_authKey");  //인증번호 입력 값
        var emailMsg = $(".email_chk");
        
        $("#mail_button,#reMail_button").click(function(){
           	var email = $("#email_input").val(); //입력한 이메일 값	
        	stopTimer();
			
        	console.log(email);
        	console.log(checkBox);
        	console.log(emailMsg);
        	
        	if($('#email_input').val() == "" && $('#email_input').val().length == 0 ){
				emailMsg.html("이메일을 입력 해주세요.");
				emailMsg.css('display','block'); 

            }else if(mailFormCheck(email)==true){
				$.ajax({
					url:"/member/emailChk",
					type: 'post',
					data: { "email" : email},
					success:function(result){
						if(result == "success"){
							$('#mail_certified').show();
							$('#btnBox_certified').show();
							$('#btnBox_mail').hide();
							
							$.ajax({
								url:"/member/send",
								type: 'POST',
								data: { "email" : email },
								success:function(){
									alert('입력하신 이메일로 인증번호가 발송되었습니다.');
									code = email;
									
									timer();
								}//success
							})//ajax
						}else {
							alert("이미 가입 된 이메일입니다.");
						}//if-else
						
					}//success
				})//ajax
            }else if(mailFormCheck(email)==false){
                emailMsg.html("이메일 형식이 올바르지 않습니다. 예)xxx@xxx.xxx");
                emailMsg.css('display','block');
            }//if-else
           	   
            	

	});//function
            	


        
        $('#before_button').on('click',function(){
        	
        	history.back();
        })

        $("#join_button").click(function(e){
             var id = $('#id_input').val();					//id 입력란
             var pw = $('#pw_input').val();					//pw 입력란
             var pwChk = $('#pwChk_input').val();			//pw 재입력란
             var name = $('#name_input').val();				//이름 입력란
             var phone = $('#phone_input').val();			//폰 입력란
             var address = $('sample4_roadAddress');		//주소 입력란
             var mail = $('#email_input').val();			//이메일 입력란
             
     	     var idj = /^[a-z]+[a-z0-9]{5,11}$/g;
    		 var pwj = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,12}$/;
    		 var namej = /^[가-힣]{2,4}$/; 
    	  	 var phonej =  /^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}$/

             /*아이디 유효성 검사*/
             if(id == "" && id.length == 0){
            	 
			 }else if(!idj.test(id)){
     			alert('아이디는 영문+숫자6~12자로 작성');
    		

     			 memberId = false;
             }else{
                 memberId = true;
             }//if-else
             	
             /*비밀번호 유효성 검사*/
             if(pw == "" && pw.length == 0){
             	

              	
             }else if(!pwj.test(pw)){

      			 alert('비밀번호 영문+숫자+특수문자를 포함하여 6~12자로 작성');
            	 pwChk = false;
             }
             else{
             	pwChk = true;
             }//if-else
             
             /*비밀번호 확인 유효성 검사*/
             if(pwChk == "" && pwChk.length == 0 ){
             	pwReChk = false;
             }else{
             	pwReChk = true;
             }//if-else
             
             /*이름 확인 유효성 검사*/
             if(name == "" && name.length == 0){
             	
             	
             }else if(!namej.test(name)){
            	 alert('이름은 2~4자로 작성 해주세요');
            	 memberNameChk = false;
             }
             
             else{
             	memberNameChk = true;
             }
             
             /*전화번호 확인 유효성 검사*/
             if(phone =="" && phone.length == 0){
             	
             }else if(!phonej.test(phone)){
            	alert('연락처는 공백 없이 -을 포함하여 작성 해주세요');
            	 
            	phoneChk = false;
             }
            	 
             
             else{
             	phoneChk = true;
             }
             
             /*이메일 유효성 검사*/
             if(mail == "" && mail.length == 0 ){
             	emailChk = false;
             }else{
             	emailChk = true;
             }//if-else
             	
             /*주소 유효성 검사*/
             if(address == ""){
             	addressChk = false;
             }else{
             	addressChk = true;
             }//if-else
             	
            	//==================================================
             
     		/*아이디 유효성 검사*/
             if(id == ""){
                 $('.final_id_chk').css('display','block');
             }else{
                 $('.final_id_chk').css('display','none');
                 
             }//if-else
             	
             /*비밀번호 유효성 검사*/
             if(pw == ""){
             	$('.final_pw_chk').css('display','block');               	
             }else{
             	$('.final_pw_chk').css('display','none');
             	
             }//if-else
             
             /*비밀번호 확인 유효성 검사*/
             if(pwChk == ""){
             	$('.final_pwck_chk').css('display','block');
             }else{
             	$('.final_pwck_chk').css('display','none');
             	
             }//if-else
             
             /*이름 확인 유효성 검사*/
             if(name == "" || $('#name_input').val().length == 0){   	
             	$(".final_name_chk").css('display','block');
             }else{
             	$(".final_name_chk").css('display','none');
             }
             
             /*전화번호 확인 유효성 검사*/
             if(phone ==""){
             	$(".final_phone_chk").css('display','block');
             }else{
             	$(".final_phone_chk").css('display','none');
             }
             
             /*이메일 유효성 검사*/
             if(mail == ""){
             	$('.final_email_chk').css('display','block');
             	
             }else{
             	$('.final_email_chk').css('display','none');
             	
             }//if-else
             	
             /*주소 유효성 검사*/
             if(address == ""){
             	console.log("address");
             	$('.final_address_chk').css('display','block');
             	
             }else{
             	$('.final_address_chk').css('display','none');
             	
             }//if-else
            	 
             if((memberId && pwChk && pwReChk && memberNameChk && phoneChk && addressChk && emailChk) == false){
             	e.preventDefault();
             }
 			
	         if(auth != 'success'){
        		e.preventDefault();
             	alert('인증번호가 틀렸습니다.');
	         }
         });//click
        
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
        


    });// function 종료

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
        #wrap{
            width: 100%;
            height: 1450px;
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
            padding: 0 20%;
            font-size: 20px;
            font-weight: bold;
        }
        
        section{
            margin: 0 auto;
            padding: 50px;
            
        }
        
        .possible_id{
            color: green;
            display: none;
        }
		.begin_id{
            color: red;
            display: none;
		}
        .warning{
            font-size: 12px;
            color: red;
        }
        
        .phone_chk{
        	color: red;
            display: none;
        }
        
        .email_chk{
        	color:red;
        	display:none;
        }

        .final_id_chk{
            display: none;
            color: purple;
        }

        .final_pw_chk{
            display: none;
            color: purple;
        }
        .final_pwck_chk{
            display: none;
            color: purple;
        }
        .final_name_chk{
            display: none;
            color: purple;
        }
        .final_phone_chk{
            display: none;
            color: purple;
        }
        
        .final_email_chk{
            display: none;
            color: purple;
        }
        
        .final_address_chk{
        	display: none;
        	color: purple;
        }

        
        .pwck_input_re_1{
        	color:green;
        	display:none;
        }
        .pwck_input_re_2{
        	color:red;
        	display:none;
        }
        
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

        section #id_input{


        }
        
        
        
        #mail_button{
            width: 98%;
        }
        
        #sample4_postcode{
           width: 30%;
           height:40px;
           border: 1px solid #999;
           margin-bottom : 5px;
           padding-left:5px;
        }
        
        
        #sample4_postSearch{
           padding: 12px;
           background-color: #005bbb;
           cursor: pointer;
           color: #fff;
        }

        
        #sample4_roadAddress{
           width: 100%;
           height:40px;
           border: 1px solid #999;
           margin-bottom : 5px;
           padding-left:5px;
      }
      
      #sample4_jibunAddress{
           width: 100%;
           height:40px;
           border: 1px solid #999;
           margin-bottom : 5px;
           padding-left:5px;
      }
      
      #sample4_detailAddress{
           width: 100%;
           height:40px;
           border: 1px solid #999;
           margin-bottom : 5px;
           padding-left:5px;
      }
      
      #sample4_extraAddress{
           width: 100%;      
           height:40px;
           border: 1px solid #999;
           margin-bottom : 5px;
           padding-left:5px;
      }
        
        

       .btn{
	        width:48%;
		    background-color: #005bbb;
            height: 50px;
            text-align: center;
		    color:#fff;
            border: none;
		    padding: 15px 0;	
		    text-decoration: none;
		    display: inline-block;
		    margin: 4px;
		    cursor: pointer;

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


        
        #mail_certified{
            display: none;
        }
        
        #btnBox_certified{
            display: none;
        }

        #btnBox_mail{
            
        }


        #btnBox_agreement{

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
                    <li><img src="/resources/img/on_process_3.png" alt="">정보입력</li>
                    <li><img src="/resources/img/process_4.png" alt="">가입완료</li>
                </ul>
            </div>

            <div class="guideText">
            <h2>회원가입을 위한 필수 정보 입력 단계 입니다.</h2>
            </div>

            <section>
                <form action="/member/join_p" method="post">
                    <dl>
                        <dt class="join_title">아이디</dt>
                        <dd class="join_list"><input type="text" class="user_input" name="memberid" id="id_input" placeholder="아이디를 입력해주세요."></dd>
                    </dl>
                    <span class="possible_id">사용 가능한 아이디입니다.</span>
                    <span class="begin_id">이미 존재하는 아이디입니다.</span>
                    <span class="warning">영문,숫자 또는 영문숫자조합 6~12자리</span>
                    <span class="final_id_chk">아이디를 입력해주세요.</span>
                    <dl>
                        <dt class="join_title">비밀번호</dt>
                        <dd class="join_list"><input type="password" class="user_input" name="memberpw" id="pw_input" autocomplete="off" placeholder="비밀번호를 입력해주세요." required></dd>

                        <dd class="join_list"><input type="password" class="user_input" id="pwChk_input" autocomplete="off" placeholder="비밀번호를 재입력해주세요." required></dd>
                        <span class="final_pw_chk">비밀번호를 입력해주세요.</span>
                        <span class="final_pwck_chk">비밀번호확인을 입력해주세요.</span>
                        <span class="pwck_input_re_1">비밀번호가 일치합니다.</span>
                        <span class="pwck_input_re_2">비밀번호가 일치하지 않습니다.</span>
                    </dl>

                    <dl>
                        <dt class="join_title">성명</dt>
                        <dd class="join_list"><input type="text" class="user_input" name="membername" id="name_input" placeholder="성명을 입력해주세요." required></dd>
                        <span class="final_name_chk">이름을 입력해 주세요.</span>
                    </dl>

                    <dl>
                        <dt class="join_title">휴대폰</dt>
                        <dd class="join_list"><input type="text" class="user_input" name="phone" id="phone_input" placeholder="- 를 포함하여 휴대폰 번호를 입력해주세요." required></dd>
                        <span class="phone_chk">이미 가입된 연락처입니다.</span>
                        <span class="final_phone_chk">연락처를 입력해 주세요.</span>
                    </dl>
                    
                    	<p class="join_title">주소</p>
						<input type="text" id="sample4_postcode" placeholder="우편번호">
						<input type="button" id="sample4_postSearch" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="sample4_roadAddress" name="memberaddress" placeholder="도로명주소">
						<input type="text" id="sample4_jibunAddress" placeholder="지번주소">
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="sample4_detailAddress" name="memberaddress" placeholder="상세주소">
						<input type="text" id="sample4_extraAddress" name="memberaddress" placeholder="참고항목" required>
						<span class="final_address_chk">주소를 입력해 주세요.</span>
                    <dl>
                        <dt class="join_title">이메일</dt>
                        <dd class="join_list"><input type="email" name="email" class="user_input" id="email_input" placeholder="이메일을 입력해주세요." required></dd>
                        <span class="final_email_chk">메일을 입력해 주세요.</span>
                        <span class="email_chk"></span>
                        
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
	                    <button class="btn" type="submit" id="join_button">가입완료</button>
	                </div>
                </form>

            </section>
        </div>
        <span id="top_btn">top</span>
    </div>
    
</body>
</html>