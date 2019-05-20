<%@page import="dto.Member"%>
<%@page import="dao.SaintpDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%
	request.setCharacterEncoding("utf-8");
	String memberID = request.getParameter("ID");

	SaintpDao dao = SaintpDao.getInstance();
	if (memberID != null) {
		Member member = dao.getMember(memberID);
		member.print("[getMemberInfoAjax.jsp]");
		session.setAttribute("member", member);
	}
%>

<jsp:include page="../memberInfoForShellB.jsp"/>