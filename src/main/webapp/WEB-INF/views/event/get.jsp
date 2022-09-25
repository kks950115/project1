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
        
        <title>get.jsp</title>
        
        <!-- ======================== JQUERY ======================= -->
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>
        <script src="/resources/js/reply.js"></script>
        


        <!-- ======================== Bootstrap ======================= -->
        
        <!-- 합쳐지고 최소화된 최신 CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        
        <!-- 부가적인 테마 -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
        
        <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
        
        <script>

            $(function () {
                console.debug("jq started.");
                console.log("================ JS TEST ===============");
                
                var bnoValue = "${board.bno}";
                var replyUL = $(".chat");//댓글 내용 기입된 ul태그

                showList(1);//첫페이지 기본으로 보여줌

                function showList(page) {
                    console.debug("showList invoked.")
                    console.log("showList: " + page)
                
                    replyService.getList({//ajax처리값을 콜백받아서 넣어줌
                        bno:"${board.bno}", page: page || 1}, function (replyCnt, list) {
                            console.log("${board.bno}");
                            console.log("page: " + page);
                            console.log("replyCnt: " + replyCnt);
                            console.log("list: " + list);

                            if(page == -1){//EOF같이 -1로 지정하여 리스트 조회하게 함
                                currPage = Math.ceil(replyCnt / 10.0);
                                showList(currPage);
                                return;
                                
                            }//if
                            
                            var str="";

                            if(list == null || list.length == 0){//리스트값이 없을 때
                                replyUL.html("<p>등록된 댓글이 없습니다.</p>")

                                return;
                            }//if

                            for(var i = 0, len = list.length || 0; i < len; i++){
                                str +="<li class='left clearfix' data-reno='" + list[i].reno + "'>";
                                str +="<div><div class='header'><strong class='primary-font'>[" + list[i].reno + "] " + list[i].memberid + "</Strong>";
                                str +="<small class='pull-right text-muted'>" + replyService.displayTime(list[i].redate) + "</small></div>";
                                str +="<p class='replyLine'>" + list[i].recontent + "</p></div></li>";
                            }//for

                            replyUL.html(str);

                            showReplyPage(replyCnt); //페이징
                        });//end function
                }//showList()




                //==================== modal관련 객체 =====================//
                // 여러 함수에서 사용할 것이라서 바깥쪽에 빼둠 
                var modal = $(".modal");
                var modalInputRecontent = modal.find("input[name='recontent']");
                var modalInputMemberID = modal.find("input[name='memberid']");
                var modalInputReDate = modal.find("input[name='redate']");
                
                var modalModBtn = $("#modalModBtn");
                var modalRemoveBtn = $("#modalRemoveBtn");
                var modalRegisterBtn = $("#modalRegisterBtn");
                //==================== modal관련 객체 =====================//


                //NewReply버튼 클릭시 모달창을 띄운다
                $("#addReplyBtn").on("click", function (e) {
                    console.log("NewReply clicked.");

                    let loginId = $('input[name=memberid]').val();

                    if(loginId == '' || loginId == null) { //로그인 안됐을 때
                        e.preventDefault();
                        alert('로그인이 필요한 서비스입니다.');
                        
                    }else{ //로그인 됐을 때
                        modal.find("input[name=recontent]").val("");
                        modalInputReDate.closest("div").hide();
                        modal.find("button[id != 'modalCloseBtn']").hide();
                        
                        modalRegisterBtn.show();
                        
                        $(".modal").modal("show")
                    }//if-else

                    
                });//onclick


                //댓글등록 버튼
                modalRegisterBtn.on("click", function (e) {

                    var reply = {
                        recontent: modalInputRecontent.val(),
                        memberid: modalInputMemberID.val(),
                        bno:bnoValue
                    };
                
                    replyService.add(reply, function (result) {
                        alert('댓글이 등록되었습니다.');

                        modal.find('input[name=recontent]').val("");
                        modal.modal("hide");

                        // showList(1);
                        showList(1);
                    }); //add

                });//onclick
                
                //선택자로 ul태그 .chat을 넣었지만 실제이벤트 대상은 li이다
                //li클릭시 reno값 가져오기(data객체)
                //댓글 조회 클릭 이벤트 처리
                //댓글 상세창
                let listClick = $('.chat');

                listClick.click(function (event) {
                    x = event.pageX;
                    y = event.pageY;
                    

                    $('.modal-content').css('margin-top', y-200)
                });
                $(".chat").on("click", "li", function (e) {
                    console.log("list clicked.");

                    var memberid = "${__LOGIN__.memberid}";
                    
                    var reno = $(this).data("reno");

                    replyService.get(reno, function (replyVO) {
                        if(replyVO.memberid == memberid){//로그인아이디와 댓글작성자가 같을때
                            modalInputRecontent.val(replyVO.recontent);
                            modalInputMemberID.val(replyVO.memberid);
                            // modalInputReDate.val(replyService.displayTime(reply.redate)).attr("readonly", "readonly");
                            modal.data("reno", replyVO.reno);
    
                            modal.find('button[id=modalRegisterBtn').hide();
                            modalModBtn.show();
                            modalRemoveBtn.show();
    
                            $(".modal").modal("show");

                        }
                    })
                    console.log(reno);
                });//click li

                //댓글수정버튼
                modalModBtn.on("click", function (e) {
                    console.log("ModifyBtn clicked.");

                    var recontent = {reno:modal.data("reno"), recontent:modalInputRecontent.val()};

                    replyService.update(recontent, function (result) {
                        alert('댓글 수정완료');

                        modal.modal("hide");

                        showList(currPage);
                    });
                })//modalModBtn.onclick

                //댓글삭제버튼
                modalRemoveBtn.on("click", function (e) {
                    console.log("removeBtn clicked.");

                    var reno = modal.data("reno");

                    replyService.remove(reno, function (result) {
                        alert('정말 삭제하시겠습니까?');

                        modal.modal("hide");

                        showList(currPage);
                    });
                });
                

                var currPage = 1;                 //출력시킬 현재페이지번호
                var amount = 5;                   //한 페이지에 보여줄 댓글 수
                var replyPerPage = 10;            //각 페이지 아래에 보여줄, 페이지 번호목록의 길이

                var replyPageFooter = $(".panel-footer");
                
                function showReplyPage(replyCnt) {
                    console.debug("showReplyPage(replyCnt) invoked.");
                    console.log("\t+ replyCnt: " + replyCnt);

                    //끝페이지번호
                    var endPage = Math.ceil( (currPage * 1.0) / replyPerPage ) * replyPerPage;
                    
                    //현재페이지의 페이지번호목록의 시작번호 구하기
                    var startPage = endPage - (replyPerPage - 1);

                    //이전페이지목록 이동가능여부
                    var prev = startPage > 1;

                    //다음페이지목록 이동가능여부
                    var next = false;

                    if(endPage * amount >= replyCnt){//마지막페이지 x 한페이지갯수가 총댓글개수보다 클때
                        endPage = Math.ceil(replyCnt * 1.0 / amount);

                    }//if

                    if(endPage * amount < replyCnt){//총댓글개수보다 작을때
                        next = true;

                    }//if

                    var str = "<ul class='pagination pull-right'>";

                        if(prev){//1이 아닐때 li태그 생성
                            str += "<li class='page-item'><a class='page-link' href='" + (startPage -1) + "'>Previous</a></li>";

                        }//if

                        for(var i = startPage; i <= endPage; i++){//한페이지 첫번호부터 끝번호까지 순회 -> 페이지수 전달
                            var active = currPage == i ? "active" : "";

                            str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
                        }//for

                        if(next){
                            str += "<li class='page-item'><a class='page-link' href='" + (endPage + 1) + "'>Next</a></li>";
                        }//if

                        str += "</ul></div>";
                        
                        console.log(str);

                        replyPageFooter.html(str);
                        
                }//showReplyPage

                // 페이징버튼처리
                replyPageFooter.on("click", "li a", function (e) {
                    e.preventDefault();

                    console.debug("page clicked.");

                    var targetPageNum = $(this).attr("href");

                    console.log("targetPageNum: " + targetPageNum);//페이지당 지정된 숫자 얻기

                    currPage = targetPageNum;

                    showList(currPage);
                });//replyPageFooter


                let addReplyBtn = $('#addReplyBtn');

                addReplyBtn.click(function (event) {
                    x = event.pageX;
                    y = event.pageY;
                    

                    $('.modal-content').css('margin-top', y-150)
                });
                
                // function showCoords(event) {
                //     let x = event.clientX;
                //     let x = event.clientY;

                //     let coords = "X coords: " + x + ", Y coords: " + y
                // }
                
                        
            });//jq

        </script>

        <!-- 기존 javascript -->
        <script>
            
        </script>

        <style>
            *{
                margin: 0 auto;
                padding: 0;
                list-style: none;
            }

            #container1{
                width: 1200px;
                margin-top: 50px;
                font-weight: bold;
            }
            .clear{
                clear: both;
            }

            #title_area{
                border-bottom: 1px solid rgb(201, 201, 201);
                border-top: 3px solid #005bbb;
                height: 40px;
                line-height: 40px;
                font-size: 20px;
            }

            #title{
                margin-left: 10px;
                float: left;
                width: 70%;
            }
            
            #writer{
                float: right;
                width: 20%;
            }
            
            #date_area{
                background-color: #eee;
                font-size: 15px;
                height: 40px;
                line-height: 40px;

            }
            
            #register_date{
                margin-left: 10px;
                width: 85%;
                float: left;
            }

            #readCnt{
                width: 11%;
                float: right;
            }

            #top_space{
                margin-top: 10px;
            }

            #contents{
                min-height: 300px;
                border-top: 1px solid #eee;
                border-bottom: 1px solid #eee;
            }

            #wrote{
                padding: 30px 0 30px 10px;
                font-size: 15px;
                font-weight: bold;
            }   

            #content_img{
                margin: 0 auto;
            }
            .btn1 {
                width: 100px;
                height: 40px;

                border: 0;
                
                text-align: center;
                background: #005bbb;
                color: #fff;
                font-size: 15px;
                
                cursor: pointer;
            }

            #bottom_space{
                line-height: 50px;
                height: 50px;
            }
            #listBtn{
                margin-top: 5px;
                float: right;
            }
            /* -----------------------댓글 구분선------------------------ */
            .replyLine{
                border-bottom: 1px solid rgb(187, 187, 187, 0.3);
                height: 45px;

            }

            .space_input{
                height: 50px;
            }

            
            /* .modal-content{
                margin-top: 4700px;
            } */
            
        </style>
        
    </head>
    <body>


        <div id="container1">

            <!-- 제목, 작성자, 등록일, 수정일, 조회수 -->
            <div id="tables">
                <div id="title_area">
                    <div id="title">${board.title}</div>
                    <div id="writer">작성자 : ${board.memberid}</div>
                </div>
                <div class="clear"></div>
                
                <div id="date_area">
                    <div id="register_date">등록일 : <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${board.insert_ts}" /></div>
                    <div id="readCnt">조회수 : ${board.readcnt+1}</div>
                </div>
            </div>
            <div id="top_space"></div>

            <!-- 콘탠츠내용, 이미지 -->
            <div id="contents">
                <p id="wrote">
                    ${board.content} <br>
                </p>
                <div id="content_img">
                    <img src="/fileupload/${photo.fpath}${photo.frename}" alt="이미지">
                </div>
                <div class="space_input"></div>
            </div>


            <!-- 글수정, 답변, 목록 버튼 -->
            <!-- <div id="bottom_space">
                <div id="btn_area">
                    <button type="button" class="btn" id="modifyBtn">글 수정</button>
                    <button type="button" class="btn" id="listBtn">목록</button>
                </div>
            </div> -->
        
        </div>            

            <!-- 댓글 -->
            <div class="row">
                <div class="col-lg-12">
                    
                    <!-- /.panel -->
                    <div class="panel panel-default">

                        <div class="panel-heading">
                            <i class="fa fa-comments fa-fw"></i>Reply
                            <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">NewReply</button>
                        </div>
                        
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <ul class="chat">
                                <!-- start reply -->
                                <li class="left clearfix" data-reno="10">
                                    <div>
                                        <div class="header">
                                            <strong class="primary-font"></strong>
                                            <small class="pull-right next-muted"></small>
                                        </div>
                                        <p>등록된 댓글이 없습니다.</p>
                                    </div>
                                </li>
                                <!-- end reply -->
                            </ul>
                            <!-- ./end ul -->
                        </div>
                        <!-- /.panel .chat-panel -->
                        <div class="panel-footer">
                            
                        </div>
                    </div>
                </div>
                <!-- ./end row -->
            </div>


            <!-- Modal창 -->
            <div 
            class="modal fade" 
            id="myModal" 
            tabindex="-1" 
            role="dialog" 
            aria-labelledby="myModalLabel"
            aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button 
                                type="button" 
                                class="close" 
                                data-dismiss="modal" 
                                aria-hidden="true">&times;</button>
                            <h4 class="modal-title" id="myModalLabel">댓글</h4>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>내용</label>
                                <input class="form-control" name="recontent" placeholder="내용을 입력하세요" required>
                            </div>
                            <div class="form-group">
                                <label>작성자</label><br>
                                <input type="hidden" class="form-control" name="memberid" value="${__LOGIN__.memberid}">${__LOGIN__.memberid}
                            </div>
                            <div class="form-group">
                                <!-- <label>작성일자</label> -->
                                <input type="hidden" class="form-control" name="redate" value="">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="modalModBtn" type="button" class="btn btn-warning">수정</button>
                            <button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
                            <button id="modalRegisterBtn" type="button" class="btn btn-default">등록</button>
                            <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        </div>
                    </div>
                    <!-- modal-content/ -->
                </div>
                <!-- modal-dialog -->
            </div>
            <!-- modal -->
            
        </div>
    </body>
</html>