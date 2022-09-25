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
        <title>/anony/get.jsp</title>
		
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js" referrerpolicy="no-referrer"></script>

        <script type="text/javascript" src="/resources/js/replies.js"></script>

        <!-- 부트스트랩 -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

        <link rel="stylesheet" href="../resources/css/anonyGetPage.css">

        <script>
            $(function(){

                // // 버튼클릭관련
                // $('#reregBtn').on('click',function(){
                    
                //     window.parent.location.href = "/anony/retrieve?title=${board.title}&reproot=${board.reproot}&repstep=${board.repstep}&repindent=${board.repindent}&bname=${board.bname}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
                    
                // });//reregBtn
                
                // $('#modifyBtn').on('click',function() {
                    
                //     window.parent.location.href = "/anony/modify?bno=${board.bno}&bname=${board.bname}&readcnt=${board.readcnt}&currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
                    
                // })//modifyBtn

                // $('#listBtn').on('click',function(){
                    
                //     window.parent.location.href = "/anony/list?currPage=${cri.currPage}&amount=${cri.amount}&pagesPerPage=${cri.pagesPerPage}";
                    
                // });//listBtn

           

                 // 댓글관련 처리
                var bnoValue = "${board.bno}";
                var replyUL = $('.chat');//댓글 내용 기입된 ul태그

                

                var amount = 5;//한페이지에 보여주는 댓글 개수
                var pagesPerPage = 10;//한페이지에 보여주는 페이지수

                var pageNum = 1;
                var replyPageFooter = $('.panel-footer');

                function showReplyPage(replyCnt){
                    var endNum = Math.ceil(pageNum * 1.0 / pagesPerPage) * pagesPerPage;
                    var startNum = endNum - ( pagesPerPage - 1 );

                    var prev = startNum != 1;
                    var next = false;

                    if( endNum * amount >= replyCnt ){//마지막페이지 x 한페이지갯수가 총댓글개수보다 클때
                        endNum = Math.ceil(replyCnt * 1.0 / amount );
                    }//if

                    if( endNum * amount < replyCnt ){//총댓글개수보다 작을때
                        next = true;
                    }//if

                    let str = "<ul class='pagination pull-right'>";

                    if(prev){//1이 아닐때 li태그 생성
                        str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
                    }//if

                    for(var i = startNum; i <= endNum; i++){//한페이지 첫번호부터 끝번호까지 순회 -> 페이지수 전달
                        var active = ( pageNum == i ) ? "active" : "";

                        str += "<li class='page-item "+active+"'><a class='page-link' href='"+i+"'>"+i+"</a></li>";
                    }//for

                    if(next){
                        str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
                    }//if
                    
                    str += "</ul></div>";

                    console.log(str);

                    replyPageFooter.html(str);

                }//showReplyPage

                // 페이징버튼처리
                replyPageFooter.on('click','li a',function(e){
                    e.preventDefault();

                    var targetPageNum = $(this).attr('href');//페이지당 지정된 숫자 얻기

                    pageNum = targetPageNum;

                    showList(pageNum);
                })//replyPageFooter




                showList(1);//첫페이지 기본으로 보여줌

                function showList(page){
                    replyService.getList({bno:bnoValue,page:page||1},function(list,replyCnt){//ajax처리값을 콜백받아서 넣어줌
                        console.log(list);

                        if(page == -1){//EOF같이 -1로 지정하여 리스트 조회하게 함
                            pageNum = Math.ceil(replyCnt*1.0)*pagesPerPage;
                            showList(pageNum);
                            return;
                        }//if


                        let str = "";
                        if(list == null|| list.length == 0){//리스트값이 없을 때
                            replyUL.html("<p>등록된 댓글이 없습니다.</p>");

                            return;
                        }//if

                        for (const replyE of list) {
                            str += "<li class='left clearfix' data-reno='"+replyE.reno+"'>";
                            str += "    <div><div class='header'><strong class='primary-font'>"+replyE.memberid+"</strong>";
                            str += "        <small class='pull-right text-muted'>"+replyService.displyTime(replyE.redate)+"</small></div>";
                            str += "        <p class='replyLine'>"+replyE.recontent+"</p></div></li>";
                        }//for

                        replyUL.html(str);

                        showReplyPage(replyCnt);//페이징

                    });//getList
                }//showList

                var modal = $(".modal");
                var modalInputReply = modal.find("input[name=recontent]");
                var modalInputReplyer = modal.find("input[name=memberid]");
                var modalInputReplyDate = modal.find("input[name=redate]");

                var modalModBtn = $("#modalModBtn");
                var modalRemoveBtn = $("#modalRemoveBtn");
                var modalRegisterBtn = $("#modalRegisterBtn");

                //댓글창버튼
                $("#addReplyBtn").on('click',function(e){

                    let loginId = '${__LOGIN__.memberid}';
                    if(loginId == null || loginId == ''){//회원정보가 없을 때
                        alert("로그인 정보가 없습니다.");

                        return false;
                    }else{//로그인했을 때
                        
                        modal.find('input[name=recontent]').val('');
                        modalInputReplyDate.closest("div").hide();
                        modal.find('button[id != "modalCloseBtn"]').hide();
                        
                        modalRegisterBtn.show();
                        
                        $('.modal').modal('show');
                    }

                })//addReplyBtn


                //댓글등록 버튼
                modalRegisterBtn.on('click',function(e){
                    
                    var reply = {
                        recontent : modalInputReply.val(),
                        memberid : modalInputReplyer.val(),
                        bno : bnoValue
                    };

                    replyService.add(reply, function(result){
                        // alert(result);

                        modal.find('input[name=recontent]').val("");
                        modal.modal("hide");

                        showList(1);
                    });//add

                })//modalRegisterBtn


                //댓글 상세창
                $(".chat").on('click','li',function(e){
                    var memberid = "${__LOGIN__.memberid}";
                    console.log("memberid",memberid)    

                    var reno = $(this).data('reno');

                    console.log(reno);

                    replyService.get(reno, function(replyVO){//vo반환받은 값 넣기

                        if(replyVO.memberid == memberid){//로그인아이디와 댓글작성자가 같을때

                            modalInputReply.val(replyVO.recontent);

                            modalInputReplyer.val(replyVO.memberid);
                            // modalInputReplyDate.val(replyService.displyTime(reply.redate));
                            modal.data('reno',replyVO.reno)
                            
                            modal.find('button[id=modalRegisterBtn').hide();
                            modalModBtn.show();
                            modalRemoveBtn.show();
                            
                            $('.modal').modal("show");
                        }

                    })//get
                })//chat


                // 댓글수정버튼
                modalModBtn.on('click',function(){

                    var reply = {reno:modal.data('reno'), recontent:modalInputReply.val()};

                    replyService.update(reply, function(result){
                        alert(result);

                        modal.modal("hide");
                        showList(pageNum);
                    })//update
                })//modalModBtn


                //댓글삭제버튼
                modalRemoveBtn.on('click',function(){
                    var reno = modal.data('reno');

                    let result = confirm("정말 삭제하시겠습니까?")

                    if(result){
                        replyService.remove(reno, function(result){
                            // alert(result);
                            modal.modal('hide');
                            showList(pageNum);
                        })//remove

                    }//if
                })//modalRemoveBtn

                //모달창 위치조정
                let addReplyBtn = $('#addReplyBtn');

                addReplyBtn.click(function (event) {
                    x = event.pageX;
                    y = event.pageY;
                    

                    $('.modal-content').css('margin-top', y-150)
                });
            })//.Jq
        </script>
    </head>
    <body id="getPageIfm">
        <div id="getPage">
            <div class="subjectLine">
                <!-- 글제목 -->
                <div class="subject">
                    <p>&nbsp;${board.title}</p>
                    <!-- 작성자 공개/비공개 -->
                    <c:choose>
                        <c:when test="${board.public_tf eq 'T'.toString()}">
                            <p>비공개&nbsp;</p>
                        </c:when>
                        <c:otherwise>
                            <p>작성자:${board.memberid}&nbsp;</p>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- 등록일 / 수정일 / 조회수-->
                <div class="regDate">
                    <p>
                        &nbsp;등록일:<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${board.insert_ts}"/>
                        <c:if test="${board.update_ts != null}">
                            &nbsp;&nbsp;&nbsp;수정일:<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${board.update_ts}"/>
                        </c:if>
                    </p>
                    
                    <p>조회수:${board.readcnt}&nbsp;</p>
                </div>
            </div>
            <!-- 내용 -->
            <div class="content">
                <div>${boardFileVO.content}</div>
                
                    <c:if test="${boardFileVO.frename != null && boardFileVO.frename != '0'}">
                        <img class="imgcontent" src= '/fileupload/${boardFileVO.fpath}/${boardFileVO.frename}_${boardFileVO.forname}'>
                    </c:if>
                
            </div>
        </div>
            
    <!-- ----댓글---------------------------------------------------------------------------------------------- -->
        <div class="row">
            <div class="col-lg-12">
                <!-- panel -->
                <div class="panel panel-default">
                    <!-- panel-heading -->
                    <div class="panel-heading">
                        <i class="fa fa-comments fa-fw"></i>댓글
                        <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">댓글등록</button>
                    </div>

                    <!-- panel-body -->
                    <div class="panel-body">
                        <ul class="chat">
                            <!-- start reply -->
                            <li class="left clearfix" data-reno='12'>
                                <div>
                                    <div class="header">
                                        <strong class="primary-font"></strong>
                                        <small class="pull-right text-muted"></small>
                                    </div>
                                    <p>등록된 댓글이 없습니다.</p>
                                </div>
                            </li>
                            <!-- end reply -->
                        </ul>
                        <!-- end ul -->
                    </div>
                    <!-- panel-footer -->
                    <div class="panel-footer">

                    </div>
                </div>
                <!-- end panel -->
            </div>
        </div>
        <!-- end row -->   

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
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
                        <button id="modalRegisterBtn" type="button" class="btn btn-default" data-dismiss="modal">등록</button>
                        <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                    </div>
                </div>
                <!-- modal-content -->
            </div>
            <!-- modal-dialog -->
        </div>
        <!-- modal -->
    <!-- -------------------------------------------------------------------------------------------------- -->
        
        <!-- <div class=getBtn>
            <div>
                <c:if test="${__LOGIN__.memberid eq board.memberid}">
                        <button type="button" class="buttonstyle" id="modifyBtn">수정</button>
                </c:if>
                <c:if test="${__LOGIN__.memberid != null}">
                    <button type="button" class="buttonstyle" id="reregBtn">답글</button>
                </c:if>
            </div>
            <div>
                <button type="button" class="buttonstyle" id="listBtn">목록</button>
            </div>
        </div> -->
    </body>
</html>