<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>


<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사업장인증</title>
    <link rel="stylesheet" href="/resources/css/common.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    
    <script>


        
        $(function(){
        	$('#chkBtn').on('click', function(){
                
                if($('#id').val().length == 10) { //사업자등록번호가 10자리인지 체크 후 진행
                	
            		$.ajax({
                        type : 'post',
                        url : "/member/doubleCheckCBNO",
                        dataType : "json",
                        data : {"cbno":$('#id').val()},
                        success : function(data){
                        	console.log(data);
                        	if(data == 1) {
                        		homeTaxCBNO();
                        	} else {
                        		alert('이미 가입된 사업자등록번호입니다.');
                        		$('#id').focus();
                        	}//if-else
                        		
                        }//success

                    });//ajax
            		
                } else { // 사업자등록번호가 10자리가 아니라면 메시지출력
                	alert('10자리의 사업자등록번호를 입력해주세요.');
                	$('#id').focus();
                }//if-else

        		
        		
        		
        	});//onClick



            function homeTaxCBNO() {
                $.ajax({
                    url:"/member/homeTaxCBNO",
                    type: 'post',
                    data : {"cbno":$('#id').val()},
                    success : function(data) {
                        // api 사업자등록번호 조회가 유효하면
                        if(data == 'ok'){
                            console.log("매치 결과값 있음")
                            var answer = confirm("확인완료! 기업회원가입을 진행하시겠습니까?");
                            if(answer == true) {
                                location.href = "/member/join_c?cbno=" + $('#id').val();
                            } else {
                                alert('취소하셨습니다.');
                            } //if-else

                        } else {
                            console.log("매치 결과값 없음")
                            alert('일치하는 사업자등록번호가 없습니다.');
                        }//if-else
                        
                    },//success
                    error:function(request,status,error){
                        // api 호출 과정에서 에러나면 경고창으로 에러 메세지 출력 
                        // alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
                    }//error
                });//ajax
            }//end js

        	
            $('#before_button').on('click', function(){
                location.href="/member/member_type";
            });
        	
        });//jq end


    </script>


    <style>
    	body {
    		background-color: #eff2f4;
    	}
    	
        #wrap{
            width: 100%;
            height: 800px;
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
            margin-bottom: 80px;
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
        .btn_area {
            margin-top: 40px;
            margin-bottom: 20px;
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

            <section>
                <div class="guideText">
                <h2>기업회원사 가입을 위해<br> 사업자번호 인증을 진행해주세요.</h2>
                </div>


                <p class="join_title">사업자등록번호</p>

                <dl>
                    <dd class="join_list"><input class="user_input" type="text" name="cbno" id="id" placeholder="구분선(-) 없이 10자리의 사업자등록번호를 입력해주세요." oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></dd>
                    <p class="btn_area">
                        <input class="btn" type="button" value="이전" id="before_button">
                        <input class="btn" type="button" value="인증" id="chkBtn">
                    </p>
                </dl>
            </section>
        </div>
    </div>
    
</body>
</html>