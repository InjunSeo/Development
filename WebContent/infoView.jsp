<%@page import="util.Util"%>
<%@page import="dto.Together"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="togetherShellT.jsp" />

<!-- 이부분에 본인의 css를 넣으세요. 시작 -->
<link type="text/css" rel="stylesheet" href="css/info.css">
<!-- 이부분에 본인의 css를 넣으세요. 끝 -->

<!-- jQuery가 필요 없으면 이 부분을 지우세요. 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 수정,삭제버튼 때문에 삽입 (성용) -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- 수정,삭제버튼 때문에 삽입 (성용) -->


<!-- jQuery가 필요 없으면 이 부분을 지우세요. 끝 -->


<!-- 이부분에 본인의 .js를 넣으세요. 시작 -->
<script src="js/jyc.js"></script>
<script src="js/togetherCheck.js"></script> <!-- 성용 -->

<!-- 이부분에 본인의 .js를 넣으세요. 끝 -->

<%@ include file="togetherShellM.jsp"%>

<!-- 자바스크립트로 투게더 삭제 권한체크를 위한 Element 세팅 -->

<!-- 수정,삭제버튼 때문에 넣어본거 (성용) -->
<input type="hidden" id="creatorID" value ="${together.creatorID }">
<input type="hidden" id="status" value ="${together.status }">
<input type="hidden" id="id" value ="${sessionScope.member.ID }">
<input type="hidden" id="toNo" value ="${together.toNo }">
<!-- 수정,삭제버튼 때문에 넣어본거 (성용) -->


<!-- 각자 변경해야 하는 부분 시작 -->
<div>

	<div class="j_togetherContainer">
      <div class="j_togetherTitle">
        <span title="${together.title}"> [
          ${together.status==Together.getStatusCanceled()? '취소' : ''}
          ${together.status==Together.getStatusRecruit()? '모집중' : ''} ${ together.status == Together.getStatusIng()? '진행중' : ''}
          ${together.status==Together.getStatusFinished()? '종료' : ''} ]
          ${together.title} </span>
      </div>
      <div class="j_togetherContent">
          <img class="j_TogetherImg" alt="투게더 썸네일 ${together.thumPath}"
            src="${together.thumPath}">
            <div class="j_infoFontColor">
           	 	${together.description}
           	 </div>
          <span class="j_togetherBrief">
           	 생성일 : ${together.createDateWithDelimiter }
           	 시작일 : ${together.startDateWithDelimiter }
            <br>
                         종료일 : ${together.endDateWithDelimiter}  
                         최소참여인원 : ${together.minPerson }             
            <br>
                         최대 참여인원 : ${together.maxPerson }
                         현재 참여인원 : ${together.joinPerson }
            <br>
           	 참여 열정포인트 : ${String.format( "%,10d", together.joinPoint) }
            <br>
          	 잔여 열정포인트 : ${String.format( "%,10d", together.remainPoint)}
            <br>
           	 총 열정포인트 : ${String.format( "%,10d", together.grossPoint)}
          </span>
      </div>
    </div>

	<!-- 수정,삭제버튼 때문에 넣어본거 (성용) -->
	<table>
	<tr id="j_togetherUpDelButton">
		<td id="l_modbtn">
			<a onclick="modifyCheck()"> 투게더 수정 </a>
		</td>
		<td id="l_delbtn">
			<a onclick="deleteCheck()"> 투게더 삭제 </a>
		</td>
	</tr>
	<!-- 수정,삭제버튼 때문에 넣어본거 (성용) -->
	</table>
	
	<div id="J_textCenterAlign">

		<div>
			<p></p>
			<input id="replyText" type="text" class="j_comment" name="reply"><p></p>
				<div id ="j_replyButton">
					<a onclick="regReplyInsertAjax(${together.toNo}, '${member.ID }')">댓글입력</a>
				</div>
			<p></p>
		</div>

		<c:forEach var="reply" items="${replyList }">
			<hr>
			
			<c:choose>
				<c:when test="${member.ID == reply.creatorID }">
					<div class="j_creatorIDReply">${reply.creatorID}</div>
					<div class="j_replyReply">${reply.reply }</div>
					<div class="j_createDateReply">${reply.createDateWithDelimiter }
					<a onclick="regReplyDeleteAjax(${together.toNo},'${member.ID }',${reply.seq })">삭제</a>
					<a onclick="regReplyUpdateFormAjax(${together.toNo},'${member.ID }',${reply.seq }, '${reply.reply }' )">수정</a>
					
					</div>
				</c:when>
				<c:when test="${member.ID != reply.creatorID }">
					<div class="j_creatorIDReply">${reply.creatorID}</div>
					<div class="j_replyReply">${reply.reply }</div>
					<div class="j_createDateReply">${reply.createDateWithDelimiter }</div>
				</c:when>
			</c:choose>
		</c:forEach>
	</div>

</div>




<!-- 각자 변경해야 하는 부분 끝-->
<jsp:include page="togetherShellB.jsp" />