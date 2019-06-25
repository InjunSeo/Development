<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>
   

<%@ include file="togetherShellT.jsp"%>


  <!-- 이부분에 본인의 css를 넣으세요. 시작 -->
<link type="text/css" rel="stylesheet" href="css/myPage.css">
<link type="text/css" rel="stylesheet" href="css/charge.css"> 

 <!-- 이부분에 본인의 css를 넣으세요. 끝 -->
   
  <!-- jQuery가 필요 없으면 이 부분을 지우세요. 시작 -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <!-- jQuery가 필요 없으면 이 부분을 지우세요. 끝 -->
  
  
  <!-- 이부분에 본인의 .js를 넣으세요. 시작 -->
  <!-- 이부분에 본인의 .js를 넣으세요. 끝 -->
  
<%@ include file="togetherShellM.jsp"%>

 <c:if test="${result > 0 }">
	<h2>충전 결과입니다. </h2>
	
	<table class="s_chargeTable">
		<tr><th class="s_th2">충전 전 열정 </th>
			<td>	 		 ${prePoint} </td>
		</tr>
		<tr><th class="s_th2">충전 열정 </th>
			<td> 			${charge} </td>
		</tr>
		<tr><th class="s_th2"> 충전 후 열정 </th> 
		 	<td> 				${nowPoint} </td>
		</tr>
<%-- 		<tr><td>결제 수단: ${methodOfPay} </td></tr> --%>	
	</table>
</c:if>

<c:if test="${result == 0 }">
	<h2>충전 중 오류입니다.</h2>
</c:if>

<hr class="s_hrLine">

<%@ include file="togetherShellB.jsp" %>
