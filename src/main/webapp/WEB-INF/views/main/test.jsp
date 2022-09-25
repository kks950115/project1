<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>

</head>

<script>
    $(function(){


        // if(getCookie('cp_img') != "") {
        //     var cp_img_arr = getCookie('cp_img').split(',');

        //     for(var i = 0; i < cp_img_arr.length; i++) {
        //         InputHtml(i);
        //         $('#cookie_img' + i + "").attr('src', cp_img_arr[i]);
        //     }
        // }

        
        $('#hide_cp_img').val($('#companyImg').attr('src')); //참여기업 이미지 경로 가져오기


    	var cp_img = $('#hide_cp_img').val();
        var cp_img_arr = getCookie('cp_img').split(',');

        $('#cp_append').html("");

        for(var i = 0; i < cp_img_arr.length; i++) {

            if(cp_img_arr[0].trim() == "") {
                break;
            }

            if(cp_img == cp_img_arr[i]) {
                $('#cp_h_img').attr('src', '/resources/img/ico_h_on.png');
            }

            InputHtml(i);
            $('#cookie_img' + i).attr('src', cp_img_arr[i]);

        }
        
    })//end jq

    function setCookie(name, value, exp) {
        var date = new Date();
        date.setTime(date.getTime() + exp*24*60*60*1000);
        document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
    }

    // function getCookie2(cookie_name) {
    //     var x, y;
    //     var val = document.cookie.split(';');

    //     for (var i = 0; i < val.length; i++) {
    //         x = val[i].substr(0, val[i].indexOf('='));
    //         y = val[i].substr(val[i].indexOf('=') + 1);
    //         x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
    //         if (x == cookie_name) {
    //             return unescape(y); // unescape로 디코딩 후 값 리턴
    //         }
    //     }
    // }
    // 쿠키 불러오기
	function getCookie(key) {

        var cookie = document.cookie;
        var cookie_arr = cookie.split(";");
        var cookie_json = {};

        if (cookie) {
            for (var i = 0, j = cookie_arr.length; i < j; i++) {

                var arr = cookie_arr[i].split("=");
                var _key = arr[0].trim();
                var _value = arr[1].trim();
                cookie_json[_key] = _value;

            }
        }

        if (cookie_json[key]) {

            return cookie_json[key];

        }

        return "";

    }

       // 쿠키 입력
    function insCookie(key, value, days) {

        var cookie_value = getCookie(key);
        var cookie_arr = cookie_value.split(',');
        var cookie_arr = (cookie_value||'').split(',');

        if (!cookie_value || !cookie_arr.length) {
            cookie_arr = [];
        }

        // 3개 이상일때
        if (cookie_arr.length >= 3) {
            cookie_arr.push(value);
            cookie_arr.splice(0, 1);
        } else {
            cookie_arr.push(value);
        }

        var exdate = new Date();
        exdate.setDate(exdate.getDate() + days);
        //설정 일수만큼 현재시간에 만료값으로 지정
        var path = '/';
        var cookie = cookie_arr.join(",") + ((days == null) ? '' : ';    expires=' + exdate.toUTCString() + '; path=' + path);
        document.cookie = key + '=' + cookie;
        //alert(document.cookie);

    }


       // 쿠키 삭제
    function delCookie(key, value, days) {

        var cookie_value = getCookie(key);
        var cookie_arr = cookie_value.split(",");

        if (!cookie_arr.length) {
            cookie_arr = [];
        }

        for (var i = 0, j = cookie_arr.length; i < j; i++) {

            if (cookie_arr[i] == value) {
                cookie_arr.splice(i, 1);
            }

        }

        var exdate = new Date();
        exdate.setDate(exdate.getDate() + days);
        //설정 일수만큼 현재시간에 만료값으로 지정
        var path = '/';
        var cookie = cookie_arr.join(",") + ((days == null) ? '' : ';    expires=' + exdate.toUTCString() + '; path=' + path);
        document.cookie = key + '=' + cookie;

    }


    function h_imgChange() {
        var cp_img = $('#hide_cp_img').val();
        var cp_h_img = $('#cp_h_img').attr('src');
        var cp_no = $('#cp_no').val();


        // if(getCookie('cp_img') == null) {
        //     setCookie('cp_img', '', 1);
        //     setCookie('cp_no', '', 1);
        // }

        if(cp_h_img == "/resources/img/ico_h_on.png") { //on 일때
            $('#cp_h_img').attr('src', "/resources/img/ico_h_off.png"); //off로 바꿈
            delCookie('cp_img', cp_img, 1);
            delCookie('cp_no', cp_no, 1);
        } else { //off일때
            $('#cp_h_img').attr('src', "/resources/img/ico_h_on.png"); //on으로 바꿈
            insCookie('cp_img', cp_img, 1);
            insCookie('cp_no', cp_no, 1);
        }

        var cp_img_arr = getCookie('cp_img').split(',');
        $('#cp_append').html("");

        for(var i =0; i < cp_img_arr.length; i++) {

            if(cp_img_arr[0].trim() == "") {
                break;
            }
            InputHtml(i);
            $('#cookie_img' + i + "").attr('src', cp_img_arr[i]);

        }

    }

    function InputHtml(seq) {
        var html = "<li id='list_" + seq + "'>" +
            "<a href='javascript: showCpImg("+ seq +");' id='cp_no" + seq + "'>" +
            "<img src='../images/sub/bg_n.png' width='100px' height='100px' id='cookie_img" + seq + "'/> " +
            "</a>" +
            "<em class='ico_c1'>기업</em>" +
            "</li>";

        $('#cp_append').append(html);
    }

    function showCpImg(seq) {
        var cp_no_arr = getCookie('cp_no').split(',');

        if(seq == 0) {
            location.href = "/apply/companyInfo?applyno=" + cp_no_arr[0];
        } else if(seq == 1) {
            location.href = "/apply/companyInfo?applyno=" + cp_no_arr[1];
        } else if(seq == 2) {
            location.href = "/apply/companyInfo?applyno=" + cp_no_arr[2];
        }
    }
</script>

<style>

    .fav_box {
        position: fixed;
        top: 443px;
        right: 20px;
        height: 200px;
    }

    .fav_box ul li {
        width: 100%;
        position: relative;
        border: 1px solid #ddd;
        height: 100px;
        overflow: hidden;
        text-align: center;
        line-height: 100px;
        overflow: hidden;
        margin-top: 10px;

        border-bottom: 1px solid #ddd !important;
        margin-top: -1px !important;
    }
</style>


<body>

    <a href="#" onclick="h_imgChange()">
        <img src="/resources/img/ico_h_off.png" id="cp_h_img" >
        <input type="hidden" id="hide_cp_img" value="">
        <input type="hidden" id="cp_no" value="${param.applyno}">
    </a>

    <p>
        <img src="/resources/img/mail.png" id="companyImg">

    </p>

    <div class="fav_box">
        <p>관심 기업 및 제품"</p>
        <ul id="cp_append">
            <!-- 여기에 기업 이미지, 정보가 생성됨 -->
        </ul>
    
    </div>

</body>
</html>