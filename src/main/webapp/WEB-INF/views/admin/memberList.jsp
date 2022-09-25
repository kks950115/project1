<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>

    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>

</head>

<script>
	$(function(){
		
		//회원 구분 변경
		$('#selectBox').on('change', function(){
			selBoxVal = $(this).val();
			
			var selectForm = $('#selectForm');
			selectForm.attr('action', '/admin/memberList');
			selectForm.attr('method', 'get');
			
			selectForm.append('<input type="hidden" name="membertype" value="'+selBoxVal+'">');
			selectForm.submit();
		});//onChange
		
		

		
		
		
		//회원 탈퇴 
		$('#memberDelBtn').on('click', function(e){
			//e.preventDefault();
			
			if($('input[name=mno]:checked').length > 0) {
				var result = confirm('정말 삭제하시겠습니까?');
				
				if(result) {
					/* $('#hidden_mno').attr('disabled', true); */
					var boxval = $('#selectBox').val();
					
					var checkboxForm = $('#checkboxForm');
					
					checkboxForm.attr('action','/admin/delMember');
					checkboxForm.attr('method','POST');
                    
					checkboxForm.append('<input type="hidden" name="membertype" value="'+boxval+'" />');
                    
                    checkboxForm.submit();
				} else {
					return false;
				}//if-else
			} else {
				alert('탈퇴시킬 이용자를 먼저 선택해주세요.');
			}//if-else
			
		});//onClick
		
		//회원 탈퇴 복구
		$('#memberRollbackBtn').on('click', function(e){
			//e.preventDefault();
			
			if($('input[name=mno]:checked').length > 0) {
				var result = confirm('정말 복구하시겠습니까?');
				
				if(result) {
					var boxval = $('#selectBox').val();
					
					var checkboxForm = $('#checkboxForm');
					
					checkboxForm.attr('action','/admin/rollbackMember');
					checkboxForm.attr('method','POST');
                    
					checkboxForm.append('<input type="hidden" name="membertype" value="'+boxval+'" />');
                    
                    checkboxForm.submit();
				} else {
					return false;
				}//if-else
			} else {
				alert('복구시킬 이용자를 먼저 선택해주세요.');
			}//if-else
			
		});//onClick
		
		//체크박스 전체선택
		$('#selectAll').on('click', function(){
			if($(this).is(':checked')){
				$('input:checkbox[name="mno"]').each(function(){
					$(this).prop("checked", true);
				});
			} else {
				$('input:checkbox[name="mno"]').each(function(){
					$(this).prop("checked", false);
				});
			}//if-else
			
		});//onClick
		

	});//end jq
	
	
	function show(mno) {
		var popup = window.open('/admin/showDetailInfo?mno='+mno, 'Detail', 'width=500px,height=500px,scrollbars=no');
	}
</script>

<style>
	.mybtn {
		border: 1px solid #bbb;
		cursor: pointer;
	}
	.contentIn {
		min-height: 750px;
	}

	#board {
		margin-top: 50px;
		margin-bottom: 20px;
	}

	table {
		width: 100%;
		border-collapse: collapse;
		margin-bottom: 20px;
	}
	table thead tr th {
		border-top: 3px solid #005bbb;
		border-bottom: 1px solid #bbb;
	}
	tr {
		height: 40px;
		border-bottom: 1px solid #bbb;
	}
	td {
		text-align: center;
	}
	/* td:nth-child(5) {
		text-align: justify;
	} */
	
	#selectBox {
		
		width: 80px;
		height: 30px;
		
		margin-bottom: 10px;
	}
	
	#memberDelBtn {
		margin-right: 5px;
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
	
	.clear {
		clear: both;
	}
	.modal {
		position:absolute; 
		width:100%; 
		height:100%; 
		background: rgba(0,0,0,0.8); 
		top:0; 
		left:0; 
		display:none; 
	}
	.modal_content{
	  	width:400px; height:200px;
	  	background:#fff; border-radius:10px;
	  	position:relative; top:50%; left:50%;
	  	margin-top:-100px; margin-left:-200px;
		text-align:center;
	  	box-sizing:border-box; padding:74px 0;
	  	line-height:23px; cursor:pointer;
	}


