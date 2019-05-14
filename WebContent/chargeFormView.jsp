<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ page import="dto.Member"%>
   
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
    <script src="js/certForm.js"></script>  
  <!-- 이부분에 본인의 .js를 넣으세요. 끝 -->
  
<%@ include file="togetherShellM.jsp"%>

 <h2>열정 충전하기</h2>
 <div id="s_tt">
 	<div class="s_chargeContainer">
 	<form action="chargeProc.do" method="post">
      <input type="hidden" name="nowPoint" value="${nowPoint }">  
	      <table class="s_chargeTable">
	      	<tr><th class="s_th0" colspan="2"> <img src="img/together.png" alt="img/together.png" id="s_chargeImg">
	      	 </th>
	      	</tr>
	      	<tr><th class="s_th1" colspan="2"> ${name}님 </th>
	      	</tr>
	      	<tr><th class="s_th2">  보유 열정  </th>
	      		<td> ${nowPoint} <td>
	      	</tr>
	      	<tr><th class="s_th2">충전 열정</th>
	     		<td><input type="number" min="1000" name="charge" step="1000" id="s_charge" onchange="minCharge()" required="required"></td>
	     	</tr>
	     	<tr>
	     		<th class="s_th2">결제</th>
			</tr>			
	 		
			 		<!-- <div class="s_button">		  
				  <button type="button" class="btn success" name="kakao" value="kakao" onclick="chargeAjax('kakao')">카카오페이</button> 
		      	  <button type="button" class="btn info" value="card" onclick="chargeAjax('card')">신용카드</button>
		      	  <button type="button" class="btn warning" value="transfer" onclick="chargeAjax('transfer')">계좌이체</button>
		      	  <button type="button" class="btn danger"value="giftCard" onclick="chargeAjax('giftCard')">상품권</button>
			      	  <button type="button" class="btn default" value="coupon" onclick="chargeAjax('coupon')">쿠폰</button>	    
					</div> -->
			<tr><th class="s_th3" colspan="2"> 
				<div id="s_viewChargeAjax"> </div>
	      		<input type="submit" value="충전하기"></th>
	      	</tr>
		</table>
	      
 	</form>
 	</div>
 	
</div>
<hr class="s_hrLine">
 	
 	
<%@ include file="togetherShellB.jsp" %>