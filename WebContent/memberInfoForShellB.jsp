<%@page import="dto.Member"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<span id="p_memberName">
        <c:if test="${sessionScope.member==null}">Guest님<br>안녕하세요?</c:if>
        <c:if test="${sessionScope.member!=null}">
          <a href="myPage.do">${sessionScope.member.ID}
            (${sessionScope.member.name}) 님</a>
          <button onclick="logOut()">로그아웃</button>
        </c:if>
      </span>
      <c:if test="${sessionScope.member!=null}">
        <table class="p_memberInfoDesc">
          <tr>
            <td>포인트:</td>
            <td>${String.format( "%,10d", sessionScope.member.point) }원</td>
          </tr>
          <tr>
            <td>가입일:</td>
            <td>${sessionScope.member.createDateWithDelimiter}</td>
          </tr>
        </table>
      </c:if>