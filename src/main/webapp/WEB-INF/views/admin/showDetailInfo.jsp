<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DetailInfo</title>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    
</head>

<script>

	$(function(){
		$('#changeBtn').on('click', function(){
			var result = confirm('적용하시겠습니까?');
			
			if(result) {
				
				$.ajax({
					url:'/admin/changeMemberType',
					type:'post',
					data:{'mno':$('#mno').val(), 'membertype':$('#membertype').val()},
					success: function(){
						
						opener.parent.location.reload();
			        	window.close();
			        	
					}//success
				});//ajax
				
				
			} else {
				return false;
			}//if-else
			
			
		});//onclick
		
	});//end jq
</script>

<style>
	
	table {
		width: 480px;
		margin-bottom: 20px;
	}
	.btn {
        width: 100px;
        height: 40px;

        border: 0;
        
        text-align: center;
        background: #005bbb;
        color: #fff;
        font-size: 15px;
        
        cursor: pointer;
	}
	
	#changeBtn {
		margin-left: 15px;
	}
</style>
<body>
    <h1>[${list.membertype}] - ${list.membername}</h1>
   
   	<input type="hidden" id="mno" name="mno" value="${list.mno}" />
    <table>
    	<tbody>
	        <tr>
	            <th>회원구분</th>
	            <td>
	            	<select name="membertype" id="membertype">
	            		<option value="관리자" ${('관리자' eq list.membertype) ? 'selected' : ''}>관리자</option>
	            		<option value="개인" ${('개인' eq list.membertype) ? 'selected' : ''}>개인</option>
	            		<option value="기업" ${('기업' eq list.membertype) ? 'selected' : ''}>기업</option>
	            	</select>
	            </td>
	        </tr>
	        <tr>
	            <th>회원번호</th>
	            <td>${list.mno}</td>
	        </tr>
	        <tr>
	            <th>회원ID</th>
	            <td>${list.memberid}</td>
	        </tr>
	        <tr>
	            <th>회원명</th>
	            <td>${list.membername}</td>
	        </tr>
	        <tr>
	            <th>주소</th>
	            <td>${list.memberaddress}</td>
	        </tr>
	        <tr>
	            <th>연락처</th>
	            <td>${list.phone}</td>
	        </tr>
	        <tr>
	            <th>이메일</th>
	            <td>${list.email}</td>
	        </tr>
	        <tr>
	            <th>사업자번호</th>
	            <td>${list.cbno}</td>
	        </tr>
	        <tr>
	            <th>가입일</th>
	            <td>${list.signdate}</td>
	        </tr>
	        <tr>
	            <th>탈퇴여부</th>
	            <td>${list.drop_tf}</td>
	        </tr>
	        <tr>
	            <th>탈퇴일</th>
	            <td>${list.dropdate}</td>
	        </tr>
        </tbody>
	        
	    </table>
    
    <div>
    	<button class="btn" type="button" id="changeBtn">적용</button>
    </div>
    
</body>
</html>