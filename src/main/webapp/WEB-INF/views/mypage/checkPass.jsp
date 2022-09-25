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

        <link rel="stylesheet" href="/resources/css/infoChange.css">

        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

        <script>
            $(function () {
                console.log('jq started')

                var comparePass;
                
                $("#loginBtn").on('click',function(){//로그인 버튼을 눌렀을 때

                        
                    if(comparePass == 'success'){//패스워드가 일치했을 때
                        
                        console.log('로그인!!')

                    } else {//패스워드가 일치안했을 때
                        alert("잘못된 접근입니다.");

                        return false;
                    }//if-else

                })//loginBtn

                // on("propertychange change keyup paste input", function(){}
                //비밀번호 일치여부확인(입력되는대로 인식함)
                $('#pw').on("propertychange change keyup paste input",function(){

                    var formData = $('form').serialize();
                    console.log("formData",formData);

                    $.ajax({
                        url: '/mypage/getPass',
                        data: formData,
                        type: 'POST',
                        success : function(result){
                            console.log("result",result)
                            comparePass = result;
                        }//success
                    })//.ajax
                });

            })//.jq
        </script>
    </head>
    
    <body>
        <div>
            <div class="checkPass">
                <form action="/mypage/checkPass" method="POST">
                    <input type="hidden" name="memberid" value="${__LOGIN__.memberid}">
                    <p class="topBottom"></p>

                    <div>
                        <p>비밀번호 확인</p>
                        <input class="passSize" type="password" name="memberpw" id="pw" placeholder="기존 비밀번호를 입력하세요.">
                    </div>
                    <div>
                        <button type="submit" class="checkBtn" id="loginBtn">확인</button>
                    </div>
                    <p class="topBottom"></p>
                </form>
            </div>
        </div>
    </body>
</html>