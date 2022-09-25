/*mypage/drop.jsp
 * 
 */



var code;   //인증코드

$(function () {
    $('div#formdata2').hide();
    $('#emailAuthAndNextBtn').hide();

    //-----------------------------------------------------------------------------//
    //1. emailSendBtn onclick event
    //-----------------------------------------------------------------------------//
    
    $('#emailSendBtn').on('click',function () {
        console.debug('emailSendBtn click event triggerd');

        
        $('div#formdata2').show();
        $('#emailAuthAndNextBtn').show();
       
        $.ajax({
            method:'GET',
            url:'/mypage/sendemail',
            dataType:'json',
            success:function (data) {
                console.debug('send success');
                
                if(data.result.length>0){
                    alert('회원정보에 등록된 이메일로 인증번호가 발송 되었습니다.');
                    code=data.result;
                }else{
                    alert('인증메일 발송에 실패하였습니다. ');
                }//if-else
                
            },//success

            error:function (data){
                console.debug('send fail');
                console.log(data);
                alert('인증메일 발송에 실패하였습니다. ')
            }//error
        })//ajax
       
        document.querySelector('#emailSendBtn').innerHTML="재발송"
    });//onclick

    
    
    //emailSend 비동기 검증. 

    //-----------------------------------------------------------------------------//
    //2. emailAuthAndNextBtn               
    //-----------------------------------------------------------------------------//

    $('#emailAuthAndNextBtn').on('click',function () {
        console.debug('emailAuthAndNextBtn click event triggerd');

        //2-1 Check Box != '' 검증 
        var checkedAgree =$('input:checkbox[id="agreement"]').is(":checked");
        console.debug('checked :', checkedAgree);

        //2-2 email인증번호 검증 ajax 비동기.
        var emailCode =$('#emailValue').val();
        console.debug('emailCode :', emailCode);
        
    

        if(emailCode == ''){
            alert('인증번호를 입력해주세요')
        }else if(!checkedAgree){
            alert('회원탈퇴를 위해 약관에 동의해주세요');
        }else if(emailCode != code ){
            alert('유효하지 않은 인증번호입니다.')
        }else if(emailCode == code  && checkedAgree){    //checkedAgree
            console.log('최종 제출지점.')
           

          let form =$('#dropForm');
          form.submit();
      }//if
    });//onclcik

    

});//jq