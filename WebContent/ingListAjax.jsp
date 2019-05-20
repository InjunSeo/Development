<%@page import="dto.Together"%>
<%@page import="java.util.List"%>
<%@page import="dao.MhDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	request.setCharacterEncoding("utf-8");
	String ingListSort = request.getParameter("ingListSort");
	/* 컨트롤러를 거치지 않고 dao랑 바로 통신해(Ajax_service역할을 해.) */
	MhDao md = MhDao.getInstance();
    List<Together> ingList = md.getIngList(ingListSort);
	
	request.setAttribute("ingList", ingList);
%>

<!-- ingListView.jsp의 역할 -->
<c:forEach var="togelist" items="${ingList}">
	<div class="h_row">
		<div class="h_content" onclick="location.href='info.do?toNo=${togelist.toNo}'" style="cursor:pointer">
			<div class="h_contNo">*togeNo: ${togelist.toNo}</div>			
			<img class="h_thumPath" src="${togelist.thumPath}" alt="${togelist.thumPath}">
			<div class="h_pp">
			  <div class="h_contBold">*제목: ${togelist.title}</div>
			  *기간: <mark>${togelist.startDateWithDelimiter} ~ ${togelist.endDateWithDelimiter}</mark><br>
			  *참여인원: ${togelist.joinPerson}명 <br>
			  *총잔여포인트: ${String.format("%,10d", togelist.remainPoint)}원
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
