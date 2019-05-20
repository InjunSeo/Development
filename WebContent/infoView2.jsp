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
<div class="J_mainBox">
	<div class="J_imgBox">
		<img class="J_imgwidth" src="${together.thumPath}"
			alt="${together.thumPath}">
		<div class="J_imgContent">
			<h1>${together.title }</h1>
			<p>${together.description }</p>
		</div>
	</div>

	<table class="J_textCenterAlign">
		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">투게더 생성 날짜</td>
			<td class="J_togetherInfoAlign">${together.createDateWithDelimiter }</td>
		</tr>

		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">시작 일자</td>
			<td class="J_togetherInfoAlign">${together.startDateWithDelimiter }</td>
		</tr>
		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">종료 일자</td>
			<td class="J_togetherInfoAlign">${together.endDateWithDelimiter}</td>
		</tr>
		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">최소 참여 인원</td>
			<td class="J_togetherInfoAlign">${together.minPerson }</td>
		</tr>
		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">최대 참여 인원</td>
			<td class="J_togetherInfoAlign">${together.maxPerson }</td>
		</tr>
		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">현재 참여 인원</td>
			<td class="J_togetherInfoAlign">${together.joinPerson }</td>
		</tr>
		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">참여 열정 포인트</td>
			<td class="J_togetherInfoAlign">${String.format( "%,10d", together.joinPoint) }</td>
		</tr>
		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">잔여 열정 포인트</td>
			<td class="J_togetherInfoAlign">${String.format( "%,10d", together.remainPoint)}</td>
		</tr>
		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">총 포인트</td>
			<td class="J_togetherInfoAlign">${String.format( "%,10d", together.grossPoint)}</td>
		</tr>
		<tr class="J_togetherInfoAlign">
			<td class="J_togetherInfoAlign">상태</td>
			<td class="J_togetherInfoAlign">
			<c:if
					test="${together.status == Together.getStatusCanceled() }">
				취소
			</c:if> <c:if test="${together.status == Together.getStatusRecruit() }">
				모집중
			</c:if> <c:if test="${together.status == Together.getStatusIng() }">
				진행중
			</c:if> <c:if test="${together.status == Together.getStatusFinished() }">
				종료
			</c:if></td>
		</tr>
		
		<!-- 수정,삭제버튼 때문에 넣어본거 (성용) -->
		<tr>
			<td><button id="l_modbtn" onclick="modifyCheck()">투게더 수정</button>
			<button id="l_delbtn" onclick="deleteCheck()">투게더 삭제</button></td>
		</tr>
		<!-- 수정,삭제버튼 때문에 넣어본거 (성용) -->
		
	</table>

	<div id="J_textCenterAlign">

		<div>
			<p></p>
			<input id="replyText" type="text" class="j_comment" name="reply">
			<button onclick="regReplyInsertAjax(${together.toNo}, '${member.ID }')">댓글입력</button>
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