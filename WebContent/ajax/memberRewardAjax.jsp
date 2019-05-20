
<%@page import="dto.Join"%>
<%@page import="java.util.List"%>
<%@page import="dao.YnvlyDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String sToNo = request.getParameter("toNo");
	int toNo = 0;
	if (sToNo != null) toNo = Integer.parseInt(sToNo);
	List<Join> eachRwdList = null;
	YnvlyDao yd = YnvlyDao.getInstance();
	try {
		eachRwdList = yd.getEachRwdList(toNo);
	}
	catch (Exception e) {
		System.out.println(e.getMessage());
	}
	
	pageContext.setAttribute("eachRwdList", eachRwdList);

%>

<div id="rewardBox">
	<br>&nbsp;&nbsp;No. <%=toNo %>
	<table>
		<tr>
		<th>회원 ID</th>
		<th>Total Point</th>
		</tr>
		<c:forEach var="reward" items="${eachRwdList }">
			<tr>
			<th>${reward.memberID }</th>
			<th><fmt:formatNumber value="${reward.rewardPoint }" pattern="#,###"/></th>
			</tr>
		</c:forEach>
	</table>
</div>