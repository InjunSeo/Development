<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ page import="dto.Together"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="togetherShellT.jsp"%>

<%@ include file="togetherShellM.jsp"%>

<!-- 각자 변경해야 하는 부분 시작 -->

<div id="p_searchTitle">

<c:if test="${empty all && (!empty canceled || !empty recruit || !empty ing || !empty finished)}">
  <c:set var="checked" value="true"/>
</c:if> 

<c:if test="${!empty all && empty searchWord}"> 모든 투게더들의 리스트 입니다.</c:if>
<c:if test="${empty serachword && empty all && empty checked}">상태별 최신 투게더 3개씩입니다.</c:if>

<c:if test="${!empty checked}">
    ${canceled != null ? "[취소]" : ""}
    ${recruit != null ? "[모집중]" : ""}
    ${ing != null ? "[진행중]" : ""}
    ${finished != null ? "[종료]" : ""} 
      상태에 있는  
    <c:if test="${empty searchWord}">투게더들의 리스트입니다.</c:if>
</c:if>

<c:if test="${!empty searchWord}">투게더명 [ ${searchWord}]에 대한 검색 결과입니다.</c:if>

</div>
<div id="p_homeBody">
  <c:forEach var="together" items="${list}">
    <div class="p_togetherContainer">
      <div class="p_togetherTitle">
        <c:if test="${together.status==Together.getStatusRecruit()}">
          <button id="p_joinButton" class="p_joinButton"
            onclick="joinAjax(${together.toNo}, '${member.ID}')">참여(ajax)</button>
        </c:if>
        <span title="${together.title}"> [
          ${together.status==Together.getStatusCanceled()? '취소' : ''}
          ${together.status==Together.getStatusRecruit()? '모집중' : ''} ${ together.status == Together.getStatusIng()? '진행중' : ''}
          ${together.status==Together.getStatusFinished()? '종료' : ''} ]
          ${together.title} </span>
      </div>
      <div class="p_togetherContent">
        <a href="info.do?toNo=${together.toNo}">
          <img class="p_TogetherImg" alt="투게더 썸네일 ${together.thumPath}"
            src="${together.thumPath}">

          <span class="p_togetherBrief">
            *투게더번호: ${ String.format("%,10d", together.toNo)}
            <br>
            *참여포인트: ${ String.format("%,10d", together.joinPoint)}원
            <br>
            *총포인트: ${ String.format("%,10d", together.grossPoint)}원
            <br>
            <c:if test="${together.status==Together.getStatusIng()}">
              *잔여포인트: ${ String.format("%,10d", together.remainPoint)}원
              <br>
            </c:if>
            *참여자: ${ String.format("%,10d", together.joinPerson)}명 (최소 ${String.format("%,10d", together.minPerson)}/최대 ${String.format("%,10d", together.maxPerson)})
            <br>
            *기간: ${together.startDateWithDelimiter}~${together.endDateWithDelimiter}
            <br>
            *생성: ${together.creatorID} (${together.createDateWithDelimiter})
          </span>
          <span class="p_togetherDesc">${together.description}</span>
        </a>
      </div>
    </div>
  </c:forEach>
</div>
<!-- 각자 변경해야 하는 부분 끝-->

<%@ include file="togetherShellB.jsp"%>
