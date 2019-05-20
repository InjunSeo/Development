<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   

<%@ include file="togetherShellT.jsp"%>


  <!-- 이부분에 본인의 css를 넣으세요. 시작 -->
   <link type="text/css" rel="stylesheet" href="css/finished.css">
  <!-- 이부분에 본인의 css를 넣으세요. 끝 -->
   
  <!-- jQuery가 필요 없으면 이 부분을 지우세요. 시작 -->
   
  <!-- jQuery가 필요 없으면 이 부분을 지우세요. 끝 -->
  
  
  <!-- 이부분에 본인의 .js를 넣으세요. 시작 -->
  <script src="js/reward.js"></script>
  <script src="js/listSorting.js"></script>
  <!-- 이부분에 본인의 .js를 넣으세요. 끝 -->
  
<%@ include file="togetherShellM.jsp"%>



<!-- 각자 변경해야 하는 부분 시작 -->
      <h2>끝난 투게더</h2>

      <div class="c_BtnContainer">
        <button id="c_btnNew" onclick="listSortingAjax(1)">최신순</button>
        <button id="c_btnRwd" onclick="listSortingAjax(0)">높은 리워드순</button>
      </div>
      <div id="c_list">
      
	<%@ include file = "finListFormView.jsp" %>
	
</div>
<!-- 각자 변경해야 하는 부분 끝-->


<%@ include file="togetherShellB.jsp" %>
