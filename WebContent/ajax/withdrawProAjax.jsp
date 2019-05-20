<%@page import="javax.websocket.Session"%>
<%@page import="dto.Member"%>
<%@page import="dto.Join"%>
<%@page import="dto.Together"%>
<%@page import="dao.SaintpDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%
	request.setCharacterEncoding("utf-8");
	String sToNo = request.getParameter("toNo");
	String memberID = request.getParameter("ID");
	int toNo = 0;
	int result = 0;
	System.out.println("[withdrawProAjax.jsp] " + sToNo + ", " + memberID);
	SaintpDao dao = SaintpDao.getInstance();
	if (sToNo != null && !sToNo.equals("")) {
		toNo = Integer.parseInt(sToNo);
		result = dao.withdraw(toNo, memberID);

		if (result == Join.WITHDRAW_SUCCESS) {
      // 열정 포인트 업데이트 된 Member 다시 가져와 세션에 Set.
			Member member = dao.getMember(memberID);
			session.setAttribute("member", member);
		}

		// result는 아래의 값 중 하나를 가진다.
		// Join.WITHDRAW_SUCCESS -29
		// Member.NOT_EXIST -31
		// Together.NOT_EXIST -51
		// Join.WITHDRAW_REJECT_TOGETHER_STATUS -22
		// Join.IS_CREATOR_OF_TOGETHER -28
		System.out.println("[withdrawProAjax.jsp] result = " + result);
	}
%>
<%=result%>