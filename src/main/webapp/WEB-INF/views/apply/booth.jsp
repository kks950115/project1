<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>부스안내</title>

        <link href="/resources/css/common.css" rel="stylesheet" type="text/css" />
        <link href="/resources/css/sub.css" rel="stylesheet" type="text/css" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.3.2/jquery-migrate.min.js"></script>
        <script src="/resources/js/fullnav.js"></script>
    	<script src="/resources/js/top.js"></script>

        <style>
            th{
                text-align: center;
                height: 40px;
            }
            thead, tbody{
                height: 40px;
            }

            .bottom_space{
                margin-bottom: 50px;
            }

            .h3_booth_info{
                /* background-image: url(/resources/img/h3_bul.jpg); */
                background-position: 0 12px;
                background-repeat: no-repeat;
                padding: 5px 23px 5px 0;
                font-size: 30px;
                color: #222;
                font-weight: bold;
                margin-bottom: 5px;
            }

            .tb_type1 table{
                font-size: 15px;
                width: 100%;
                border-collapse: collapse;
                border-top: 2px solid #005bbb;
            }

            .h3_bul{
                margin-top: 15px;
                margin-right: 10px;
            }

            .color1{
                color: #f6494c;
            }

            .basic_list > li{
                font-size: 20px;
                font-weight: bold;
            }

            .white_box3{
                border: 1px solid ;
                padding: 15px 15px 15px 15px; 
            }

            .background_color{
                background-color: #eee;
            }

            .booth_type{
                
                text-align: center;
                width: 150px;
                height: 40px;
            }

            .booth_unit{
                text-align: center;
                width: 80px;
                height: 40px;
            }
            
            .booth_standard{
                text-align: center;
                width: 90px;
                
            }

            .booth_standard1{
                text-align: center;
                width: 400px;
                
            }

            .booth_note{
                text-align: center;
            }
            .supply{
                text-align: center;
                width: 400px;
                height: 40px;
            }

            .amount{
                text-align: center;
                width: 80px;
            }

            .number{
                font-size: 15px;
                margin-bottom: 5px;
            }

            .booth_img{

                margin-top: 30px;
                margin-bottom: 30px;
            }

            .img_center{
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .p_content{
                font-size: 16px;
            }
        </style>

        <script>
            $(function () {
                console.clear();
                console.debug('jq started.');

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
                
            });
        </script>
    </head>

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
                            <div class="map">home > 참가안내 > 부스안내 </div>
                            <h2 class="subName">부스안내</h2>
                        </div>
                        <div class="contentIn">
                            <h3 class="h3_booth_info"><img class="h3_bul" src="/resources/img/h3_bul.jpg">부스안내</h3>
                            <div class="tb_type1">
                                <table border="1">
                                    <thead>
                                        <tr class="background_color">
                                            <th class="booth_type">부스종류</th>
                                            <th class="booth_unit">단위</th>
                                            <th class="booth_standard">규격</th>
                                            <th class="booth_content">내용</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="booth_type">기본부스</td>
                                            <td class="booth_unit">1부스</td>
                                            <td class="booth_standard">3m x 3m</td>
                                            <td>
                                                면적 + 기본 조립(부스벽체), 바닥(파이텍스), 상담테이블1, 의자3조, 조명(Sport Light), 콘센트(2구 1개), 상호간판, 안내데스크, 접의자 1
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="booth_type">독립부스</td>
                                            <td class="booth_unit">1부스</td>
                                            <td class="booth_standard">3m x 3m</td>
                                            <td>
                                                부스 면적만 제공, 전기, 간선 등 기타 부스설치공사는 업체 부담
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div>
                                <p class="color1">
                                    * 부대시설 항목은 참가신청시 확인가능(문의처: 031-259-6531~4)
                                </p>
                            </div>
                            <br>
                            <h3 class="h3_booth_info"><img class="h3_bul" src="/resources/img/h3_bul.jpg">조립부스 Layout</h3>
                            <div>
                                <p class="number">
                                    ①개별기업
                                </p>
                            </div>
                            <div class="tb_type1">
                                <table border="1">
                                    <thead>
                                        <tr class="background_color">
                                            <th class="supply">제공내역</th>
                                            <th class="amount">수량</th>
                                            <th class="booth_unit">단위</th>
                                            <th class="booth_standard1">규격</th>
                                            <th class="booth_note">비고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="supply">조립부스(옥타시스템)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">식</td>
                                            <td class="booth_standard1">3m x 3m x H : 2.5m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">상호간판(현수막)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">3m x 1m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">슬로건 간판</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">3m x 0.3m</td>
                                            <td class="booth_note">방염 파이텍스</td>
                                        </tr>
                                        <tr>
                                            <td class="supply">바닥 (파이텍스)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">식</td>
                                            <td class="booth_standard1">3m x 3m</td>
                                            <td class="booth_note">방염</td>
                                        </tr>
                                        <tr>
                                            <td class="supply">스포트라이트</td>
                                            <td class="amount">7</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">주광 100W</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">콘센트(2구)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">15A/220V(1KW)</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">안내데스크</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">1m x 0.5m x H : 0.75m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">안내의자</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">접이식</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">상담용 테이블</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">0.75m x H : 750	</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">상담용 라운드의자)</td>
                                            <td class="amount">3</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1"></td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">휴지통</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1"></td>
                                            <td class="booth_note"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <p class="img_center">
                                <img class="booth_img" src="/resources/img/sub3_3_img1.jpg">
                            </p>


                            <div>
                                <p class="number">
                                    ②공동관
                                </p>
                            </div>
                            <div class="tb_type1">
                                <table border="1">
                                    <thead>
                                        <tr class="background_color">
                                            <th class="supply">제공내역</th>
                                            <th class="amount">수량</th>
                                            <th class="booth_unit">단위</th>
                                            <th class="booth_standard1">규격</th>
                                            <th class="booth_note">비고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="supply">조립부스(옥타시스템)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">식</td>
                                            <td class="booth_standard1">3m x 2m x H : 2.5m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">상호간판(현수막)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">2m x 0.5m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">슬로건 간판</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">3m x 0.3m</td>
                                            <td class="booth_note">방염 파이텍스</td>
                                        </tr>
                                        <tr>
                                            <td class="supply">바닥 (파이텍스)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">식</td>
                                            <td class="booth_standard1">3m x 3m</td>
                                            <td class="booth_note">방염</td>
                                        </tr>
                                        <tr>
                                            <td class="supply">스포트라이트</td>
                                            <td class="amount">4</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">주광 100W</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">콘센트(2구)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">15A/220V(1KW)</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">안내데스크</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">1m x 0.5m x H : 0.75m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">안내의자</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">접이식</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">상담용 테이블</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">0.75m x H : 750	</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">상담용 라운드의자)</td>
                                            <td class="amount">3</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1"></td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">휴지통</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1"></td>
                                            <td class="booth_note"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <p class="img_center">
                                <img class="booth_img" src="/resources/img/sub3_3_img1.jpg">
                            </p>



                            <div>
                                <p class="number">
                                    ③국제관, 특별관
                                </p>
                            </div>
                            <div class="tb_type1">
                                <table border="1">
                                    <thead>
                                        <tr>
                                            <th class="supply">제공내역</th>
                                            <th class="amount">수량</th>
                                            <th class="booth_unit">단위</th>
                                            <th class="booth_standard1">규격</th>
                                            <th class="booth_note">비고</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="supply">조립부스(옥타시스템)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">식</td>
                                            <td class="booth_standard1">3m x 3m x H : 2.7m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">상호간판(현수막)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">3m x 0.35m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">측면기둥싸인</td>
                                            <td class="amount">2</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">0.5m x 3m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">바닥 (파이텍스)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">식</td>
                                            <td class="booth_standard1">3m x 3m</td>
                                            <td class="booth_note">방염</td>
                                        </tr>
                                        <tr>
                                            <td class="supply">스포트라이트</td>
                                            <td class="amount">6</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">주광 100W</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">콘센트(2구)</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">15A/220V(1KW)</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">안내데스크</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">1m x 0.5m x H : 0.75m</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">안내의자</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">접이식</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">상담용 테이블</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1">0.75m x H : 750	</td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">상담용 라운드의자)</td>
                                            <td class="amount">3</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1"></td>
                                            <td class="booth_note"></td>
                                        </tr>
                                        <tr>
                                            <td class="supply">휴지통</td>
                                            <td class="amount">1</td>
                                            <td class="booth_unit">개</td>
                                            <td class="booth_standard1"></td>
                                            <td class="booth_note"></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="bottom_space"></div>

                            <h3 class="h3_booth_info"><img class="h3_bul" src="/resources/img/h3_bul.jpg">독립부스</h3>
                            <div class="white_box3">
                                <ul class="basic_list">
                                    <li>독립부스 시공방법</li>
                                </ul>
                                <br>
                                <p class="color1">
                                    참가사가 주관자로부터 전시면적만 제공받아 독자적인 디자인으로 부스 장치ㆍ철거를 자체적으로 운영
                                </p>
                                <p class="p_content">장치업체 선정 시공시 - 시공업체는 KINTEX 홈페이지 (www.kintex.com) 협력업체 참조</p>
                                <p class="p_content">참가업체 자체 시공시 - G-FAIR 사무국 별도 문의 후 작업신고서 제출</p>
                                <p class="p_content">* 참고사항 : 독립부스 참가업체는 반드시 부스의 설계도면을 사전에 제출하여 주최측의 승인하에 시공 부스 내 모든 장치물(목재 구조물, 바닥카페트 등)은 방드시 방염처리 요함.</p>
                            </div>

                            <h3 class="h3_booth_info"><img class="h3_bul" src="/resources/img/h3_bul.jpg">부스배정</h3>
                            <div class="white_box3">
                                <br>
                                <p class="color1">
                                    전시품목 및 전시 효과와 효율적인 참관객 동선을 고려하여 주관사가 부스를 임의배정 후 참가업체 통보를 원칙으로 함.
                                </p>
                                <p class="p_content">* 참고사항 : 각 관별 부스배정 시 유사 아이템끼리 Zoning화 하여 구성 예정</p>
                            </div>
                            <div class="bottom_space"></div>
                        </div>
                    </div>
                </div>
        
            <span id="top_btn">top</span>  
            <%@ include file="/WEB-INF/views/common/footer.jsp" %>
            </div> <!--wrap-->
    </body>
</html>