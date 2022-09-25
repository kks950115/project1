/*mypage/modifypassword.jsp
 * 
 */

            // window.onload = function () {
            //     console.debug('onload() invoked.');

            //     var xhr = new XMLHttpRequest();

            //     xhr.open('GET', '/resources/captcha/${__CAPTCHA_IMG__}',false);
            //     xhr.send();
            //     if(xhr.readyState==4){  //응답 완료라면 
            //         $('#captcha').find('#capImg').attr('src','/resources/captcha/${__CAPTCHA_IMG__}'); 
            //     }//if

            //     console.log(xhr);
            // };//onload




$(function () {
    console.debug('jq started...2 ');

    var captchaSuccess=false;
    var passwordInvalidate=false;

    

    // --------------------------------------------------------------------------------------------------//
    //1. 새로운 비밀번호 검증
    // --------------------------------------------------------------------------------------------------//
    
    $('#newPass1, #newPass2').keyup(function () {
        console.debug('newPass1, newPass2 keyup event triggered');

        let pass1 = $('#newPass1').val();
        let pass2 = $('#newPass2').val();
        let invalid =/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

        if(pass1 != pass2){
            document.querySelector('#passwordInvalidMessage').innerHTML="비밀번호가 일치하지 않습니다."
        }else{  //입력한 두 비밀번호가 일치 했을때. 
            document.querySelector('#passwordInvalidMessage').innerHTML="&nbsp;"


            if(!invalid.test(pass1)){   //비밀번호 제약 조건 위배 했을 때.
                console.log('invalidate check..')
                $("#passwordInvalidMessage").css('color','red')
                document.querySelector("#passwordInvalidMessage").innerText="비밀번호는 8~20 이내의 영문,숫자,특수문자를 포함해야합니다";
                passwordInvalidate=false;
            }else{
                console.log('invalidate success')
                $("#passwordInvalidMessage").css('color','#005bbb')
                document.querySelector("#passwordInvalidMessage").innerText="사용가능한 비밀번호 입니다.";
                passwordInvalidate=true;
            }//if

        }//if-else
    });//keyup event

    // --------------------------------------------------------------------------------------------------//
    // 2. Captcha 인증번호 검증                 
    // --------------------------------------------------------------------------------------------------//

    $('#captchaBtn').on('click',function () {
        console.debug('captchaBtn click event triggered');
        
        
        let inputValue=$('#value');

        if(reloadKey != null){
            key=reloadKey;
            console.log('key : ', key)
        }//if

        console.log( 'value=',inputValue.val());

        // ==========인증지연 때문에 임시 검증 코드=========
        if(inputValue.val() =='AN15'){
            alert('성공');
            //검증할 결과 담을 변수에 true 저장. 
            captchaSuccess=true;

            $('#captcha').hide();   //captcha 인증 화면 숨김. 
        }else{
            alert('인증에 실패하였습니다.');
        }//if
        
        // ==========인증지연 때문에 주석처리=============
        // $.ajax({
        //     // 1. HTTP method 설정
        //     method:'POST',

        //     //2. 요청 데이터 & 데이터 타입 설정
        //     data : {"key" : key , "value":inputValue.val()},
        //     contentType:'application/x-www-form-urlencoded; charset=utf8',
            
        //     //3. 응답설정. 
        //     url: '/mypage/captchaAuth',
        //     dataType: 'json',
            
        //     //성공시 callback
        //     success: function (data) {
        //         console.log(data);
        //         console.log(typeof data);
        //         console.log(data.result);
        //         console.log(data.responseTime);

        //         if(data.result){    //인증 성공시
        //             alert('성공');
        //             //검증할 결과 담을 변수에 true 저장. 
        //             captchaSuccess=true;

        //             $('#captcha').hide();   //captcha 인증 화면 숨김. 

        //         }else{
        //             alert('실패');
        //             captchaSuccess=false;
        //         }//if-else
                
        //     },//success

        //     error:(jqXHR, textStatus, errorThrown) =>{
        //         console.log("error invoked.");
        //         alert('다시 시도 해주십시오');
        //     }//error

        // });//ajax
    });//on click event


    // --------------------------------------------------------------------------------------------------//
    // 3. Captcha 재발급.           
    // --------------------------------------------------------------------------------------------------//
    $('#captchaReloadBtn').on('click',function () {
        console.debug('captchaReloadBtn click event triggered');
        
        $('#captcha').find('#capImg').attr('alt', '이미지 재로딩 중입니다...');

        $.ajax({
            method:'GET',
            url: '/mypage/captchaReload',
            dataType:'json',

            success : function (data) {
                console.log('success... ');
                reloadKey=data.key; //전역 변수에 응답으로 받은 키 저장. 
                
                setTimeout(function () {
                        console.debug('setTimeout() invoked.');
                        $('#captcha').find('#capImg').attr('src','/resources/captcha/'+data.imgPathAndName); //리로드 된 이미지로 변경
                }, 5000);//setTimeout
            },//success

            error:function(data){
                console.debug('error....');

                console.log(data);
            }
        });//ajax
    }); //on click

    // --------------------------------------------------------------------------------------------------//
    // 4. 비밀번호 변경 button click event                
    // --------------------------------------------------------------------------------------------------//
    $('#modifyPasswordBtn').on('click',function () {
        console.debug('click event triggered');
        
        var currPass = $('#currPass').val();    //currPass에 입력된 값을 지역변수에 저장. 
        
        if(currPass.length>0 && captchaSuccess && passwordInvalidate){    //기존 비밀번호가 null 이 아닐때, 1,2 검증 성공 했을때 
            let modifyForm = $('#modifyForm');  //form 태그를 지역변수에 저장. 
            modifyForm.submit();                //제출 
        }else{
            alert('잘못된 접근입니다.');
        }//if
    });//onclick event
});//.jq


