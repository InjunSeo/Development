<%@page import="java.util.List"%>
<%@page import="dto.Together"%>
<%@page import="dao.SaintpDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%
	request.setCharacterEncoding("utf-8");
	String memberID = request.getParameter("ID");

	int toNo = 0;
	List<Together> list = null;

	SaintpDao dao = SaintpDao.getInstance();
	if (memberID != null) {
		list = dao.getMyTogetherList(memberID);
		pageContext.setAttribute("myTogetherList", list);
	}
%>

<c:forEach var="together" items="${myTogetherList}">
  <%@ include file="../togetherListForShellB.jsp"%>
</c:forEach>