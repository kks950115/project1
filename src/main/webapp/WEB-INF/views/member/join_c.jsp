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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>


        var emailCheck = 'fail';
        var idCheck = 'fail';
        var phoneCheck = 'fail';
        //@@@@
        var captchaCheck = 'ok';

        $(function() {
            //@@@@
            //captchaImg();
            $('#captcha_img').attr('src', '/resources/captcha/2021-10-03/1633256179871.jpg');

            var idRule = /^[a-z]+[a-z0-9]{5,11}$/;
            $('#memberid').on("propertychange change keyup paste input", function(){
                if(idRule.test($('#memberid').val()) == false){
                    idCheck = 'fail';
                    $('.id_error').show();
                    $('.id_error').css('color','red');
                    $('.id_error').text('아이디는 영문(소문자) 혹은 영문+숫자 조합 6~12자로 구성하여야 합니다.');
                } else {
                    
                	if($('#memberid').val().length > 12) {
                		idCheck = 'fail';
                		$('.id_error').css('color','red');                	
                		$('.id_error').text('아이디는 영문(소문자) 혹은 영문+숫자 조합 6~12자로 구성하여야 합니다.');
                	} else {
                    	$.ajax({
                            url: '/member/checkID',
                            type: 'POST',
                            data: {'memberid':$('#memberid').val()},
                            success: function(result) {                    
                                console.log(result);
                                if(result == 'ok'){ //가입가능하면 
                                    idCheck = result;
                                    $('.id_error').show();
                                    $('.id_error').css('color','green');
                                    $('.id_error').text('사용 가능한 아이디입니다.');
                                } else {
                                	idCheck = 'fail';
                                    $('.id_error').show();
                                    $('.id_error').css('color','red');
                                    $('.id_error').text('이미 사용중인 아이디입니다.');
                                }
                            }//success
                        });//end ajax                 		
                	}//if-else

                }//if-else

            });//on Event
            
            var phoneRule = /^0[0-9]{1,2}-[^0][0-9]{2,3}-[0-9]{3,4}$/;
            $('#phone').on("propertychange change keyup paste input", function(){
                if(phoneRule.test($('#phone').val()) == false){
                    phoneCheck = 'fail';
                    $('.phone_error').show();
                    $('.phone_error').css('color','red');
                    $('.phone_error').text('올바른 연락처를 입력해주세요.');
                } else {
                    $.ajax({
                        url: '/member/checkPhone',
                        type: 'POST',
                        data: {'phone':$('#phone').val()},
                        success: function(result) {                    
                            console.log(result);
                            if(result == 'ok'){ //가입가능하면 
                                phoneCheck = result;
                                $('.phone_error').show();
                                $('.phone_error').css('color','green');
                                $('.phone_error').text('사용 가능한 연락처입니다.');
                            } else {
                                phoneCheck = 'fail';
                                $('.phone_error').show();
                                $('.phone_error').css('color','red');
                                $('.phone_error').text('이미 사용중인 연락처입니다.');
                            }
                        }//success
                    });//end ajax 
                }//if-else

            });//on Event



            $('.email_error').css('display','none');
            $('#mail_button, #reMail_button').on('click', function(){

                stopTimer();

                var isEmailOK = isEmail($('#email').val());
                if(isEmailOK == true) {
                    $('.email_error').text('');
                    $('.email_error').css('display','none');

                    $('#mail_certified').show();
                    $('#btnBox_certified').show();
                    $('#btnBox_mail').hide();

                    $.ajax({
                        url: '/member/isExistEmail',
                        type: 'post',
                        data: {'email':$('#email').val()},
                        success: function(result){
                            if(result == 'ok') {
                                $('.email_error').show();
                                $('.email_error').css('color','red');
                                $('.email_error').text('사용할 수 없는 이메일입니다.');
                            } else {
                                $('.email_error').text('');
                                $('.email_error').css('display','none');
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
			
		    });//onClick



            $('#captchaRefresh').on('click',function(){
        	    //@@@@
            	//captchaImg();
            });

            
            $('#checkCaptcha').on('click', function(){
                //@@@@
            	//captcha();
            	alert('인증 성공');
            });

            $('#before_button').on('click', function(){
                location.href="/member/checkCBNO";
            });


        });//end JQ


        function captchaImg() {
            $.ajax({
                url: '/member/captchaImg',
                type: 'post',
                success: function(result) {
                    setTimeout(function() {
                        $('#captcha_img').attr('src', result);
                    }, 5000);
                }
            });

        }

        function captcha() {
            $.ajax({
                url: '/member/captcha',
                type: 'post',
                data: {'captcha':$('#captcha').val()},
                success: function(result) {
                    console.log(result);
                    if(result == 'ok') {
                    	captchaCheck = result;
                        alert('인증 성공');
                    } else {
                        alert('fail');
                        captchaImg();
                    }
                    
                }

            });
        }


        function isEmail(value){
            var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-0-9a-zA-Z]([-_\.]?[0-0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
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





        //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if(data.userSelectedType === 'R'){
                        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있고, 공동주택일 경우 추가한다.
                        if(data.buildingName !== '' && data.apartment === 'Y'){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if(extraAddr !== ''){
                            extraAddr = ' (' + extraAddr + ')';
                        }
                        // 조합된 참고항목을 해당 필드에 넣는다.
                        //document.getElementById("extraAddress").value = extraAddr;
                    
                    } else {
                        //document.getElementById("extraAddress").value = '';
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address").value = addr + extraAddr;
                    
                    document.getElementById("memberaddress").value = data.zonecode + " " + addr + extraAddr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("detailAddress").focus();
                }
            }).open();

        }

   	
        $(function(){

            $('#file').change(function(){
                if($('#file').val() == ""){
                    $('.file_error').show();
                    $('.file_error').css('color','red');
                    $('.file_error').text('파일을 첨부해주세요.');
                } 

                else if($('#file').val() != "") {
                    //============파일 확장자 검사==================//
                    var ext = $('#file').val().split('.').pop().toLowerCase(); //파일 확장자만 추출해서 ext 변수에 저장 
                    if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1 ) {
                        alert('gif / png / jpg / jpeg 파일만 업로드 가능합니다.');
                        $('#file').val('');
                        return false;
                    }

                    //=========================================//
                    
                    //============파일 용량 검사==================//
                    var maxSize = 2 * 1024 * 1024; // 2 MB
                    var fileSize = $('#file')[0].files[0].size;
                    if(fileSize > maxSize) {
                        alert('첨부파일 업로드는 2MB 이내로 가능합니다.');
                        $('#file').val("");
                        return false;
                    }
                    $('.file_error').text('');
                    $('.file_error').css('display','none');
                }
                
            });


            //===============================================================================//
            
            // $('#memberid').keyup(function(){
            //     if($('#memberid').val().length < 6 || $('#memberid').val().length > 12) {
            //     	$('.id_error').show();
            //     	$('#id_error').css('color','red');
            //         $('#id_error').text('아이디는 6~12자여야 합니다.');
            //     } 
            //     else if(/[^a-z0-9]+|^([a-z]+|[0-9]+)$/.test($('#memberid').val())){
            //             $('.id_error').show();
            //             $('#id_error').css('color','red');
            //             $('#id_error').text('아이디는 영문(소문자),숫자 조합으로 구성하여야 합니다.');
            //     }
            //     else {
            //         $('#id_error').text('');
            //         $('.id_error').css('display','none');
            //     }

            // });//id_error
            //===============================================================================//
            
            $('#memberpw').keyup(function(){
                var pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,12}$/;

                if($('#memberpw').val().length < 6 || $('#memberpw').val().length > 12) {
                    $('.pw1_error').show();
                    $('.pw1_error').css('color','red');
                    $('.pw1_error').text('암호는 6~12자여야 합니다.');
                } 
                else if (!pattern.test($('#memberpw').val())) {
                        $('.pw_error').show();
                        $('.pw1_error').css('color','red');
                        $('.pw1_error').text('암호는 영문/숫자/특수문자를 모두 포함해야 합니다.');
                }
                else {
                    $('.pw1_error').text('');
                    $('.pw_error').css('display','none');
                }

            });//암호유효성검사

            $('#memberpw2').keyup(function(){
                if($('#memberpw').val() != $('#memberpw2').val()){
                    $('.pw2_error').show();
                    $('.pw2_error').css('color','red');
                    $('.pw2_error').text('암호를 확인해주세요.');
                }
                else {
                    $('.pw2_error').text('');
                    $('.pw2_error').css('display','none');
                }
            });//암호확인
            //===============================================================================//
            $('#membername').keyup(function(){
                if($('#membername').val() == "" || $('#membername').val().length == 0) {
                    $('.name_error').show();
                    $('.name_error').css('color','red');
                    $('.name_error').text('기업명을 입력해주세요.');
                }
                else {
                    $('.name_error').text('');
                    $('.name_error').css('display','none');
                }
            });//기업명확인

            //===============================================================================//
            
            // $('#phone').keyup(function(){        
            //     var pattern = /0[0-9]{1,2}-[^0][0-9]{2,3}-[0-9]{3,4}/;
                
            //     if(!pattern.test($('#phone').val())){
            //         $('.phone_error').show();
            //         $('.phone_error').css('color','red');
            //         $('.phone_error').text('올바른 연락처를 입력해주세요.');
            //     }
            //     else {
            //         $('.phone_error').text('');
            //         $('.phone_error').css('display','none');
            //     }

            // });//연락처확인
            //===============================================================================//
            
            $('#detailAddress').keyup(function(){
                if($('#detailAddress').val() == "" || $('#detailAddress').val().length == 0) {               
                    $('.address_error').show();
                    $('.address_error').css('color','red');
                    $('.address_error').text('상세주소를 입력해주세요.');    
                } 
                else {
                    $('.address_error').text('');    
                    $('.address_error').css('display','none');
                }
            });

            //===============================================================================//

            $('#captcha').keyup(function(){
                if($('#captcha').val() == "" || $('#captcha').val().length == 0) {
                    $('.captcha_error').show();
                    $('.captcha_error').css('color','red');
                    $('.captcha_error').text('올바른 인증코드를 입력해주세요.');  
                } else {
                    $('.captcha_error').text('');  
                    $('.captcha_error').css('display','none');
                }
            });








            //===============================================================================//
            //====================      가입하기 버튼 눌렀을때.. 유효성 검사     =====================//
            //===============================================================================//

            $('#signup_btn').on('click', function(e){

                //사업자번호 확인
                if($('#cbno').val() == "") {
                    e.preventDefault();
                    $('.cbno_error').show();
                    $('.cbno_error').css('color','red');
                    $('.cbno_error').text('사업자등록번호 인증을 먼저 수행해주세요.');

                    // alert('사업자등록번호 인증을 먼저 수행해주세요.');
                    // location.href="/member/checkCBNO";
                } else {

                }

                //파일 체크
                if($('#file').val() == ""){
                    e.preventDefault();
                    $('.file_error').show();
                    $('.file_error').css('color','red');
                    $('.file_error').text('파일을 첨부해주세요.');
                    $('#file').focus();
                } 
                else {
                    $('.file_error').text('');
                    $('.file_error').css('display','none');
                }

                //아이디 체크
                if($('#memberid').val().length < 6 || $('#memberid').val().length > 12) {
                    e.preventDefault();
                    $('.id_error').show();
                    $('.id_error').css('color','red');
                    $('.id_error').text('아이디는 6~12자여야 합니다.');
                    $('#memberid').focus();
                }
                else if(/[^a-z0-9]+|^([a-z]+|[0-9]+)$/i.test($('#memberid').val())){
                    e.preventDefault();
                    $('.id_error').show();
                    $('.id_error').css('color','red');
                    $('.id_error').text('아이디는 영문,숫자 조합으로 구성하여야 합니다.');
                    $('#memberid').focus();
                }
                else if(idCheck != 'ok'){
                    e.preventDefault();
                    $('.id_error').show();
                    $('.id_error').css('color','red');
                    $('.id_error').text('사용 불가능한 ID 입니다.');
                    $('#memberid').focus();
                }
                else {
                    $('.id_error').text('');
                    $('.id_error').css('display','none');
                }

                //암호1 체크
                var pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{6,12}$/;
                if($('#memberpw').val().length < 6 || $('#memberpw').val().length > 12) {
                    e.preventDefault();
                    $('.pw1_error').show();
                    $('.pw1_error').css('color','red');
                    $('.pw1_error').text('암호는 6~12자여야 합니다.');
                    $('#memberpw').focus();
                } 
                else if (!pattern.test($('#memberpw').val())) {
                    e.preventDefault();
                    $('.pw1_error').show();
                    $('.pw1_error').css('color','red');
                    $('.pw1_error').text('암호는 영문/숫자/특수문자를 모두 포함해야 합니다.');
                    $('#memberpw').focus();
                }
                else {
                    $('.pw1_error').text('');
                    $('.pw1_error').css('display','none');
                }

                //암호2 체크
                if($('#memberpw').val() != $('#memberpw2').val()){
                    e.preventDefault();
                    $('.pw2_error').show();
                    $('.pw2_error').css('color','red');
                    $('.pw2_error').text('암호를 확인해주세요.');
                    $('#memberpw2').focus();
                }


                //기업명 체크
                if($('#membername').val() == "" || $('#membername').val().length == 0) {
                    e.preventDefault();
                    $('.name_error').show();
                    $('.name_error').css('color','red');
                    $('.name_error').text('기업명을 입력해주세요.');
                    $('#membername').focus();
                }
                else {
                    $('.name_error').text('');
                    $('.name_error').css('display','none');
                }

                //연락처 체크
                var pattern = /^0[0-9]{1,2}-[^0][0-9]{2,3}-[0-9]{3,4}$/;
                // var pattern = /^\d{2,3}-\d{3,4}-\d{4}$/;
                if(!pattern.test($('#phone').val())){
                    e.preventDefault();
                    $('.phone_error').show();
                    $('.phone_error').css('color','red');
                    $('.phone_error').text('올바른 연락처를 입력해주세요.');
                    $('#phone').focus();
                }
                else if(phoneCheck != 'ok'){
                    e.preventDefault();
                    $('.phone_error').show();
                    $('.phone_error').css('color','red');
                    $('.phone_error').text('사용할 수 없는 연락처입니다.');
                    $('#phone').focus();
                }
                else {
                    $('.phone_error').text('');
                    $('.phone_error').css('display','none');
                }
                

                //이메일 체크
                var pattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-0-9a-zA-Z]([-_\.]?[0-0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
                if(!pattern.test($('#email').val())) {
                    e.preventDefault();
                    $('.email_error').show();
                    $('.email_error').css('color','red');
                    $('.email_error').text('올바른 이메일 형식을 입력해주세요.');
                    $('#email').focus();
                } else if(emailCheck != 'ok'){
                    e.preventDefault();
                    $('.email_error').show();
                    $('.email_error').css('color','red');
                    $('.email_error').text('이메일 인증이 필요합니다.');
                    $('#email').focus();
                } else {
                    $('.email_error').css('display','none');
                    $('.email_error').text('');
                }


                //주소 체크
                $('.address_error').css('display','none');
                if( $('#postcode').val() == "" || $('#address').val() == "" ) {
                    e.preventDefault();
                    $('.address_error').show();
                    $('.address_error').css('color','red');
                    $('.address_error').text('주소를 입력해주세요.');
                    $('#postcode').focus();
                }
                else if($('#detailAddress').val() == "" || $('#detailAddress').val().length == 0) {
                    e.preventDefault();
                    $('.address_error').show();
                    $('.address_error').css('color','red');
                    $('.address_error').text('상세주소를 입력해주세요.');  
                    $('#postcode').focus();  
                }
                else {
                    $('.address_error').text('');    
                    $('.address_error').css('display','none');
                    
                    var address = $('#memberaddress').val();
                    var detailAddress = $('#detailAddress').val();
                    $('#memberaddress').val(address + " " + detailAddress);
                }


                
                //캡차 체크
                if($('#captcha').val() == "" || $('#captcha').val().length == 0) {
                    e.preventDefault();
                    $('.captcha_error').show();
                    $('.captcha_error').css('color','red');
                    $('.captcha_error').text('자동등록방지문자 인증이 필요합니다.');  
                    $('#captcha').focus();
                } 
                else if(captchaCheck != 'ok'){
                    e.preventDefault();
                    $('.captcha_error').show();
                    $('.captcha_error').css('color','red');
                    $('.captcha_error').text('자동등록방지문자 인증이 필요합니다.');  
                    $('#captcha').focus();
                }
                else {
                    $('.captcha_error').text('');  
                    $('.captcha_error').css('display','none');
                }
            });



        });// function 종료

    </script>


    <style>
    	body {
    		background-color: #eff2f4;
    	}
    	
        #wrap{
            width: 100%;
            height: 1700px;
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
            margin-bottom: 80px;
        }
        

        /*===== 에러 메시지 =====*/
        .cbno_error {
            display: none;
        }
        
        .file_error{
            display: none;
        }

        .id_error{
            display: none;
        }
        .pw1_error {
            display: none;
        }

        .pw2_error {
            display: none;
        }

        .name_error {
            display: none;
        }

        .phone_error {
            display: none;
        }

        .address_error {
            display: none;
        }

        .captcha_error {
            display: none;
        }

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
        
        #postcode{
           width: 30%;
           height:40px;
           border: 1px solid #999;
           margin-bottom : 5px;
           padding-left:5px;
        }
        
        
        #postSearch{
           padding: 12px;
           border: 1px solid #999;
           background-color: #005bbb;
           cursor: pointer;
           color: #fff;
        }

        
        #address{
           width: 100%;
           height:40px;
           border: 1px solid #999;
           margin-bottom : 5px;
           padding-left:5px;
        }
       #detailAddress{
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
        #captcha_img {
       	    margin-bottom: 15px;
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
                <form action="/member/join_cc" method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="membertype" value="기업">
                    <input type="hidden" name="memberaddress" id="memberaddress">
                    <input type="hidden" name="cbno" value="${param.cbno}">
                    <dl>
                        <dt class="join_title">사업자등록번호</dt>
                        <dd class="join_list"><input type="number" class="user_input" name="cbno" id="cbno" value="${param.cbno}" disabled="true"></dd>
                    </dl>
                    <span class="cbno_error"></span>

                    <dl>
                        <dt class="join_title">사업자등록증 </dt>
                        <dd class="join_list"><input type="file" name="file" id="file"></dd>
                    </dl>
                    <span class="file_error"></span>

                    <dl>
                        <dt class="join_title">아이디</dt>
                        <dd class="join_list"><input type="text" class="user_input" name="memberid" id="memberid" placeholder="아이디를 입력해주세요."></dd>
                    </dl>
                    <span class="id_error"></span>

                    <dl>
                        <dt class="join_title">비밀번호</dt>
                        <dd class="join_list"><input type="password" class="user_input" name="memberpw" id="memberpw" autocomplete="off" placeholder="비밀번호를 입력해주세요."></dd>
                        <span class="pw1_error"></span>

                        <dd class="join_list"><input type="password" class="user_input" name="memberpw2" id="memberpw2" autocomplete="off" placeholder="비밀번호를 재입력해주세요."></dd>
                        <span class="pw2_error"></span>
                        
                    </dl>

                    <dl>
                        <dt class="join_title">기업명</dt>
                        <dd class="join_list"><input type="text" class="user_input" name="membername" id="membername" placeholder="성명을 입력해주세요."></dd>
                        <span class="name_error">이름을 입력해주세요.</span>
                    </dl>

                    <dl>
                        <dt class="join_title">연락처</dt>
                        <dd class="join_list"><input type="tel" class="user_input" name="phone" id="phone" placeholder="- 를 포함한 휴대폰 번호를 입력해주세요."></dd>
                        <span class="phone_error">핸드폰번호를 입력해주세요.</span>
                    </dl>


                    
                    	<p class="join_title">주소</p>
						<input type="text" id="postcode" placeholder="우편번호">
						<input type="button" id="postSearch" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
						<input type="text" id="address" placeholder="주소">
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="detailAddress" placeholder="상세주소">          
						<span class="address_error">상세주소를 입력해주세요.</span>

                    <dl>
                        <dt class="join_title">자동등록방지문자</dt>
                        <img src="" alt="캡차 이미지" id="captcha_img">
                        <dd class="join_list"><input type="text" class="user_input" id="captcha" name="captcha" placeholder="자동등록방지문자"></dd>
                        <span class="captcha_error">자동등록방지문자를 확인해주세요.</span>
                        <dd><input type="button" class="btn" id="captchaRefresh" value="refresh"><input type="button" class="btn" id="checkCaptcha" value="체크"></dd>
                    </dl>

                    <dl>
                        <dt class="join_title">이메일</dt>
                        <dd class="join_list"><input type="email" class="user_input" name="email" id="email" placeholder="이메일을 입력해주세요."></dd>
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
	                    <button class="btn" type="submit" id="signup_btn">가입완료</button>
	                </div>
                </form>

            </section>
        </div>
    </div>
    
</body>
</html>