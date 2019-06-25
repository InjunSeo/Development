<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	request.setCharacterEncoding("utf-8");
	String x = request.getParameter("check");
	System.out.println("[chargeProFormAjax.jsp]: x=" +x);
%>
<c:if test="${x == 'kakao' }">
	<div id="s_chargeProFormAjaxContent">
			<div>카카오 계정 ID<input type="number" name="cardNum" required="required"></div>
			<div>비밀번호<input type="password" name="passwd" required="required"> </div>
	</div>
</c:if>
<c:if test="${x == 'card'}">
	<div id="s_chargeProFormAjaxContent">
			<div>카드번호<input type="number" name="cardNum" required="required"></div>
			<div>비밀번호<input type="password" name="passwd" required="required"> </div>
	</div>
</c:if>
<c:if test="${x == 'tranfer' }">
	<div id="s_chargeProFormAjaxContent">
	<div> 계좌번호 <input type="number" name="cardNum" required="required"></div>
	</div>
</c:if>
	
