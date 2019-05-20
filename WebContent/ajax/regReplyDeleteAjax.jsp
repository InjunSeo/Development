<%@page import="java.util.List"%>
<%@page import="dto.Reply"%>
<%@page import="dao.JycDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%
	System.out.println("[regReplyDeleteAjax.jsp] start");
	request.setCharacterEncoding("utf-8");

	JycDao jd = JycDao.getInstance();
	Reply reply = new Reply();
	String sToNo = request.getParameter("toNo");
	String sCreatorID = request.getParameter("ID");
	String sSeq = request.getParameter("seq");
	int toNo = 0;
	int result = 0;
	System.out.println("[regReplyDeleteAjax.jsp] sToNo, seq =>" + sToNo +" "+ sSeq);
	if (sToNo != null && !sToNo.equals("")) {
		toNo = Integer.parseInt(sToNo);
	}

	if (toNo != 0) {
		reply.setToNo(toNo);
		reply.setCreatorID(sCreatorID);
		reply.setSeq(Integer.parseInt(sSeq));

		//데이터 삭제
		result = jd.deleteReply(toNo, Integer.parseInt(sSeq));	//pk만 알면 삭제 가능

		//해당 투게더 댓글 정보		
		List<Reply> list = jd.getReplyList(toNo);
		pageContext.setAttribute("replyList", list);
				
	}
%>

<div id="J_textCenterAlign">
	<p></p>
	<input id="replyText" type="text" class="j_comment" name="reply"><p></p>
	<div id ="j_replyButton">
		<a onclick="regReplyInsertAjax(<%=sToNo%>, '${member.ID }')">댓글입력</a>	
	</div>
	<p></p>
	
	<c:forEach var="reply" items="${replyList }">
		<hr>
		<c:choose>
				<c:when test="${member.ID == reply.creatorID }">
					<div class="j_creatorIDReply">${reply.creatorID}</div>
					<div class="j_replyReply">${reply.reply }</div>
					<div class="j_createDateReply">${reply.createDateWithDelimiter }
					<a onclick="regReplyDeleteAjax(<%=sToNo%>, '${member.ID }',${reply.seq })">삭제</a>
					<a onclick="regReplyUpdateFormAjax(<%=sToNo%>,'${member.ID }',${reply.seq }, '${reply.reply }' )">수정</a>
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