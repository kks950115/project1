<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   

        <header>
            <div class="header_wrapper">
                <div class="top_wrap">
                    <div class="topNav">
                        <ul class="topMenu">
                            <!-- 로그인 정보 있을 때 -->
                            <c:if test="${__LOGIN__.memberid != null}">
                            	<li class="tm1"><strong>${__LOGIN__.membername}</strong>님</li>
                                <li class="tm1"><a href="/login/logout">로그아웃</a></li>
                                <!-- 관리자가 로그인 했을 때 -->
                                <c:if test="${__LOGIN__.membertype == '관리자'}">
                                    <li class="tm1"><a href="/mypage/adminInfo">관리페이지</a></li>
                                </c:if>
                                <!-- 회원이 로그인 했을 때 -->
                                <c:if test="${__LOGIN__.membertype != '관리자'}">
                                    <li class="tm1"><a href="/mypage/myInfo">마이페이지</a></li>
                                </c:if>
                            </c:if>
                            <!-- 로그인 정보 없을 때 -->
                            <c:if test="${__LOGIN__.memberid == null}">
                                <li class="tm1"><a href="/login/login">로그인</a></li>
                                <li class="tm1"><a href="/member/agreement">회원가입</a></li>
                            </c:if>
                            <li class="tm1"><a href="#">원격지원</a></li>
                            <li class="tm2"><a href="https://blog.naver.com/g_fair_korea" target="blank"><img src="/resources/img/blog.png" alt=""></a></li>
                            <li class="tm2"><a href="https://www.facebook.com/gfairkr" target="blank"><img src="/resources/img/facebook.png" alt=""></a></li>
                            <li class="tm2"><a href="https://www.instagram.com/gfairkorea/" target="blank"><img src="/resources/img/instagram.png" alt=""></a></li>
                            <li class="tm2"><a href="#"><img src="/resources/img/mail.png" alt=""></a></li>
                        </ul>
                    </div>
                </div>
                <div class="gnb_wrapper">
                    <h1 class="logo"><a href="/">로고</a></h1>
                    <div id="nav">
                        <ul class="dropdownmenu">
                            <li class="menu"><h3><a href="/page/intro">전시회소개</a></h3>
                                <ul>
                                    <li><a href="/page/intro">전시회안내</a></li>
                                    <li><a href="/page/history">연혁</a></li>
                                    <li><a href="/exhibition/calendar">전시회일정</a></li>
                                    <li><a href="/page/facilities">부대시설</a></li>
                                    <li><a href="/page/traffic">찾아오시는길</a></li>
                                </ul>
                            </li>
                            <li class="menu"><h3><a href="/photo/listPerPage">미디어센터</a></h3>
                                <ul>
                                    <li><a href="/photo/listPerPage">포토갤러리</a></li>
                                    <li><a href="/news/listPerPage">보도자료</a></li>
                                </ul>
                            </li>
                            <li class="menu"><h3><a href="/apply/info">참가안내</a></h3>
                                <ul>
                                    <li><a href="/apply/info">참가신청안내</a></li>
                                    <li><a href="/apply/app">참가신청</a></li>
                                    <li><a href="/apply/applystatus">참가신청확인</a></li>
                                    <li><a href="/apply/rule">참가규정</a></li>
                                    <li><a href="/apply/booth">부스안내</a></li>
                                    <li><a href="/apply/map">전시장배치도</a></li>
                                    <li><a href="/apply/companyList">참가기업목록</a></li>
                                </ul>
                            </li>
                            <li class="menu"><h3><a href="/pre/agreement">사전신청</a></h3>
                                <ul>
                                    <li><a href="/pre/guide">사전관람안내</a></li>
                                    <li><a href="/pre/agreement">사전관람신청</a></li>
                                    <li><a href="/pre/verify">사전관람신청확인</a></li>
                                    
                                </ul>
                            </li>
                            <li class="menu"><h3><a href="/notice/list">커뮤니티</a></h3>
                                <ul>
                                    <li><a href="/notice/list">공지사항</a></li>
                                    <li><a href="/question/list">질문게시판</a></li>
                                    <li><a href="/often/question">자주묻는질문</a></li>
                                    <li><a href="/anony/list">고객의소리</a></li>
                                    <li><a href="/free/board">자유게시판</a></li>
                                    <li><a href="/event/listPerPage">이벤트</a></li>
                                </ul>       
                            </li>
                        </ul>
                    </div>
                </div>


            </div> <!-- header_wrapper -->
        </header>