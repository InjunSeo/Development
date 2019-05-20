<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	int result = 0;
	HttpSession userSession = request.getSession();

	userSession.invalidate();

	if (request.getSession(false) == null) {
		result = 1;
	};

%>
<%= result%>