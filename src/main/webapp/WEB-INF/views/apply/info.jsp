<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>지페어 코리아</title>

	<link href="/resources/css/introparticipate.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
    <script src="/resources/js/fullnav.js"></script>
    <script src="/resources/js/top.js"></script>

</head>

<style>

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
                <h2 class="asideMenu">참가안내</h2>
                <ul id="parent">
                    <li><a class="chk" href="/apply/info">참가신청안내</a></li>
                    <li><a class="chk" href="/apply/app">참가신청</a></li>
                    <li><a class="chk" href="/apply/applystatus">참가신청확인</a></li>
                    <li><a class="chk" href="/apply/rule">참가규정</a></li>
                    <li><a class="chk" href="/apply/booth">부스안내</a></li>
                    <li><a class="chk" href="/apply/map">전시장배치도</a></li>
                    <li><a class="chk" href="/apply/companyList">참가기업목록</a></li>
                </ul>

            </div>
            <div id="content">
                <div class="title">
                    <div class="map">home > 참가안내 > 참가신청안내 </div>
                    <h2 class="subName">참가신청안내</h2>
                </div>
                         <div class="contentIn">
                    <div id="topmenu">
                        <p>참가신청 안내</p> 
                        <span>About Participate G-fair</span>
                    </div> <!--top메뉴-->

                    <div class="Box">
                        <div class="participateBox1">
                            <div class="boxMenu">
                                <p>모집분야</p> 
                            </div> <!--top메뉴-->   
                            <div class="participateArea" id="participateArea1">
                                <img src="/resources/img/participate_sofa.png" height="120px">
                                <div class="participateAreaBox">
                                    <span>생활용품관 Living</span>
                                    <p>영 유아용품, 문구류, 인테리어, 가구, 패브릭, 홈데코, 조명, 반려동물용품, 생활가전, 아이디어상품, IT상품 등</p>
                                </div>
                            </div>

                            <div class="participateArea" id="participateArea2">
                                <img src="/resources/img/participate_healthcare.png" height="120px">
                                <div class="participateAreaBox">
                                    <span>건강용품관 Health care</span>
                                    <p>헬스케어, 수면, 레저, 스포츠, 건강기능식품, 여행용품, 의약품, 위생용품 등</p>
                                </div>
                            </div>
                            <div class="participateArea" id="participateArea3">
                                <img src="/resources/img/participate_dish.png" height="120px">
                                <div class="participateAreaBox">
                                    <span>주방용품관 Dining</span>
                                    <p>농축산물 유기농식품, 가공식품, 주방용품, 조리기구, 제빵기구, 식기류 등</p>
                                </div>
                            </div>
                            <div class="participateArea" id="participateArea4">
                                <img src="/resources/img/participate_beauty.png" height="120px">
                                <div class="participateAreaBox">
                                    <span>뷰티용품관 Beauty</span>
                                    <p>화장품, 미용 용품, 의류, 가방, 벨트, 지갑, 악세사리, 쥬얼리 등</p>
                                </div>
                            </div>
                            
                        </div>

                        <div class="participateBox2">
                            <div class="boxMenu">
                                <p>전시참가절차</p> 
                            </div> <!--top메뉴-->   
                            <div class="participateCourse">
                                <ul class="participateCourseWrap">
                                    <li class="course1">
                                        <div class="courseBox">
                                            <div class="contentBox">
                                                <span>&nbsp;참가 신청</span>
                                                    <br>
                                                    <br>
                                                <p>&nbsp;&nbsp;온라인 신청</p>
                                                
                                            </div>    
                                        </div>
                                    </li>
                                    <li class="course2">
                                        <div class="courseBox">
                                            <div class="contentBox">
                                                <span>&nbsp;참가 확정</span>
                                                    <br>
                                                    <br>
                                                <p>참가비 납부 기준</p>
                                             
                                            </div>    
                                        </div>
                                    </li>
                                    <li class="course3">
                                        <div class="courseBox">
                                            <div class="contentBox">
                                                <span>마케팅홍보</span>
                                                    <br>
                                                    <br>
                                                <p>&nbsp;&nbsp;유치 및 홍보</p>
                                              
                                            </div>    
                                        </div>
                                    </li>
                                    <li class="course4">
                                        <div class="courseBox">
                                            <div class="contentBox">
                                                <span>전시회 참가</span>
                                                    <br>
                                                    <br>
                                                <p>10월 중 OPEN</p>
                                            </div>    
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="participateBox3">
                            <div class="boxMenu">
                                <p>부스 및 참가비 안내</p> 
                            </div> <!--top메뉴-->
                            <div class="tableBox">
                                <table  id="participateBox3_table">
                                    <thead>
                                        <th>
                                            <tr>
                                                <td rowspan="2">규격</td>
                                                <td rowspan="2">단위</td>
                                                <td rowspan="2">제공내역</td>
                                                <td colspan="3">가격(VAT 별도)</td>
                                                <td rowspan="2">비고</td>
                                            </tr>
                                            
                                            <tr>
                                                <td>~5월 31일</td>
                                                <td>~9월 31일</td>
                                                <td>정 가</td>   
                                            </tr>
                                        </th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>조립부스</td>
                                            <td>1부스</td>
                                            <td>
                                                <p>면적+ 기본조립(부스벽체),바닥(파이텍스),상담테이블 1</p> 
                                                <p>의자3조, 전기1kw, 조명, 콘센트(2구 1개),
                                                <p>상호간판, 안내데스크접의자1 </p>
                                            </td>
                                            <td>
                                                <p>1,600,000원</p>
                                                <p class="colorP1">(100만원 할인)</p>
                                            </td>
                                            <td>
                                                <p>2,000,000원</p>
                                                <p class="colorP2">(60만원 할인)</p>
                                            </td>
                                            <td>
                                                <p>2,600,000원</p>
                                            </td>

                                            <td>주최측 제공 기본부스</td>
                                        </tr>

                                        <tr>
                                            <td>독립부스</td>
                                            <td>1부스</td>
                                            <td>
                                                <p>면적만 제공(면적 이외의 사항은 자체부담)</p> 
                                            
                                            </td>
                                            <td>
                                                <p>1,200,000원</p>
                                                <p class="colorP1">(100만원 할인)</p>
                                            </td>
                                            <td>
                                                <p>1,600,000원</p>
                                                <p class="colorP2">(60만원 할인)</p>
                                            </td>
                                            <td>
                                                <p>2,200,000원</p>
                                            </td>

                                            <td>4부스 이상 신청가능</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>   
                            <div class="tableBottom">
                                <ul>
                                    <li>
                                        <p><strong>연속 재참가 기업 할인 :</strong> ('20년 참가)20만원 / ('19년,'20년 참가)40만원 / ('18년,'19년'20년 참가) 60만원</p>
                                        <p><strong>경기도 기업 할인 :</strong> (~5월31일까지 신청 시) 40만원 / (~9월 30일까지 신청시) 20만원 </p>
                                        <p><strong>부스 유형별 하한액(중복 할인 가능):</strong> (~5월31일) 조립부스 100만원 독립부스 80만원/(~9월 30일) 조립부스 160만원, 독립부스 140만원</p>

                                    </li>
                                </ul>

                            </div>
                        </div>
                        
                        <div class="participateBox4">
                            <div class="boxMenu">
                                <p>부대시설 사용비용 (부가세 포함)</p> 
                            </div> <!--top메뉴-->   
                            <div class="tableBox2">
                                <table  id="participateBox4_table">
                                    <thead>
                                        <tr>
                                            <th>항목</th>
                                            <th>단위(구분)</th>
                                            <th>금 액</th>
                                            <th>비고</th>
                                        </tr>
                                        <tr>
                                            <td rowspan="2">전기</td> 
                                            <td>
                                                <p>단상 220V/60Hz kw</p>
                                                <p>삼상 220V/60Hz kw</p>
                                                <p>삼상 220V/60Hz kw</p>
                                            </td>
                                            <td>55,000원</td> 
                                            <td>
                                                <p>*기본부스는 부스 당 1kw 무료제공</p>
                                                <p>*별도의 기계장비를 사용하지 않으시면 단상220V를 신청하시기 바랍니다.</p>
                                                <p>*전력 제공시간 : 09:00~17:00</p>
                                            </td> 
                                        </tr>
                                        <tr >
                                            <td>24시간</td>
                                            <td>110,000원</td> 
                                            <td>전력 제공시간 :24시간</td> 
                                        </tr>

                                        <tr>
                                            <td rowspan="3">전화</td> 
                                            <td>국내 1회선</td>
                                            <td>55,000원</td> 
                                            <td></td> 
                                        </tr>
                                        <tr >
                                            <td>국제 1회선</td>
                                            <td>88,000원</td> 
                                            <td>초과비용 발생 시 별도청구</td> 
                                        </tr>
                                        <tr>
                                            <td colspan="3">※ 설치비용 포함, 국내전화 사용료는 별도 정산 없이 전시기간 내 사용가능</td>
                                        </tr>

                                        <tr>
                                            <td>인터넷</td>
                                            <td>1 port</td> 
                                            <td>220,000원</td> 
                                            <td rowspan="3">※ 제공시간 : 09:00~17:00</td> 
                                        </tr>

                                        <tr>
                                            <td>급배수</td>
                                            <td>1식</td> 
                                            <td>330,000원</td> 
                                        </tr>
                                        <tr>
                                            <td>압축공기</td>
                                            <td>1식</td> 
                                            <td>250,000원</td> 
                                        </tr>      
                                    </thead>
                                </table>
                            </div>
                            <div class="tableBottom">
                                <p><strong>* 독립부스 신청기업은 전기사용 시 별도 신청을 바랍니다.</strong></p>
                                <p><strong>* 상기 금액은 20년 대행용역사 선정 후 변경될 수 있습니다.</strong></p>
                            </div>
                        </div>

                        <div class="participateBox5">
                            <div class="boxMenu">
                                <p>신청접수</p> 
                            </div> <!--top메뉴-->
                            <div class="participateBox5_inner" id="inner1">
                                <div id="innerHead"><p>신청 방법</p></div>
                                <div id="innerBody">
                                    <p>홈페이지(www.gfair.or.kr)내 회원사 사입 후 온라인 신청</p>
                                    <p>참가신청서, 사업자등록증, 디렉토리(광고) 게재 신청서 등을 직접 입력</p>
                                    <div><a href="/apply/app">참가신청
                                                    <br>
                                                     바로가기</a></div>
                                </div>
                            </div>   
                            <div class="participateBox5_inner" id="inner2">
                                <div id="innerHead">
                                    <p> &nbsp; 참가비 
                                        <br>
                                         납부방법</p>
                                    
                                </div>
                                <div id="innerBody">
                                    <p>참가신청 완료 후 기업명으로 입금계좌 납입</p>
                                    <p>* 농협 301-0283-4669-41 (예금주: 경기도경제과학진흥원)</p>
                                </div>
                            </div>    
                        </div>
                    </div>
                </div><!--content in-->
            </div>
        </div>

   <span id="top_btn">top</span>
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
    </div> <!--wrap-->
</body>
</html>