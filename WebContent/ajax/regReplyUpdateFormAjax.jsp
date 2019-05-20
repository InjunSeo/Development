<%@page import="java.util.List"%>
<%@page import="dto.Reply"%>
<%@page import="dao.JycDao"%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	System.out.println("[regReplyUpdateAjax.jsp] start");
	request.setCharacterEncoding("utf-8");

	JycDao jd = JycDao.getInstance();
	
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

		//해당 투게더 댓글 정보		
		List<Reply> list = jd.getReplyList(toNo);
		pageContext.setAttribute("replyList", list);				
	}
	
%>

<div id="J_textCenterAlign">
	<p></p>
	<input id="replyText" type="text" class="j_comment" name="reply" value="<%=sReply%>"><p></p>
	<table>
	<tr id="j_replyUpdateFromButton">
		<td>
			<a onclick="regReplyUpdateProAjax(<%=sToNo%>, '${member.ID }' , <%=sSeq%> )">댓글수정</a>
		</td>
		<td>
			<a onclick="location.href = 'info.do?toNo=<%=sToNo%>' ">뒤로가기</a>	
		</td>
	</tr>
	</table>
	<p></p>
	
	<c:forEach var="reply" items="${replyList }">
		<hr>
		<c:choose>
				<c:when test="${member.ID == reply.creatorID }">
					<div class="j_creatorIDReply">${reply.creatorID}</div>
					<div class="j_replyReply">${reply.reply }</div>
					<div class="j_createDateReply">${reply.createDateWithDelimiter }
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



