<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>
   

<%@ include file="togetherShellT.jsp"%>


  <!-- 이부분에 본인의 css를 넣으세요. 시작 -->
   <link type="text/css" rel="stylesheet" href="css/signup.css">
  <!-- 이부분에 본인의 css를 넣으세요. 끝 -->
   
  <!-- jQuery가 필요 없으면 이 부분을 지우세요. 시작 -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <!-- jQuery가 필요 없으면 이 부분을 지우세요. 끝 -->
  
  
  <!-- 이부분에 본인의 .js를 넣으세요. 시작 -->
   <script src="js/signupFormView.js"></script>
  <!-- 이부분에 본인의 .js를 넣으세요. 끝 -->
  
<%@ include file="togetherShellM.jsp"%>

<div id="K_contentBackground" class="K_contentBackground">
	<form class="K_content K_animate" name="signupForm" onsubmit="return formChk()" action="signupPro.do" method="post">
		<div class="K_imgContainer">
			<img src="img/together.png" alt="together_img" class="K_togetherImg">
		</div>
		<c:if test="${result==0}"><p><span id="K_signupFailed" class="K_signupFailedText">가입이 불가능 합니다. 다시 시도해 주세요</span></p></c:if>
		<div class="K_setId">
			<label for="id"><b>아이디</b></label><br>
			<input type="text" class="K_inputId" id="K_id" name="id" placeholder="아이디를 입력하세요" pattern="[A-Za-z0-9_-]{4,20}" title="4~20자 이상의 영어 대소문자  or 숫자 형식으로 입력하세요"  required="required" autofocus="autofocus" autocomplete="off" onfocus="activeBtn()">
			<button type="button" class="K_chkIdBtn" id="K_button" onclick="idChk()"><span>중복 확인</span></button>
		</div>
		<div class="K_setInfo">
			<label for="name"><b>이름</b></label><br>
			<input type="text" class="K_setInfoContent" name="name" placeholder="이름을 입력하세요 (예 : 홍길동)" title="2~50 자 이내의 이름을 입력하세요" pattern=".{2,50}" autocomplete="off" required> 
			<label for="pw"><b>비밀번호</b></label><br>
			<!-- pattern="(?=.*\d)(?=.*[a-z][A-Z]).{8,20}" -->
			<input type="password" class="K_setInfoContent" placeholder="8~20자 영숫자 혼합된 비밀번호를 입력하세요" title="8~20자의 비밀번호를 입력하세요" name="pw" autocomplete="off" required> 
			<label for="pwchk"><b>비밀번호 확인</b></label><br>
			<input type="password" class="K_setInfoContent" placeholder="비밀번호를 한번 더 입력하세요" name="pwchk" autocomplete="off" required>
			<label for="email"><b>이메일</b></label><br>
			<input type="text" class="K_setInfoContent" placeholder="이메일을 입력하세요 (예 : together@gmail.com)" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,30}$" autocomplete="off" required>
			<label for="phone"><b>연락처</b></label>
			<input type="tel" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" title="012-3456-7890 의 형식으로 입력하세요" class="K_setInfoContent" placeholder="연락처를 입력하세요 (예 : 000-0000-0000)" name="tel" autocomplete="off">
			<label for="point"><b>열정포인트</b></label>
			<input type="number" class="K_setInfoContent K_setPoint" placeholder="열정포인트를 입력하세요" name="point" value="0" required>
			<button type="submit" class="K_signupConfirm"><span class="K_signupstring">가입하기</span>
			</button>
		 </div>
	</form>
</div>

<%@ include file="togetherShellB.jsp" %>
