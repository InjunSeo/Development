<%@ page import="dto.Member"%>
<%@ page import="dao.KsmDao"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");
	HttpSession userSession = request.getSession();
	
	int result  = 0;
	String tryID = request.getParameter("id");
	String tryPW = request.getParameter("pw");
	System.out.println("id : " + tryID + ", pw : " + tryPW);
	KsmDao kd		 	= KsmDao.getInstance();
	Member member = kd.login(tryID, tryPW);
	System.out.println("3, member = " + member);
	
	if (member != null) {
		result = 1;
		userSession.setAttribute("member", member);
	};
	System.out.println("4");
%>
<%=result %>