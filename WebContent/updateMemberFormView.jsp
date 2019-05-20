<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>
   

<%@ include file="togetherShellT.jsp"%>

  <!-- 이부분에 본인의 css를 넣으세요. 시작 -->
   <link type="text/css" rel="stylesheet" href="css/updateMember.css">
  <!-- 이부분에 본인의 css를 넣으세요. 끝 -->
   
  <!-- jQuery가 필요 없으면 이 부분을 지우세요. 시작 -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <!-- jQuery가 필요 없으면 이 부분을 지우세요. 끝 -->
  
  
  <!-- 이부분에 본인의 .js를 넣으세요. 시작 -->
   <script src="js/updateMemberFormView.js"></script>
  <!-- 이부분에 본인의 .js를 넣으세요. 끝 -->
  
<%@ include file="togetherShellM.jsp"%>

<div id="K_contentBackground" class="K_contentBackground">
	<form class="K_content K_animate" name="updateForm" onsubmit="return formChk()" action="updateMemberPro.do" method="post">
		<div class="K_imgContainer">
			<img src="img/together.png" alt="together_img" class="K_togetherImg">
		</div>
		<div class="K_setInfo">
			<label for="id"><b>아이디</b></label><br>
			<input type="text" class="K_setInfoContent" value="${sessionScope.member.ID }" name="id" disabled="disabled">
			<label for="name"><b>이름</b></label>
			<input type="text" class="K_setInfoContent" value="${sessionScope.member.name }" name="name" placeholder="이름을 입력하세요 (예 : 홍길동)" title="2~50 자 이내의 이름을 입력하세요" pattern=".{2,50}" autocomplete="off" required>
			<label for="pwchk"><b>기존비밀번호 확인</b></label>
			<input type="password" class="K_setInfoContent" placeholder="기존 비밀번호를 입력하세요" name="pwchk" required>
			<label for="newpw"><b>새 비밀번호</b></label>
			<input type="password" class="K_setInfoContent" placeholder="새 비밀번호를 입력하세요" name="newpw">
			<label for="newpwchk"><b>새 비밀번호 확인</b></label>
			<input type="password" class="K_setInfoContent" placeholder="비밀번호를 한번 더 입력하세요" name="newpwchk">
			<label for="email"><b>이메일</b></label><br>
			<input type="text" class="K_setInfoContent" value="${sessionScope.member.email }" name="email" placeholder="이메일을 입력하세요 (예 : together@gmail.com)" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,30}$" autocomplete="off" required>
			<label for="tel"><b>연락처</b></label>
			<input type="tel" class="K_setInfoContent" value="${sessionScope.member.tel }"  pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" title="012-3456-7890 의 형식으로 입력하세요" class="K_setInfoContent" placeholder="연락처를 입력하세요 (예 : 000-0000-0000)" name="tel" autocomplete="off">
			<span class="K_showpoint">열정포인트 : ${sessionScope.member.point }</span>
		</div>
		<div class="K_setInfo">
			<button type="button" class="K_chargePoint" onclick="location.href='chargeForm.do'">
			<span class="K_linkpointstring">포인트충전</span>
			</button>
		</div>
		<div class="K_setInfo">
			<button type="submit" class="K_signupBtn">
				<span class="K_signupString">수정완료</span>
			</button>
			<button type="button" class="K_withdrawalBtn" onclick="location.href='closeMemberForm.do'">
				<span class="K_withdrawalString">회원탈퇴</span>
			</button>
		</div>
	</form>
</div>

<%@ include file="togetherShellB.jsp" %>
