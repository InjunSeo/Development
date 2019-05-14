<%@page import="dto.Together"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<div class="p_myTogetherContainer" title="${together.title}">
  <div class="p_myTogetherContainer${together.status}">

    <a href="info.do?toNo=${together.toNo}">
      <img class="p_myTogetherImg" alt="투게더 썸네일 ${together.thumPath}"
        src="${together.thumPath}">
    </a>
    <c:if test="${together.status==Together.getStatusRecruit()}">
      <button id="p_withdrawButton" class="p_joinButton"
        onclick="withdrawAjax(${together.toNo}, '${member.ID}')">참여취소</button>
    </c:if>
    <c:if test="${together.status==Together.getStatusIng()}">
      <button id="p_cert" class="p_joinButton"
        onclick="certAjax_saintp(${together.toNo}, '${member.ID}')">인증하기</button>
    </c:if>
    <a href="info.do?toNo=${together.toNo}">
      [${together.status==Together.getStatusRecruit()?'모집중':''}
      ${together.status==Together.getStatusIng()?'진행중':''}
      ${together.status==Together.getStatusFinished()?'종료':''}
      ${together.status==Together.getStatusCanceled()?'취소':''}]
      ${together.title}
      <%-- ${together.startDateWithDelimiter}~${together.endDateWithDelimiter} --%>
    </a>
    <div id="ID${together.toNo}" class="p_viewTogetherAjax"
      onclick="viewTogetherAjax(${together.toNo}, 'ID${together.toNo}')">상세(For
      Ajax)</div>
  </div>
</div>