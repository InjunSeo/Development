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
  System.out.println("[certProAjax_saintp.jsp] " + sToNo + ", " + memberID);
  SaintpDao dao = SaintpDao.getInstance();
  if (sToNo != null && !sToNo.equals("")) {
    toNo = Integer.parseInt(sToNo);
    result = dao.cert(toNo, memberID);


    // result는 아래의 값 중 하나를 가진다.
    // Cert.CERT_SUCCESS -11
    // Cert.ALREADY_CERT -12
    // Member.NOT_EXIST -31
    // Together.NOT_EXIST -51
    System.out.println("[certProAjax_saintp.jsp] result = " + result);
  }
%>
<%=result%>