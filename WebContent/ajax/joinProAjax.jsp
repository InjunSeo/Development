<%@page import="javax.websocket.Session"%>
<%@page import="dto.Member"%>
<%@page import="dto.Join"%>
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
	System.out.println("[joinProAjax.jsp] " + sToNo + ", " + memberID);
	SaintpDao dao = SaintpDao.getInstance();
	if (sToNo != null && !sToNo.equals("")) {
		toNo = Integer.parseInt(sToNo);
		result = dao.join(toNo, memberID);

		if (result == Join.JOIN_SUCCESS) {
      // 열정 포인트 업데이트 된 Member 다시 가져와 세션에 Set.
			Member member = dao.getMember(memberID);
			session.setAttribute("member", member);
		}

		// result는 아래의 값 중 하나를 가진다.
		// Join.JOIN_SUCCESS -29
		// Join.JOIN_REJECT_MEMBER_POINT -23
		// Join.JOINED_ALREADY -21
		// Member.NOT_EXIST -31
		// Together.NOT_EXIST -51
		// Together.JOINPERSON_FULL -52
		// Join.JOIN_REJECT_TOGETHER_STATUS -22    
		System.out.println("[joinProAjax.jsp] result = " + result);
	}
%>
<%=result%>