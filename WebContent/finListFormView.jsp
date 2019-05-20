<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:forEach var="finToge" items="${finList }">
		 <div class="c_togetherBox">
	        <div class="c_container1">
	          <p><font id="togetherNo">TogeNo. ${finToge.toNo }</font></p>
	          <img src="${finToge.thumPath }" alt="${finToge.title }">
	          <hr><h3>${finToge.title }</h3><hr>
	         <a href="info.do?toNo=${finToge.toNo }">together 상세 보기</a>
	         </div>
	         <br>
	         <div class="c_info">    
	          <p>
	            참여포인트 : <fmt:formatNumber value="${finToge.joinPoint }" pattern="#,###"/>원<br> 
	            참여자 : ${finToge.joinPerson }명<br>
	            모인 포인트 : <fmt:formatNumber value="${finToge.grossPoint}" pattern="#,###"/>원<br>
	            최대 리워드 : <mark><fmt:formatNumber value="${finToge.maxRewardPoint }" pattern="#,###"/>원</mark>
	          </p>
	          <div id="c_viewRewardAjax"
          onclick="viewRewardAjax(${finToge.toNo})">모든 참여자 리워드 보기</div>
         	<br>
	        </div>
	      </div>
	</c:forEach>
	<div id="c_rewardAjaxContainer">
  <a href="javascript:void(0)" id="c_rewardAjaxClose" onclick="closeRewardAjax()">&times;</a>
  <div id="c_rewardAjax"></div>
	</div>