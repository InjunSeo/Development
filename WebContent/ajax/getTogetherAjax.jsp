<%@page import="dto.Together"%>
<%@page import="dao.SaintpDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%
	request.setCharacterEncoding("utf-8");
	String sToNo = request.getParameter("toNo");
	int toNo = 0;

	SaintpDao dao = SaintpDao.getInstance();
	if (sToNo != null && !sToNo.equals("")) {
		toNo = Integer.parseInt(sToNo);

		Together together = dao.getTogether(toNo);
		pageContext.setAttribute("together", together);
	}
%>

<img id="p_togetherAjaxThumPath" src="${together.thumPath}">
<div id="p_togetherAjaxContent">
  <div id="p_togetherAjaxTitle">
    [${together.status==Together.getStatusCanceled()?'취소':''}${together.status==Together.getStatusRecruit()?'모집중':''}${together.status==Together.getStatusIng()?'진행중':''}${together.status==Together.getStatusFinished()?'종료':''}]
    ${together.title} (No.${together.toNo})</div>
  <div id="p_togetherAjaxMiddle">
    <div>${together.startDateWithDelimiter}~
      ${together.endDateWithDelimiter}</div>
    <div>[참여포인트] ${String.format( "%,10d", together.joinPoint)} 원</div>
    <c:if test="${together.status!=Together.getStatusRecruit()}">
      <div>[잔여포인트] ${String.format( "%,10d", together.remainPoint)} 원</div>
    </c:if>
    <div>[참여인원] ${String.format( "%,10d", together.joinPerson)} 명
      (최소${String.format( "%,10d", together.minPerson)} /최대${String.format( "%,10d", together.maxPerson)})</div>
    <hr>
    <div>${together.description}</div>
  </div>
  <div id="p_togetherAjaxFooter">[${together.creatorID}]
    ${together.createDateWithDelimiter}</div>
</div>