</style>

<script>
    $(function(){
    	var tmp;
    	
        var subName = $('.subName').text();
        
        $('.chk').each(function(index,obj){
            var t = index;
            var o = $(this).text();
            console.log(t + ':' + o)
            if(o == subName) {
            	tmp = t;
            }
        });

        console.log(tmp)
        
        $('#parent').children().eq(tmp).children().css({
            'font-size': '18px',
            'font-weight':'bold',
            'background':'url(/resources/img/side_li_bg.jpg) no-repeat',
            'background-position': 'right center'
        });
    })//end jq
</script>
<body>
    <div id="wrap">
 	
	<%@ include file="/WEB-INF/views/common/header.jsp" %>

        <div id="container">
            <div id="aside">
                <h2 class="asideMenu">관리페이지</h2>
                <ul id="parent">
					<li><a class="chk" href="/mypage/adminInfo">기본정보변경</a></li>
                    <li><a class="chk" href="/admin/memberList?membertype=개인">회원관리</a></li>
                    <li><a class="chk" href="/admin/memberBoard">회원글관리</a></li>
                    <li><a class="chk" href="/admin/memberReply">회원댓글관리</a></li>
                    <li><a class="chk" href="/admin/apply">참가기업관리</a></li>
                    <li><a class="chk" href="/exhibition/list">전시일정관리</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 관리페이지 > 회원관리 </div>
                    <h2 class="subName">회원관리</h2>
                </div>
                <div class="contentIn">
                	
                	<div id="board">
                	
                		<div id="table">
                			<select id="selectBox" name="membertype">
                				<option value="관리자" ${('관리자' eq param.membertype) ? 'selected' : ''}>관리자</option>
                				<option value="개인" ${('개인' == param.membertype || param.membertype == null) ? 'selected' : ''}>개인회원</option>
                				<option value="기업" ${('기업' eq param.membertype) ? 'selected' : ''}>기업회원</option>
                			</select>
                			
                		
                			<table id="myTable">
                				<thead>
                					<form id="selectForm"></form>
                					<tr>
                						<th width="2%"><input type="checkbox" id="selectAll"/></th>
                						<th width="4%">구분</th>
                						<th width="8%">회원ID</th>
                						<th width="8%">회원명</th>
                						<th width="25%">주소</th>
                						<th width="8%">연락처</th>
                						<th width="12%">이메일</th>
                						<th width="8%">사업자번호</th>
                						<th width="10%">가입일</th>
                						<th width="5%">탈퇴여부</th>
                						<th width="10%">탈퇴일</th>
                						
                					</tr>
                				</thead>
                				
                				
	                 				
	                			<form id="checkboxForm">
	                				<tbody>
	                					
	                					<c:forEach items="${members}" var="member">
	                					
	                					<tr>
	                						<td><input type="checkbox" name="mno" id="mno" value="${member.mno}" /></td>
	                						<td>${member.membertype}
	                							<button class="mybtn" id="changeMemberType" type="button" onClick="show(${member.mno})">변경</button>
	                						</td>
	                						
	                						<td>${member.memberid}</td>
	                						<td>${member.membername}</td>
	                						<td>${member.memberaddress}</td>
	                						<td>${member.phone}</td>
	                						<td>${member.email}</td>
	                						<td>${member.cbno}</td>
	                						<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${member.signdate}"/></td>
	                						<td>${member.drop_tf}</td>
	                						<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${member.dropdate}"/></td>
	                						
	                					</tr>
	                					
	                					</c:forEach>
	                								                				
	                				</tbody>
		                		</form>			
	                				
                				
                			
                			</table>
                			
                			<div id="btnArea">
                				<button class="btn" id="memberDelBtn" type="button">탈퇴처리</button>
                				<button class="btn" id="memberRollbackBtn" type="button">복구처리</button>
                					
                			</div>
                			
							
                		
                		</div>
                		
                	</div>
                
                </div>
            </div>
        </div>

   
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>