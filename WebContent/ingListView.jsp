<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.Together"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="togetherShellT.jsp"%>
<!-- 이부분에 본인의 css를 넣으세요. 시작 -->
<link type="text/css" rel="stylesheet" href="css/ing.css">
<!-- 이부분에 본인의 css를 넣으세요. 끝 -->

<!-- jQuery가 필요 없으면 이 부분을 지우세요. 시작 -->
   
<!-- jQuery가 필요 없으면 이 부분을 지우세요. 끝 -->
  
  
<!-- 이부분에 본인의 .js를 넣으세요. 시작 -->
  <script src="js/ingReward.js"></script>
<!-- 이부분에 본인의 .js를 넣으세요. 끝 -->


<%@ include file="togetherShellM.jsp"%>

<!-- 각자 변경해야 하는 부분 시작 -->
<div class="h_subhead">진행 Together</div>

<div id="h_BtnContainer">
        <button id="h_ingListBtn1" class="h_btn active" onclick="ingFunc1()">진행순</button>
        <button id="h_ingListBtn2" class="h_btn" onclick="ingFunc2()">참여순</button>
      </div>

<div class="h_contbox">
<c:forEach var="togelist" items="${ingList}">
	<div class="h_row">
		<div class="h_content" onclick="location.href='info.do?toNo=${togelist.toNo}'" style="cursor:pointer">
			<div class="h_contNo">*togeNo: ${togelist.toNo}</div>			
			<img class="h_thumPath" src="${togelist.thumPath}" alt="${togelist.thumPath}">
			<div class="h_pp">
			  <div class="h_contBold">*제목: ${togelist.title}</div>
			  *기간: <mark>${togelist.startDateWithDelimiter} ~ ${togelist.endDateWithDelimiter}</mark><br>
			  *참여인원: ${togelist.joinPerson}명 <br>
			  *총잔여포인트: ${String.format("%,10d", togelist.remainPoint) }원
			</div>
		</div>
		<div id="h_viewIngAjax" onclick="viewIngAjax(${togelist.toNo})">참여자별 리워드 보기</div>
		<div id="h_Progress">
		<div id="h_Bar" style='width:${String.format("%4.2f", togelist.progressRate*100)}%'>${String.format("%4.2f", togelist.progressRate*100)}%</div>
		</div>
	</div>
</c:forEach>
<div id="h_viewAjaxC">
	<a href="javascript:void(0)" id="h_ingAjaxClose" onclick="closeIngAjax()">&times;</a>
	<div id="h_ingAjax"></div>
</div>
</div>

<!-- 각자 변경해야 하는 부분 끝-->

<jsp:include page="togetherShellB.jsp" />
