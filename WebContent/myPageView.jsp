<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="dto.Together"%>
<%@ page import="dto.Member"%>

<%@ include file="togetherShellT.jsp"%>

<!-- 이부분에 본인의 css를 넣으세요. 시작 -->
<link type="text/css" rel="stylesheet" href="css/myPage.css">
<!-- 이부분에 본인의 css를 넣으세요. 끝 -->


<!-- 이부분에 본인의 .js를 넣으세요. 시작 -->
<script src="js/certForm.js"></script>
<!-- 이부분에 본인의 .js를 넣으세요. 끝 -->

<%@ include file="togetherShellM.jsp"%>

<!-- 각자 변경해야 하는 부분 시작 -->
<c:if test="${sessionCheck != '1'}">
	<script type="text/javascript">
		alert("로그인 상태가 아닙니다.");
		location.href = "home.do";
	</script>
</c:if>

<h2>인증하기</h2>
	<c:choose>
		<c:when test="${empty myIngList}">
		<div class="s_notify">
			<h5> -현재 진행중인 투게더가 없습니다-</h5>
		</div>
		</c:when>
		<c:otherwise>
			<jsp:include page="seoTogether.jsp">
				<jsp:param value="yes" name="isCert" />
			</jsp:include>
		</c:otherwise>
	</c:choose>

<hr class="s_hrLine">
<h2>${sessionScope.member.name}님의 투게더</h2>

<c:choose>
	<c:when test="${listSort == '2' }">
	<% System.out.println("[myPageView]Menu1 listSort Test"); %>
		<div id="s_menu2">
	<button id="s_selected" class="s_btn" value=2 onchange="sortSelected()">진행중</button>
	<button class="s_btn" onclick="location.href='myPage.do?listSort=1'">모집중</button>
	<button class="s_btn" onclick="location.href='myPage.do?listSort=4'">내가 만든 투게더</button>
	<button class="s_btn" onclick="location.href='myPage.do?listSort=3'">끝난 투게더</button>
</div>
	</c:when>
	<c:when test="${listSort == '1' }">
	<div id="s_menu2">
	<button class="s_btn" onclick="location.href='myPage.do?listSort=2'">진행중</button>
	<button id="s_selected" class="s_btn" value=1 onchange="sortSelected()">모집중</button>
	<button class="s_btn" onclick="location.href='myPage.do?listSort=4'">내가 만든 투게더</button>
	<button class="s_btn" onclick="location.href='myPage.do?listSort=3'">끝난 투게더</button>
</div>
	</c:when>
	<c:when test="${listSort == '4' }">	
	<div id="s_menu2">
	<button class="s_btn" onclick="location.href='myPage.do?listSort=2'">진행중</button>
	<button class="s_btn" onclick="location.href='myPage.do?listSort=1'">모집중</button>
	<button id="s_selected" class="s_btn" value=4 onchange="sortSelected()">내가 만든 투게더</button>
	<button class="s_btn" onclick="location.href='myPage.do?listSort=3'">끝난 투게더</button>
	</div>
	</c:when>
	<c:otherwise>
	<div id="s_menu2">
	<button class="s_btn" onclick="location.href='myPage.do?listSort=2'">진행중</button>
	<button class="s_btn" onclick="location.href='myPage.do?listSort=1'">모집중</button>
	<button class="s_btn" onclick="location.href='myPage.do?listSort=4'">내가 만든 투게더</button>
	<button id="s_selected" class="s_btn" value=3 onchange="sortSelected()">끝난 투게더</button>	
	</div>
	</c:otherwise>
</c:choose>

<jsp:include page="seoTogether.jsp">
	<jsp:param value="yes" name="isFinished"/>
</jsp:include>

<hr class="s_hrLine">
<div class="s_clearfix"></div>
	<h2>회원정보 수정</h2>
	<a href="updateMemberForm.do">
		<button type="submit" class="s_block" style="height: 60px;">
			정보 수정</button>
	</a>

<hr class="s_hrLine">
<h2>열정 충전하기</h2>
		<div class="s_notify">
			<h5>현재 열정: ${String.format( "%,10d", sessionScope.member.point)} 원</h5>
		</div>
	<a href="chargeForm.do">
		<button type="submit" class="s_block" style="height: 60px;">
			열정 충전하기</button>
	</a>

<br>
<hr class="s_hrLine">

<%-- <c:if test="${sessionScope.member != null} ">
	<h2>${sessionScope.member.ID}님이완료한투게더</h2>
</c:if> --%>


<%-- <table id="passedTo">
	<tr>
		<th>투게더 명</th>
		<th>시행 기간</th>
		<th>달성률</th>
	</tr>

	<c:forEach var="to" items="${myFinishedList}" varStatus="status">
		<!--to=  -->

		<tr>
			<td><img src="${to.thumPath}" alt="사진없음"
				style="width: 25px; height: 25px; vertical-align: text-top;">${to.title}</td>
			<td>${to.startDateWithDelimiter}~${to.endDateWithDelimiter}</td>
			<td>${countList[status.index]}%</td>
		</tr>


	</c:forEach> --%>

<!-- 각자 변경해야 하는 부분 끝-->

<%@ include file="togetherShellB.jsp"%>
