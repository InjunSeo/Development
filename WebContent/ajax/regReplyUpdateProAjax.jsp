<%@page import="java.util.List"%>
<%@page import="dto.Reply"%>
<%@page import="dao.JycDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	System.out.println("[regReplyUpdate2Ajax.jsp] start");
	request.setCharacterEncoding("utf-8");

	JycDao jd = JycDao.getInstance();
	Reply reply = new Reply();
	String sToNo = request.getParameter("toNo");
	String sCreatorID = request.getParameter("ID");
	String sSeq = request.getParameter("seq");
	String sReply = request.getParameter("reply");
	
	System.out.println("[regReplyUpdateAjax.jsp] sToNo -> " + sToNo);
	System.out.println("[regReplyUpdateAjax.jsp] sCreatorID -> " + sCreatorID);
	System.out.println("[regReplyUpdateAjax.jsp] sSeq -> " + sSeq);
	System.out.println("[regReplyUpdateAjax.jsp] sReply -> " + sReply);
	
	int toNo = 0;
	int result = 0;

	if (sToNo != null && !sToNo.equals("")) {
		toNo = Integer.parseInt(sToNo);
	}

	if (toNo != 0) {
		reply.setToNo(toNo);
		reply.setCreatorID(sCreatorID);
		reply.setReply(sReply);

		//댓글 수정(update)
		result = jd.updateReply(Integer.parseInt(sSeq), sReply);

		//해당 투게더 댓글 정보		
		List<Reply> list = jd.getReplyList(toNo);
		pageContext.setAttribute("replyList", list);
	}
%>

<div id="J_textCenterAlign">
	<c:choose>
		<c:when test="${member.ID == null }">
			<script type="text/javascript">
			alert("로그인을 해주세요.");
			location.href="home.do";
			</script>
		</c:when>
		<c:when test="${member.ID != null }">
			<p></p>
			<input id="replyText" type="text" class="j_comment" name="reply"><p></p>
			<div id ="j_replyButton">
				<a onclick="regReplyInsertAjax( <%=sToNo%>, '${member.ID }')">댓글입력</a>	
			</div>
			<p></p>
		</c:when>
	</c:choose>

	
	<c:forEach var="reply" items="${replyList }">
		<hr>
			<c:choose>
				<c:when test="${member.ID == reply.creatorID }">
					<div class="j_creatorIDReply">${reply.creatorID}</div>
					<div class="j_replyReply">${reply.reply }</div>
					<div class="j_createDateReply">${reply.createDateWithDelimiter }
					<a onclick="regReplyDeleteAjax(<%=sToNo%>, '${member.ID }' , ${reply.seq })">삭제</a>
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
