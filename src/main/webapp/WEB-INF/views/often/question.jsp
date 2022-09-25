<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>
    
 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/question.css">
    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
	<script src="/resources/js/top.js"></script>
</head>


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
                <h2 class="asideMenu">커뮤니티</h2>
                <ul id="parent">
                    <li><a class="chk" href="/notice/list">공지사항</a></li>
                    <li><a class="chk" href="/question/list">질문게시판</a></li>
                    <li><a class="chk" href="/often/question">자주묻는질문</a></li>
                    <li><a class="chk" href="/anony/list">고객의소리</a></li>
                    <li><a class="chk" href="/free/board">자유게시판</a></li>
                    <li><a class="chk" href="/event/listPerPage">이벤트</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 고객센터 > 자주묻는질문 </div>
                    <h2 class="subName">자주묻는질문</h2>
                </div>
                <div class="contentIn">
                    <div id="topmenu">
                        <p>자주묻는질문</p> 
                        <span>Q&A</span>
                    </div>

                    <div class="radioCheck">
                        <div class="radioTop">
                        <input type="radio" name="tabmenu" id="tab01" checked>
                         <label for="tab01">기업회원</label>
                        <input type="radio" name="tabmenu" id="tab02">
                         <label for="tab02">공통회원</label>
                 

                        <div class="container con1">
                            <!-- <button id="btn-collapse">닫기</button> -->
                            <section id="Question">
                                     <div class="panel-question active">
                                        <div class="panel-heading">
                                            Q 인터넷 사용가능 한지 알고 싶습니다.
                                            </div>
                                            <div class="panel-body" id="thisone">
                                                <p>네, 사용 가능합니다. 전시장 내에서 무료로 와이파이를 제공하고 있습니다. 그러나 참관객이 많으면 사용이 불가능할수도 있습니다</p>
                                            </div>
                                     </div>
                            <!--------------------------------------------------------------------------------->
                                    
                                        <div class="panel-question">
                                            <div class="panel-heading">
                                                Q 전시회 참가업체인데 협찬을 하고 싶습니다. 어떻게 하면 되나요?
                                            </div>
                                            <div class="panel-body">
                                                <p>A 홈페이지 자료실에서 협찬신청서 다운로드 및 작성 후 서식에 기재되어 있는 메일로 제출해주시기 바랍니다.</p>
                                            </div>
                                        </div>
                            <!--------------------------------------------------------------------------------->                                  
                                        <div class="panel-question">
                                            <div class="panel-heading">
                                                Q 간판명 및 슬로건의 글자수가 모자랍니다. 어떻게 해야 하나요?
                                            </div>
                                            <div class="panel-body" >
                                                <p>A 글자 수가 넘어가는 기업은 031-259-6539 으로 연락 부탁드립니다.</p>
                                            </div>
                                        </div>
                            <!--------------------------------------------------------------------------------->
                                
                            
                                        <div class="panel-question">
                                            <div class="panel-heading">
                                                Q 부스 수를 변경하고 싶습니다. 어떻게 해야 하나요?
                                            </div>
                                            <div class="panel-body">
                                                <p>A 부스 수 변경을 원하시는 기업은 031-259-6151/2 으로 연락 부탁드립니다.</p>
                                            </div>
                                        </div>    
                                        
                            <!--------------------------------------------------------------------------------->
                                
                            
                                <div class="panel-question">
                                    <div class="panel-heading">
                                        Q 부대시설 신청을 변경하고 싶습니다. 어떻게 해야 하나요?
                                    </div>
                                    <div class="panel-body">
                                        <p>A 부대시설을 변경을 원하시는 기업은 031-259-6537 으로 연락 부탁드립니다.</p>
                                    </div>
                                </div>   
                            
                            <!--------------------------------------------------------------------------------->
                                
                            
                                <div class="panel-question">
                                    <div class="panel-heading">
                                        Q 로고는 어떻게 진행 됩니까?
                                    </div>
                                    <div class="panel-body">
                                        <p>A 로고삽입은 불가능합니다.</p>
                                    </div>
                                </div>   
                        
                            <!--------------------------------------------------------------------------------->
                                
                            
                                <div class="panel-question">
                                    <div class="panel-heading">
                                        Q 가구 및 비품 렌탈 신청은 어떻게 하나요?
                                    </div>
                                    <div class="panel-body">
                                        <p>A 부대시설을 변경을 원하시는 기업은 031-259-6537 으로 연락 부탁드립니다.</p>
                                    </div>
                                </div>   
                            
                            <!--------------------------------------------------------------------------------->
                                
                            
                                <div class="panel-question">
                                    <div class="panel-heading">
                                        Q 부스 임대는 어떻게 되나요?
                                    </div>
                                    <div class="panel-body">
                                        <p>A. G-FAIR KOREA 가구/비품 임대서비스 업체 홈페이지 안내드립니다. (모둘:www.modul.co.kr / 더퍼스트 :www.thefirstpro.co.kr)</p>
                                    </div>
                                </div>   
                            
                            <!--------------------------------------------------------------------------------->
                                
                            
                                <div class="panel-question">
                                    <div class="panel-heading">
                                        Q 부스 배치는 어떻게 되나요?
                                    </div>
                                    <div class="panel-body">
                                        <p>A 전시품목 및 전시 효과와 효율적인 참관객 동선을 고려하여 주관사가 부스를 임의배정 후 참가업체 통보를 원칙으로 합니다.</p>
                                    </div>
                                </div>   
                            
                            <!--------------------------------------------------------------------------------->
                                
                            
                                <div class="panel-question">
                                    <div class="panel-heading"> 
                                        Q 참가업체는 무엇을 준비해야 하나요?
                                    </div>
                                    <div class="panel-body">
                                        <p>A 전시품, 부스내부인테리어, 전시품목, 카달로그, 명함, 상담일지 등을 준비하시면 됩니다.</p>
                                    </div>
                                </div>   
                            
                            <!--------------------------------------------------------------------------------->
                                
                            
                                <div class="panel-question">
                                    <div class="panel-heading">
                                        Q 박람회에서 어떤 프로그램이 진행되나요?
                                    </div>
                                    <div class="panel-body">
                                        <p>A. G-FAIR KOREA(대한민국 우수상품 전시회)에서는 국내 중소기업 1,000개사 1,200개 부스가 참가하는 전시회와 부대행사(구매상담회, 수출상담회, 세미나, 이벤트 행사)로 구성됩니다. 자세한 사항은 홈페이지에서 전시회소개와 부대행사를 참고해주세요.</p>
                                    </div>
                                </div>   
                            
                                <div class="panel-question">
                                    <div class="panel-heading">
                                        Q 독립부스 시공은 자체적으로 해도 되나요?
                                    </div>
                                    <div class="panel-body">
                                        <p>A 독립부스는 참가사가 주관자로부터 전시면적만 제공받아 킨텍스에 등록된 장치공사업체 중 선정할 수 있습니다.</p>
                                    </div>
                                </div>   


                            </section> <!-- Question close-->
                        </div> <!--container con1-->
                    
                        <!-- -------------------------------------------------- -->
                        <!-- -------------------------------------------------- -->
                        <!-- -------------------------------------------------- -->
                        <div class="container con2">
                            <!-- <button id="btn-collapse">모두 닫기</button> -->
            
                            <section id="Question">
                                <div class="panel-question active">
                                    <div class="panel-heading2">
                                        Q 온라인 아이디,비번을 잃어버렸어요.
                                    </div>
                                        <div class="panel-body" id="thisone">
                                            <p>A. 아이디와 비밀번호가 확인이 안 될 경우 031-259-6299번으로 문의주시길 바랍니다.</p>
                                        </div>
                                </div>
                    
                            
                    <!--------------------------------------------------------------------------------->
                            
                                <div class="panel-question">
                                    <div class="panel-heading2">
                                        Q 관람비용이 있나요?
                                    </div>
                                        <div class="panel-body">
                                            <p>A. 입장료는 5,000원이며 인터넷 사전등록 시 무료입니다.</p>
                                        </div>
                                </div>
                    <!--------------------------------------------------------------------------------->
                               
                                <div class="panel-question">
                                    <div class="panel-heading2">
                                        Q 부대시설은 어디로 문의해야 하나요?
                                    </div>
                                        <div class="panel-body" >
                                            <p>A G-FAIR KOREA 사무국(Tel. 031-259-6539)으로 문의하시면 됩니다.</p>
                                        </div>
                                </div>
                     <!--------------------------------------------------------------------------------->
                        
                    
                                <div class="panel-question">
                                    <div class="panel-heading2">
                                        Q 어떤 분야의 박람회인가요?
                                    </div>
                                        <div class="panel-body">
                                            <p>A. G-FAIR KOREA(대한민국 우수상품 전시회)는 중소기업의 우수상품을 전시하는 박람회로 농수식품, 건축/인테리어, 레저용품, 패션/주얼리, 미용/화장품, 선물용품, 전기전자/IT, 창업/혁신제품, 기타관으로 특화된 박람회입니다.</p>
                                        </div>
                                </div>    
                                
                     <!--------------------------------------------------------------------------------->
                        
                    
                                <div class="panel-question">
                                    <div class="panel-heading2">
                                        Q 전시장 위치가 어디입니까?
                    
                                    </div>
                                        <div class="panel-body">
                                            <p>A. G-FAIR KOREA 2021 전시장은 지하철3호선 대화역 1번출구 킨텍스 제1전시장 1~3홀입니다.</p>
                                        </div>
                                </div>   
                    
                     <!--------------------------------------------------------------------------------->
                        
                    
                            <div class="panel-question">
                                <div class="panel-heading2">
                                    Q 관람시간은 언제입니까?
                                </div>
                                    <div class="panel-body">
                                        <p>A. G-FAIR KOREA 2021 관람시간은 10월 31일부터 11월 03일까지10:00~18:00 입니다.</p>
                                    </div>
                                </div>   
                            </div>            
                        </div>   
                    </div> <!-- radioCheck -->
                </div> <!--컨텐츠 -->
            </div>
        </section>
        </div>
            </div>
        </div>

   	<span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>

<script>
var pannelQuestion = document.querySelectorAll('.panel-question');
var CollapseBtn = document.querySelector('#btn-collapse');
// pannelQuestion을 클릭하면 모든 pannelQuestion의 active만 제거하고 클린한 pannelQuestion에만 active를 추가한다. 

for(var i =0 ; i<pannelQuestion.length; i++){
    pannelQuestion[i].addEventListener('click',function () {
 
        closeAll();
        this.classList.add('active');

    });
}

CollapseBtn.addEventListener('click',function () {
    closeAll();

});

function closeAll(){
    for(var x = 0; x<pannelQuestion.length; x++){
            pannelQuestion[x].classList.remove('active');    
    }
}


</script>
</html>