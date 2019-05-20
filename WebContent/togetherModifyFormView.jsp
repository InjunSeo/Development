<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>

   

<%@ include file="togetherShellT.jsp"%>
  
	<link type="text/css" rel="stylesheet" href="css/enroll.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="js/enroll.js"></script>  
  
<%@ include file="togetherShellM.jsp"%>

<form action="togetherModifyPro.do" method="post" name="frm" enctype="multipart/form-data" onsubmit="return chk()">
	<div class="l_container">
		<h1>투게더 수정</h1>
		<hr class="l_line">
		<table class="l_table">
		<input type="hidden" name="toNo" value="${together.toNo }">
			<tr>
				<th class="l_th"><b>투게더 이름</b></th>
    	  		<td colspan="3"><input type="text" name="title" id="l_title" 
    	  			maxlength="99" class="l_input" value="${together.title }" required> </td>
    	  		<td rowspan="5" ><div id="l_preViewBox"><img id="l_preView" alt="썸네일 미리보기"/></div></div></td>
			</tr>
			<tr>
				<th class="l_th"><b>썸네일</b></th>
				<td colspan="3"><input type="file" name="thumPath" id="l_thum" class="l_input"
					accept='image/jpeg,image/gif,image/png' onchange='fileCheck(this)'></td>
			</tr>
			<tr>
				<th class="l_th"><b>참여 금액</b></th>
			    <td colspan="3"><input name="joinPoint" id="l_point" min="100" max="${point }" step="100" 
			    	class="l_input readOnly" value="${together.joinPoint }" readonly="readonly"> 원</td>
			</tr>
			<tr>
				<th class="l_th"><b>최소 모집 인원</b></th>
			    <td><input type="number" name="minPerson" onchange="minValue()" min="2" id="l_minPerson" 
			    	class="l_input" value="${together.minPerson }" required> 명 </td>
			    	
			    <th class="l_th"><b>투게더 시작일</b></th>
			    <td><input name="startDate" id="l_startDate" class="l_input readOnly" 
					value="${together.startDate }" readonly="readonly"></td>
			</tr>
			<tr>
			    <th class="l_th"><b>최대 모집 인원</b></th>
			    <td><input type="number" name="maxPerson" id="l_maxPerson" 
			    	class="l_input" value="${together.maxPerson }" required> 명</td>
			    <th class="l_th"><b>투게더 종료일</b></th>
			    <td><input name="endDate" id="l_endDate" class="l_input readOnly" 
			    	value="${together.startDate }" readonly="readonly"></td>
			</tr>
			<tr>
				<th colspan="5" class="l_th" id="l_desc"><b>투게더 설명</b></th>
			</tr>
			   <td colspan="5"><textarea  rows="30" class="l_content" name="description" maxlength="1999">${together.description }</textarea></td>
			</tr>
	    </table>   
	   	<hr class="l_line">  
	  	<div class="l_button"> <input type="submit" class="l_enrollbtn" value="수정완료" ></div>  
	</div>
</form>
<c:if test="${check != '0'}">
	<script type="text/javascript">
		alert("로그인을 하세요");  
		location.href="home.do";
	</script>
</c:if> 
<c:if test="${modResult == '0'}">
	<script type="text/javascript">
		alert("투게더 수정을 실패하였습니다.");  
	</script>
</c:if> 
	


<%@ include file="togetherShellB.jsp" %>
