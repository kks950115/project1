/*apply/appform.jsp
 */

$(function () {
    console.debug('jq started...');

    var btno="";
    var boothId="";
    var btprice ="";
    
    $('.bttypeIsA, .bttypeIsB').on('click', function (data) {
		

        console.debug('.bttypIsA on click event triggered...');
        if(btno.length<1){  //선택된 부스가 없을 때 
            btno =data.target.getAttribute('value');
            console.debug("btno: "+btno);
            $('#boo'+btno).css('background-color', '#005bbb');

            document.querySelector('#btnois').innerHTML ='부스번호 : ' +btno;
            $('#btno').attr('value', btno);
        }else{
            alert('부스는 하나만 선택 가능합니다. 선택한 부스로 정보가 변경됩니다.');
            // 초기화
            $('#boo'+btno).css('background-color', '#fbfbfb');

            // 새로 선택된 부스로 정보 변경. 
            btno =data.target.getAttribute('value');
            boothId ='#btno'+btno;
            $('#boo'+btno).css('background-color', '#005bbb');

            document.querySelector('#btnois').innerHTML ='부스번호 : ' +btno;
            $('#btno').attr('value', btno);

        }//if-else

        var bttype = data.target.getAttribute('class');
		btprice= document.getElementById('btprice'+btno).value;
        console.log("bttype: "+bttype);
		console.log("btprice: "+btprice);
        if(bttype == 'bttypeIsA'){
            document.querySelector('#bttype').innerHTML  ='부스 타입 : A ';
            document.querySelector('#btprice').innerHTML ='부스 가격 : '+btprice+'원';
        }else{
            document.querySelector('#bttype').innerHTML  ='부스 타입 : B';
            document.querySelector('#btprice').innerHTML ='부스 가격 : '+btprice+'원';
        }//if else
        
        
        // alert('boo'+btno);
    });//onclick event

    $('#appBtn').on('click', function () {
        console.debug('appBtn on click event triggered... ');

        if(btno==""){
            alert('부스를 선택해주세요.')
        }else if($('input[name=applycompany]').val() == ""){
            alert('기업명을 입력해주세요.')
        }else{
            let applyForm = $('#apply');

            applyForm.submit();
        }//if-else

    });// on click envent
});//.jq