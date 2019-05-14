<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   

<div id="K_contentBackground " class="K_lgContentBackground">
	<div class="K_lgContent K_lgAnimate">
		<div class="K_lgInput">
			<input id="K_id" type="text" class="K_lgInputId" placeholder="아이디를 입력하세요" name="id" required="required" autocomplete="off" autofocus="autofocus"> 
			<input id="K_pw" type="password" class="K_lgInputPw" placeholder="비밀번호를 입력하세요" name="pw" required="required">
		</div>
		<div class="K_lgBtnLoc">
			<button class="K_button K_lgLoginBtn" onclick="loginPro()">
				<span class="K_lgLoginString">로그인</span>
			</button>
			<c:if test="${sessionScope.member.ID!=null}">
			<button class="K_button K_lgUpdateBtn" onclick="location.href='updateMemberForm.do'">
				<span class="K_lgUpdateString">수정</span>
			</button>
			</c:if>
			<button class="K_button K_lgSignupBtn" onclick="location.href='signupForm.do'">
				<span class="K_lgSignupString">회원가입</span>
			</button>
		</div>
		<div id="K_lgLoginFailed" class="K_lgLoginFailedText"></div>
	</div>
</div>
