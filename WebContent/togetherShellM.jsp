<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<title>렛츠 투게더</title>
</head>
<body>

  <div class="p_header">
    <div class="p_title">
      <a href="home.do">렛츠투게더</a>
      <%@ include file="searchBlockForShellM.jsp"%>
    </div>

    <div class="p_oursHead" onclick="openNav()">created by 중앙 602호 1조 (팀명:
      도끼날)</div>
  </div>

  <div id="p_mySidenav" class="p_sidenav">
    <a href="javascript:void(0)" class="p_closebtn" onclick="closeNav()">&times;</a>
    <a onclick="visibleIntro( 'Kang')">강성민</a>
    <a onclick="visibleIntro( 'Park')">박성인</a>
    <a onclick="visibleIntro( 'Seo')">서인준</a>
    <a onclick="visibleIntro( 'Youn')">윤형석</a>
    <a onclick="visibleIntro( 'Lee')">이성용</a>
    <a onclick="visibleIntro( 'Jo')">조용철</a>
    <a onclick="visibleIntro( 'Cha')">차연지</a>
    <a onclick="visibleIntro( 'Hu')">허미희</a>
  </div>
  <div id="p_intro">
    <div class="p_int">
      <div id="p_intName">박성인</div>
      <div id="p_intCont">초기화면 및 전체 구성</div>
      <hr style="width:80%">
      <div id="p_process" onclick="operCertNTogoStatus('${member.ID}')">인증/투게더상태 처리</div>
    </div>
  </div>

  <div class="p_navbar">
    <a href="home.do">home</a>
    <a href="togetherEnrollForm.do">new </a>
    <a href="recruitList.do">recruiting </a>
    <a href="ingList.do">ongoing </a>
    <a href="finishedList.do">finished</a>
    <a class="p_right" onclick="loginOpen()">login/signUp</a>
    <c:if test="${sessionScope.member!=null}">
      <a href="myPage.do" class="p_right">MyPage</a>
    </c:if>
    <c:if test="${sessionScope.member==null}">
      <a class="p_right" onclick="alert('로긴해 주세요.');">MyPage</a>
    </c:if>
  </div>


  <div class="p_row">

    <div class="p_main" id="here">
      <!-- 각자 변경해야 하는 부분 시작 -->