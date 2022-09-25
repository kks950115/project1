<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>



<!DOCTYPE html>


<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

        <link rel="stylesheet" href="/resources/css/infoChange.css">

        <script>
            $(function(){

               
                $('#changeCancel').on('click',function(){
                    location.href = "/mypage/checkPass";
                })//changeCancel

                // var numberRegex = /0[0-9]{1,2}-[^0][0-9]{1}[0-9]{2,3}-[^0][0-9]{1}[0-9]{3}$/;//숫자만(연락처)
                var numberRegex = /^\d{2,3}-\d{3,4}-\d{4}/g;
                // var cbnoRegex = /[^0][1-9]{1}[0-9]{9}$/;//숫자만 사업자번호
                var emailRegex = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;//이메일
               
                var changeEmailAddress = '${member.email}';//바뀔 이메일 주소=> 기본값 원래 주소

                
// ---------------------------------이메일변경----------------------------------------------
               
                var mailWrapBtn = document.getElementById('mail_wrap');//이메일 인증관련 body
                var email = $('.mail_input');//메일적는칸 가져오기
                

                // 0.메일 수정하기 눌렀을 때
                $('#emailBtn').on('click',function(){

                    mailWrapBtn.style.display = "block"//이메일인증 body를 보여준다
                    console.log('email.val():',email.val(''));//메일 초기화

                });//emailBtn


                //4.메일 수정취소 눌렀을 때
                $('#mailCancleBtn').on('click',function(){

                    mailWrapBtn.style.display = "none"//이메일인증 body를 없앤다

                    changeEmailAddress = '${member.email}'; // 

                    console.log('email.val():',email.val(''));//메일 초기화
                });//emailCancleBtn

                
      // -------------------------------이메일 전송하고 시간제한-----------------------------

                var timer = null;
                var code="";
                
                var infoChangeForm;

                // 인증번호 이메일 전송
                $('.mail_check_button').click(function(){//인증코드버튼 눌렀을 때 
                    
                   // -----------------------이메일 체크------------------  
                    var emailElement = document.getElementById('email');//id값으로 요소얻기
                    var pemail = document.getElementById('pemail');//id값으로 요소얻기
                    
                    //결과값을 담을 변수
                    var emailResult;

                    //전송할 폼태그 정보
                    infoChangeForm = $('#infoChange').serialize();

                    $.ajax({
                        url: '/mypage/checkInfo',
                        type: 'POST',
                        data: infoChangeForm,
                        async: false,//동기식으로 변경함 --> 비동기로하면 값이 안들어감..
                        success: function(result){
                            console.log('1. emailReseult',result);

                            emailResult = result
                        }//success
                    })//ajax

                    
                    if(emailResult != 0){//등록된 정보 체크. 0이면 중복된 값이 없는 유니크한 값임

                        console.log('3. emailReseult',emailResult);

                        alert("이미 등록된 정보입니다. 수정한 내용을 확인해주세요");
                        emailElement.focus();

                        return false;

                    }else if(emailRegex.test(emailElement.value)){//이메일형식이 맞을 때
                        alert("인증메일이 발송되었습니다.");

                        emailElement.style.color = "black";

                        pemail.innerHTML="&nbsp;";

                        console.log("이메일 완료!");

            // ------------------------------------------------------------------
                        var boxWrap = $(".mail_check_input_box");    // 인증번호 입력란 박스
                        var checkBox = $(".mail_check_input");        // 인증번호 입력란

                        //시간표시영역
                        var display = $('.time');
                        //유효시간 설정
                        var leftSec = 180;
                        
                        startTimer(leftSec, display);

                        $.ajax({
                            url: "/mypage/sendMail?email="+email.val(),
                            type: 'GET',
                            success: function(result){//인증코드 받아오기

                                console.log("result : "+result);

                                //성공했으니 비활성은 꺼버리고 색깔 변경
                                checkBox.attr("disabled",false);
                                boxWrap.attr("id","mail_check_input_box_true");

                                code = result;
                            }//success
                        });//.ajax

                    }else{//이메일형식이 안맞을 때
                        emailElement.focus();
                        emailElement.style.color = "red";
                        
                        pemail.innerHTML = "형식이 안맞습니다.";
                        
                        return false;
                    }//if-else

                });//인증코드버튼 눌렀을 때

                //인증시 타이머
                function startTimer(count,display){

                    var minutes;
                    var seconds;
                
                    timer = setInterval(function(){
                        
            
                        minutes = parseInt(count / 60, 10); //분 구하기. 뒤에 10은 뭐지?
                        seconds = parseInt(count % 60, 10); //초 구하기. 뒤에 10은 뭐지?

                        minutes = minutes < 10 ? "0" + minutes : minutes; //한자릿수 맞추기
                        seconds = seconds < 10 ? "0" + seconds : seconds; //한자릿수 맞추기

                        display.html(minutes + ":" + seconds);

                        //타이머 끝
                        if(--count < 0 ){//시간이 초과 됐을 때

                            clearInterval(timer);

                            display.html('인증번호를 다시 받으세요');
                            
                            $(".mail_check_input").attr('disabled',true);

                            changeEmailAddress = '${member.email}';//시간초과시 원래 메일

                        }else {//시간이 초과 안됏을 때
                            
                            $('.mail_check_Message').on('click',function(){//인증번호확인 눌렀을 때

                                if( inputCode == code){//if - 번호 일치했을 때
                                    
                                    clearInterval(timer);
                                    
                                    display.html('인증완료!');
                                    
                                    $(".mail_check_input").attr('disabled',true);
                                    changeEmailAddress = email.val();//입력된 값으로

                                }else{//불일치
                                    let checkResult = $('#mail_check_input_box_warn');

                                    checkResult.html('인증번호를 다시 확인해주세요.');
                                    checkResult.attr('class','incorrect');

                                    //기존 메일주소를 전송함
                                    changeEmailAddress = '${member.email}'; // 
                                    
                                }//if-else 
                            })//인증번호확인 눌렀을 때

                        }//if-else
                    },1000)//timer = setInterval() ==1초
                }//startTimer

                var inputCode;//입력된코드

                // 인증번호 일치하는지 확인
                $('.mail_check_input').blur(function(){

                    inputCode = $('.mail_check_input').val();//입력된코드
                    
                    console.log('inputCode',inputCode);

                    var checkResult = $('#mail_check_input_box_warn');//비교결과

                    if( inputCode == code){//리턴받은 코드값 비교(일치할 경우)
                        checkResult.html('인증번호가 일치합니다.');
                        checkResult.attr('class','correct');

                        // 입력된 메일주소를 전송함
                        changeEmailAddress = email.val();
                        console.log('중간체크 :',changeEmailAddress);

                        
                    } else {//일치 안할 경우
                        checkResult.html('인증번호를 다시 확인해주세요.');
                        checkResult.attr('class','incorrect');

                        //기존 메일주소를 전송함
                        changeEmailAddress = '${member.email}'; // 
                        console.log('중간체크 :',changeEmailAddress);
                    }//if-else
                });//데이터입력 후 실행되는 함수

                var pcResult='';

// ---------------                            최종              버튼                        ----------------------------------------------------------------------
                
                //최종 변경버튼 눌렀을 때
                $('#infoChangeBtn').on('click',function(e){
                    e.preventDefault;

                     // 수정할 이메일 최종주소값 넣어주기
                    $('#mailParam').val(changeEmailAddress)
                    console.log('중간체크changeEmailAddress :',changeEmailAddress);//확인용

                    // 수정할 사업자등록번호 값 넣어주기
                    $('#cbno').val(changeCbno)
                    console.log('중간체크changeCbno :',changeCbno);//확인용
                
                    infoChangeForm = $('#infoChange').serialize(); //전송할 현재 폼태그

                    //수정등록 전에 연락처, 사업자등록번호 체크
                    $.ajax({
                        url: '/mypage/checkInfo',
                        type: 'POST',
                        data: infoChangeForm,
                        async: false,//동기식으로 변경함
                        success: function(result){
                            console.log('1. pcResult',result);

                            //결과값 넣어주기
                            pcResult = result;
                        }//success
                    })//ajax

                    if(pcResult != 0){//결과값으로 등록된 정보 체크
                        console.log('2. pcResult',pcResult);
                        alert("이미 등록된 정보입니다. 수정한 내용을 확인해주세요");

                        return false;
                    }
// ------------------------------------연락처 체크---------------------------------------------------                    
                    var phone = document.getElementById('phone');//id값으로 요소얻기
                    var pphone = document.getElementById('p_phone');//id값으로 요소얻기
                   
                    if(numberRegex.test(phone.value)){//정규표현식에 만족할 때

                        phone.style.color = "black";

                        pphone.innerHTML="&nbsp;";

                        console.log("연락처 완료!");

                    } else {//번호로만 기재 안했을 때
                        phone.focus();
                        phone.style.color = "red";

                        pphone.innerHTML="형식이 안맞습니다.";
                        pphone.style.color = "red";

                        return false;
                    }//if-else
     
                   
                    // ------------------------------------사업자번호 체크---------------------------------------------------
                    
                    console.log('cbnoCheck')
                
                    var cbno = document.getElementById('cbno');//id값으로 요소얻기
                    var pcbno = document.getElementById('p_cbno');//id값으로 요소얻기
                        

                    if(cbnoRegex.test(cbno.value)){//정규표현식에 만족할 때

                        cbno.style.color = "black";
                        pcbno.innerHTML="&nbsp;";

                        console.log("사업자번호 완료!");

                    } else {//숫자만 아닐때
                        cbno.focus();
                        cbno.style.color = "red";

                        pcbno.innerHTML="형식이 안맞습니다.";
                        pcbno.style.color = "red"
                        
                        return false;
                    }//if-else

// --------------------------------파일형식체크------------------------------------------------------  
                    var regex = new RegExp("(.*?)\.(JPG|PNG|jpg|png)$");//파일확장명 제한

                    var maxSize = 2097152;//2mb

                    function checkExtension(fileName,fileSize){//파일확장자와 크기를 확인해주는 메소드

                        if(fileSize >= maxSize){
                            alert("첨부파일이 너무 큽니다.");
                            console.log("로그를 찍어보자1");

                            return false;
                        }//파일사이즈

                        if(!regex.test(fileName)){
                            alert("해당 종류의 파일은 업로드할 수 없습니다.");

                            return false;
                        }//확장자 체크

                    }//checkExtension
                    
        // -------------------------------------------------------------------------------------------      
                        
                    $('input[type="file"]').change(function(e){//파일이 변화했을 때
                        //--> 파일 첨부하자마자 복사됌
                        var formData = new FormData();

                        var inputFile = $('input[name="uploadFile"]');

                        files = inputFile[0].files;

                        for(var i=0; i<files.length; i++){//여러개의 파일이 업로드 됐을 때
                            
                            if(!checkExtension(files[i].name, files[i].size)){
                            
                                return false;
                            }
                            
                            formData.append("uploadFile",files[i]);
                        }//for

                    });//upload

                });//infoChangeBtn
    
                
                //기존사업자번호
                var changeCbno = '${member.cbno}';
                var cbnoInput = document.getElementById('cbno');

                // 사업자진위여부 체크 눌렀을 때
                $('#cbnoBtn').on('click',function(){//사업자진위여부 체크
                    console.log('cbnoBtn!!',cbnoInput.value);

                    //사업자번호 정규표현식,자리수 체크
                    console.log('cbnoCheck')
                    
                    var cbnoRegex = /^[1-9]\d{9}$/g;//숫자만 사업자번호
                    var cbno = document.getElementById('cbno');//id값으로 요소얻기
                    var pcbno = document.getElementById('p_cbno');//id값으로 요소얻기
                        

                    if(cbnoRegex.test(cbno.value)){//정규표현식에 만족할 때

                        cbno.style.color = "black";
                        pcbno.innerHTML="&nbsp;";

                        console.log("사업자번호 완료!");

                    } else {//숫자만 아닐때
                        cbno.focus();
                        cbno.style.color = "red";

                        pcbno.innerHTML="형식이 안맞습니다.";
                        pcbno.style.color = "red"
                        
                        return false;
                    }//if-else

                    let fileWrap = document.getElementById('fileWrap');

                    $.ajax({
                        url: "/mypage/cbnoCheck?cbno="+cbnoInput.value,
                        type: "GET",
                        success: function(result){
                            console.log(result);

                            if(result == 1){//진위여부 성공시

                                if(changeCbno != cbnoInput.value){//기존 사업자등록번호랑 다를 때
                                    console.log('cbno display change....');

                                    fileWrap.style.display = 'block';
                                    $('#cbnoFile').attr("disabled",false);//파일업로드 비활성 꺼버리기
                                }//if
                                
                                //진위여부 성공되면 값 넣어주기
                                changeCbno = cbnoInput.value;
                                console.log('success changeCbno:',changeCbno);
                            }else if(result == 0){//null 값일때
                                alert("일치하는 정보가 없습니다.");
                            }//if-elseif

                        }//success
                    })//ajax

                })//cbnoBtn
            });//.jq        
        </script>
        <script language="javascript">
             //주소 API

			function goPopup(){
				var pop = window.open("/mypage/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
			}//goPopup

			function jusoCallBack(roadFullAddr){
                // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록
                document.form.roadFullAddr.value = roadFullAddr;
			}//jusoCallBack

            // function cbnoCheck(){
            //     console.log('cbnoCheck')
                
            //     var cbnoRegex = /^[1-9]\d{9}$/g;//숫자만 사업자번호
            //     var cbno = document.getElementById('cbno');//id값으로 요소얻기
            //     var pcbno = document.getElementById('p_cbno');//id값으로 요소얻기
                    

            //     if(cbnoRegex.test(cbno.value)){//정규표현식에 만족할 때

            //         cbno.style.color = "black";
            //         pcbno.innerHTML="&nbsp;";

            //         console.log("사업자번호 완료!");

            //     } else {//숫자만 아닐때
            //         cbno.focus();
            //         cbno.style.color = "red";

            //         pcbno.innerHTML="형식이 안맞습니다.";
            //         pcbno.style.color = "red"
                    
            //         return false;
            //     }//if-else
            // }//cbnoCheck
        </script>
    </head>
    <body>
        <div class="infoWrap">
                
            <form action="/mypage/infoChange" method="POST" id="infoChange" name="form" enctype="multipart/form-data" >
                <div class="memberInfoWrap">
                    <input type="hidden" name="mno" value="${member.mno}">
                    <input type="hidden" name="fid" value="${member.fid}">

                    <div class='bnameSize'>기본정보변경</div>

                    <div class="memberInfo">
                        

                        <div class='contentLine'>
                            <p>아이디</p>
                            <div><input type="hidden" name="memberid" value="${member.memberid}">${member.memberid}</div>
                        </div>
                        
                        <div class='contentLine'>
                            <p>회원명</p>
                            <div><input type="hidden" name="membername" value="${member.membername}">${member.membername}</div>
                        </div>
                        
                        <div class='contentLine'>
                            <p>주소</p>
                            <div>
                                <input type="text" id="roadFullAddr" name="memberaddress" value="${member.memberaddress}" required>
                                <button type="button" class="mailbuttonStyle" onclick="goPopup()">주소찾기</button>
                            </div>
                        </div>
                        
                        <div class='contentLine'>
                            <p>연락처</p>
                            <div><input type="tel" name="phone" id="phone" placeholder="${member.phone}" value="${member.phone}" required>'-'을 붙여서 입력해주세요<br>
                                <span id="p_phone"></span></div>
                        </div>
                        
                        
                        <c:if test="${member.membertype == '기업'}">
                            <div class='contentLine'>
                                <p>사업자번호</p>
                                <div><input type="text" name="cbno" id="cbno" value="${member.cbno}" required>
                                    <button type="button" class="mailbuttonStyle" id="cbnoBtn">사업자진위확인</button>
                                    <span id="p_cbno"></span>
                                </div>
                            <!-- 파일첨부 숨겨놓기 -->
                                <div class='contentLine' id="fileWrap" style="display: none;">
                                    <p style="color: blue; font-weight: bold;">인증완료! 사업자등록증을 첨부해주세요.(2MB이하 jpg,pnp파일)</p><br>
                                    <label class="custom-file-upload">파일업로드
                                    <input type="file" name="uploadFile" id="cbnoFile" disabled="disabled" required>
                                    </label>
                                </div>
                            </div>
                            
                        </c:if>

                        <div class='contentLine'>
                            <p>가입일자</p>
                            <div><fmt:formatDate pattern="yyyy-MM-dd" value="${member.signdate}"/></div>
                        </div>
                        
                        <div class='contentLine'>
                            <p>회원유형</p>
                            <div><input type="hidden" name="membertype" value="${member.membertype}">${member.membertype}</div>
                        </div>
                        
                        
                        <div class='contentLine'>
                        <p>이메일</p>
                        <input type="hidden" name="email" id='mailParam' value="${member.email}">
                        <div class="inlineDiv">
                            <div>${member.email}</div>
                            <button type="button" class="mailbuttonStyle" id="emailBtn">수정하기</button>
                        </div>
                        </div>

                        
                        <!--============================================= 이메일관련  =============================================-->                            
                        <div class='contentLine' id="mail_wrap" style="display: none;">
                            <div class="mail_name"><p>변경할 이메일주소</p></div>
                            <div class="mail_input_box">
                                <input class="mail_input" id='email' name="emailSub" value="">
                                <span id="pemail"></span>
                            </div>
                            
                            <div class="mail_check_wrap">
                                <div class="mail_check_input_box" id="mail_check_input_box_false">
                                    <input class="mail_check_input" disabled="disabled"><!-- 인증코드 체크 -->
                                </div>
                                <div class="mail_check_button">
                                    <div>인증메일발송</div>
                                </div>
                            </div>

                            <div class="mail_check_wrap">
                                <span id="mail_check_input_box_warn">&nbsp;</span><!-- 인증번호 일치여부 -->
                                
                                <div class="time"></div>
                            </div>    
                            
                            <div class="mail_check_wrap">
                                <button type="button" class="mail_check_Message">인증번호확인</button>
                                <button type="button" id="mailCancleBtn" class="cancleBtnStyle">수정취소</button>
                            </div>
                        </div>  
                        <!--============================================= 이메일관련  =============================================-->
                        
                    </div> 
                </div>

                
                <div>
                    <button type="submit" id="infoChangeBtn" class="buttonstyle">변경</button>
                    <button type="button" id="changeCancel" class="buttonstyle" >취소</button>
                </div>
            </form>
        </div>
    </body>
</html>