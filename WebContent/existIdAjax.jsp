<%@ page import="dao.KsmDao"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String tryID = request.getParameter("id");

	
	KsmDao kd		 = KsmDao.getInstance();
	boolean result = kd.existID(tryID);

%>
<%=result%>

