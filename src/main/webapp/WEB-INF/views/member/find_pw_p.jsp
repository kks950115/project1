<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
<link rel="stylesheet" href="/resources/css/common.css">

</head>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>


<script>
    
    $(function() {

        $('#memberid').keyup(function() {
            if($('#memberid').val() == "") {
                $('.id_error').show();
                $('.id_error').css('color','red');
                $('.id_error').text('아이디를 입력해주세요.');
                $('#memberid').focus();
            } else {
                $('.id_error').text('');
                $('.id_error').css('display','none');
            }
        });

        $('#email').keyup(function() {
            if(isEmail($('#email').val()) == false) {
                $('.email_error').show();
                $('.email_error').css('color','red');
                $('.email_error').text('올바른 이메일 형식을 입력해주세요.');
                $('#email').focus();
            } else {
                $('.email_error').text('');
                $('.email_error').css('display','none');
            }
        })

        //찾기버튼 눌렀을때
        $('#signup_btn').on('click', function(e){

            if($('#memberid').val() == "") {
                $('.id_error').show();
                $('.id_error').css('color','red');
                $('.id_error').text('아이디를 입력해주세요.');
                $('#memberid').focus();
            	e.preventDefault();
            }

            if(isEmail($('#email').val()) == false) {
                $('.email_error').show();
                $('.email_error').css('color','red');
                $('.email_error').text('이메일을 입력해주세요.');
                $('#email').focus();
                e.preventDefault();
            } 
            
            if($('#memberid').val() == "" && isEmail($('#email').val()) == false) {
                $('#memberid').focus();
                e.preventDefault();
            } else {
                $.ajax({
                    url: '/member/find_pw_p',
                    type:'post',
                    data: {'memberid':$('#memberid').val(), 'email':$('#email').val()},
                    success: function(result){
                        if(result == 'success') {
                            console.log("!!!!!!!!!!!!!!!!!!!!!"+result);
                            $.ajax({
                                url: '/member/sendMailPw',
                                type: 'post',
                                data: {'email':$('#email').val(), 'memberid':$('#memberid').val()},
                                success: function(value) {
                                	console.log("&&&&&&&&&&&&&&&&&"+value);

                                    if(value == "success"){
                                        alert('가입된 이메일로 임시비밀번호를 발송했습니다.');	
                                        location.href="/";
                                    }else{
                                    	alert('이메일 발송 실패했습니다.');
                                    }
                                }
                            })
                        } else {
                            alert('일치하는 정보가 없습니다.');
                        }
                    }
                }) // end ajax
            }//if-else

            
            
        });//onClick


        $('#before_button').on('click',function() {
                location.href = "/member/find_type";
        });
    

    }); //end jq

    function isEmail(value){
        var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-0-9a-zA-Z]([-_\.]?[0-0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
        return regExp.test(value);
    }//이메일 정규식 체크


</script>

<style>
   	body {
   		background-color: #eff2f4;
   	}
   	
    #wrap{
        width: 100%;
        height: 850px;
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
        margin: 0 auto;
        padding-top: 50px;
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
    .id_error {
        display: none;
    }
    .cbno_error {
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

    .change_btn {
        display: block;
        height: 100%;
    }

    #this_btn {
        border-bottom: solid 2px #005bbb;
        font-weight: bold;
        color: #005bbb;
    }
    
    #btnBox_agreement {
        margin-top: 20px;
    }


</style>


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
                    <li><a class="change_btn" href="/member/find_id_p">아이디찾기</a></li>
                    <li><a class="change_btn" id="this_btn">비밀번호찾기</a></li>
                </ul>
            </div>



            <div class="guideText">

                <h2 class="text_1">G-FAIR KOREA<br>개인회원 비밀번호찾기</h2>

            </div>

            <section>
            
                <dl>
                    <dt class="join_title">개인아이디</dt>
                    <dd class="join_list"><input type="text" class="user_input" id="memberid" name="memberid" placeholder="아이디를 입력해주세요."></dd>
                    <span class="id_error"></span>
                </dl>

                <dl>
                    <dt class="join_title">이메일</dt>
                    <dd class="join_list"><input type="email" class="user_input" id="email" name="email" placeholder="이메일을 입력해주세요."></dd>
                    <span class="email_error"></span>
                </dl>

                <div id="btnBox_agreement">
                    <button class="btn" type="button" id="before_button" >이전 화면</button>
                    <button class="btn" type="button" id="signup_btn">확인</button>
                </div>
            </section>

        </div>

        
    </div>


</body>
</html>