<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>
   

<%@ include file="togetherShellT.jsp"%>


  <!-- 이부분에 본인의 css를 넣으세요. 시작 -->
   <link type="text/css" rel="stylesheet" href="css/closeMember.css">
  <!-- 이부분에 본인의 css를 넣으세요. 끝 -->
     
  <!-- 이부분에 본인의 .js를 넣으세요. 시작 -->
   <script src="js/xxx.js"></script>
  <!-- 이부분에 본인의 .js를 넣으세요. 끝 -->
  
<%@ include file="togetherShellM.jsp"%>

<div id="K_contentBackground" class="K_contentBackground">
	<form class="K_content K_animate" action="closeMemberPro.do" name="closeForm">
		<div class="K_imgContainer">
			<img src="img/together.png" alt="together_img" class="K_togetherImg">
		</div>
		<div class="K_setInfo">
			<p class="K_setCloseText">회원 탈퇴를 위한 확인 비밀 번호 입력</p>
			<c:if test="${pwFailed!=null}"><p><span id="K_closeFailed" class="K_closeFailedText">비밀번호가 일치하지 않습니다</span></p></c:if>	
			<input class="K_setInfoContent" type="password" name="pw">
			<input class="K_setInfoContent" type="submit" value="확인">
		</div>
	</form>
</div>

<%@ include file="togetherShellB.jsp" %>
