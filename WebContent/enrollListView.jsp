<%@page import="java.util.List"%>
<%@page import="dao.SyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   

<%@ include file="togetherShellT.jsp"%>

   <link type="text/css" rel="stylesheet" href="css/enrollList.css">
   
  
<%@ include file="togetherShellM.jsp"%>

<h2>내가 등록한 투게더</h2>
<hr class="l_line">
<div id="l_BtnContainer" onmousemove="btnActive()">
  <button class="l_btn active" onclick="listFilter(0)"> Show all</button>
  <button class="l_btn"  onclick="listFilter(1)" > 모집중</button>
  <button class="l_btn"  onclick="listFilter(2)" > 진행중</button>
  <button class="l_btn"  onclick="listFilter(3)" > 종료</button>
</div>
<div id="listView">
<c:forEach var="list" items="${enrollList }">
	<div class="l_container" >
		<div class="l_nemo">
			<p><b>No. ${list.toNo }
				[${list.status==Together.getStatusCanceled()? '취소' : ''}
				${list.status==Together.getStatusRecruit()? '모집중' : ''} 
				${list.status == Together.getStatusIng()? '진행중' : ''}
				${list.status==Together.getStatusFinished()? '종료' : ''}]
			</b></p>
			<p class="l_font"><b>${list.title }</b></p>
		  	<img src="${list.thumPath }" class="l_image">
		  	<a href="info.do?toNo=${list.toNo }">
		  	<div class="l_overlay">
		  		<div class="l_text">
					<p>기간<br>${list.startDateWithDelimiter} ~ ${list.endDateWithDelimiter}</p>
					<p>참여 인원<br>${list.joinPerson } / ${list.maxPerson} 명</p>
					<p>최소 모집 인원<br>${list.minPerson } 명<br></p>
					<p>모인 포인트 <br><fmt:formatNumber value="${list.grossPoint }" pattern="#,###"/>원</p>
				</div>
			</div>
			</a>
		</div>
	</div>
</c:forEach>
</div>


<c:if test="${check != '0'}">
	<script type="text/javascript">
		alert("로그인을 하세요");  
		location.href="login.do";
	</script>
</c:if> 

<c:if test="${result == '1'}">
	<script type="text/javascript">
		alert("투게더 등록이 완료 되었습니다");  
	</script>
</c:if> 
<c:if test="${modResult == '1'}">
	<script type="text/javascript">
		alert("투게더 수정이 완료 되었습니다");  
	</script>
</c:if> 
<c:if test="${delResult == '1'}">
	<script type="text/javascript">
		alert("투게더 삭제가 완료 되었습니다");  
	</script>
</c:if> 

<script src="js/enrollList.js"></script>

<%@ include file="togetherShellB.jsp" %>
