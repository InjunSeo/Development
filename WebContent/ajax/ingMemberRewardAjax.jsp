<%@page import="dto.Join"%>
<%@page import="java.util.List"%>
<%@page import="dao.MhDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%
	request.setCharacterEncoding("UTF-8");

	String sToNo = request.getParameter("toNo");
	int toNo = 0;
	if (sToNo != null) toNo = Integer.parseInt(sToNo);
	List<Join> ingRwdList = null;
	MhDao md = MhDao.getInstance();
	try { 
		ingRwdList = md.getIngRwdList(toNo);
	}
	catch (Exception e) {
		System.out.println(e.getMessage());
	}
	
	pageContext.setAttribute("ingRwdList", ingRwdList);

%>


<div id="h_ingBox">
	<br>&nbsp;&nbsp;No.<%=toNo%>
	<table>
		<tr>
		<th>회원ID</th>
		<th>RewardPoint</th>
		</tr>
		<c:forEach var="ingReward" items="${ingRwdList}">
		<tr>
		<th>${ingReward.memberID }</th>
		<th>${String.format("%,10d", ingReward.rewardPoint) }원</th>
		</tr>
		</c:forEach>
	</table>
</div>