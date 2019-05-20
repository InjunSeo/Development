<%@page import="dao.SyDao"%>
<%@page import="dto.Member"%>
<%@page import="java.util.List"%>
<%@page import="dto.Together"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%
	System.out.println("[enrollListAjax.jsp] start");
	request.setCharacterEncoding("utf-8");
	int status = Integer.parseInt(request.getParameter("status"));
	System.out.println("[enrollListAjax.jsp] status :" + status);
	session = request.getSession();
	Member member = (Member) session.getAttribute("member");
	String id = member.getID();
	
	
	SyDao sd = SyDao.getInstance();
	List<Together> enrollList = sd.enrollList(id, status);
	
	request.setAttribute("enrollList", enrollList);
%>

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
		  	<a href="info.do">
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
