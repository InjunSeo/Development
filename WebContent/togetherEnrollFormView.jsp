<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>



<%@ include file="togetherShellT.jsp"%>

<link type="text/css" rel="stylesheet" href="css/enroll.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="js/enroll.js"></script>

<%@ include file="togetherShellM.jsp"%>

<form action="togetherEnrollPro.do" method="post" name="frm"
	enctype="multipart/form-data" onsubmit="return chk()">
	<div class="l_container">
		<h1>투게더 등록</h1>
		<hr class="l_line">
		<table class="l_table">
			<tr>
				<th class="l_th"><b>투게더 이름</b></th>
				<td colspan="3"><input type="text" name="title" id="l_title"
					maxlength="99" class="l_input"
					value="${sessionScope.together.title }" required></td>
				<td rowspan="5" ><div id="l_preViewBox"><img id="l_preView" alt="썸네일 미리보기"/></div></div></td>
			</tr>
			<tr>
				<th class="l_th"><b>썸네일</b></th>
				<td colspan="3"><input type="file" name="thumPath" id="l_thum"
					class="l_input" accept='image/jpeg,image/gif,image/png'
					onchange='fileCheck(this)'></td>
			</tr>
			<tr>
				<th class="l_th"><b>참여 금액</b></th>
				<td colspan="3"><input type="number" name="joinPoint"
					id="l_point" min="100" max="${point }" step="100" class="l_input"
					value="${sessionScope.together.joinPoint }" required> 원</td>
			</tr>
			<tr>
				<th class="l_th"><b>최소 모집 인원</b></th>
				<td><input type="number" name="minPerson" onchange="minValue()"
					min="2" id="l_minPerson" class="l_input"
					value="${sessionScope.together.minPerson }" required> 명</td>

				<th class="l_th"><b>투게더 시작일</b></th>
				<td><input type="number" name="startDate" id="l_startDate"
					class="l_input" placeholder="시작일 선택" autocomplete="off"
					required="required" readonly="readonly"></td>
			</tr>
			<tr>
				<th class="l_th"><b>최대 모집 인원</b></th>
				<td><input type="number" name="maxPerson" id="l_maxPerson"
					class="l_input" value="${sessionScope.together.maxPerson }"
					required> 명</td>
				<th class="l_th"><b>투게더 종료일</b></th>
				<td><input type="text" name="endDate" id="l_endDate"
					class="l_input" placeholder="종료일 선택" autocomplete="off"
					required="required" readonly="readonly"></td>
			</tr>
			<tr>
				<th colspan="5" class="l_th" id="l_desc"><b>투게더 설명</b></th>
			</tr>
			<tr>
				<td colspan="5"><textarea rows="30" class="l_content"
						name="description" maxlength="1999">${sessionScope.together.description }</textarea></td>
			</tr>
		</table>
		<hr class="l_line">
		<div class="l_button">
			<input type="submit" class="l_enrollbtn" value="등록">
		</div>
		<div id=""></div>
	</div>
</form>
<c:if test="${check != '0'}">
	<script type="text/javascript">
		alert("로그인을 하세요");
		location.href = "home.do";
	</script>
</c:if>
<c:if test="${pointCheck != '0'}">
	<script type="text/javascript">
		alert("포인트가 부족합니다. 충전 후 이용바랍니다.");
		location.href = "home.do";
	</script>
</c:if>
<c:if test="${result == '0'}">
	<script type="text/javascript">
		alert("투게더 등록을 실패했습니다");  
	</script>
</c:if> 

<%@ include file="togetherShellB.jsp"%>
