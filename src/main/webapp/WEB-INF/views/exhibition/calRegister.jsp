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
			
        <link href="/resources/css/calendar.css" rel="stylesheet" type="text/css" />

        <script>
            $(function(){

                $('#exCancleBtn').on('click',function(){
                    
                    window.close();
                })

                $('#exRegBtn').on('click',function(e){
                    
                    e.preventDefault();

                    var exname = $('input[name=exname]').val();
                    var exstart = $('input[name=exstart]').val();
                    var exend = $('input[name=exend]').val();
                    var excontent = $('input[name=excontent]').val();
                    
                    // 후...serialize이거 빼먹으면 데이터가 안뽑힘..
                    var params = $('#exRegisterForm').serialize();

                    console.log(params)

                    $.ajax({
                        url: '/exhibition/calRegister',
                        type : 'POST',
                        data : params,
                        success: function(result){
                            console.log(result)

                            window.opener.document.location.reload();
                            self.close();
                        }//success
                    })//.ajax({
                    
                })//exRegBtn
            })//.jq
        </script>
    </head>
    <body>
        <div class="exhibitionWrap">
            <form id="exRegisterForm">
                <table>
                    <tbody>
                        <tr>
                            <th>전시명</th>
                            <td><input type="text" name="exname" placeholder="전시명을 입력해주세요" required></td>
                        </tr>
                        <tr>
                            <th>전시시작일</th>
                            <td><input type="date" name="exstart" placeholder="전시시작일" required></td>
                        </tr>
                        <tr>
                            <th>전시마감일</th>
                            <td><input type="date" name="exend" placeholder="전시마감일" required></td>
                        </tr>
                        <tr>
                            <th>전시내용</th>
                            <td><textarea name="excontent" rows="10" placeholder="전시일정 내용을 입력해주세요" required></textarea></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <button type="submit" class="exBtnStyle" id="exRegBtn">등록</button>
                    <button type="button" class="exBtnStyle" id="exCancleBtn">취소</button>
                </div>
            </form>
        </div>
    </body>
</html>