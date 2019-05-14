<%@page import="dto.Member"%>
<%@page import="dto.Together"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

</div>

<div class="p_side">

  <div id="p_memberInfoContainer">

    <img src="img/together.png" alt="img/together.png" id="p_memberInfoBgImg">
    <span id="p_memberInfo">
      <jsp:include page="memberInfoForShellB.jsp"/>
    </span>
  </div>

  <c:if test="${sessionScope.member!=null}">
    <div class="p_myTogetherHead">${sessionScope.member.ID}님이 참여한 투게더 리스트</div>
  </c:if>
  <div id="p_myTogetherList">
    <c:if test="${sessionScope.member!=null && empty myTogetherList}">
      <div class="p_noneList">관련 투게더가 없습니다.</div>
    </c:if>
    <c:forEach var="together" items="${myTogetherList}">
      <%@ include file="togetherListForShellB.jsp"%>
    </c:forEach>
  </div>

  <hr>
  <br>
  <c:if test="${sessionScope.member!=null}">
    <div class="p_myTogetherHead">${sessionScope.member.ID}님이 만든 투게더 리스트</div>
  </c:if>
  <div id="p_CreatedListbyMe">
    <c:if test="${sessionScope.member!=null && empty CreatedListbyMe}">
      <div class="p_noneList">관련 투게더가 없습니다.</div>
    </c:if>
    <c:forEach var="together" items="${CreatedListbyMe}">
      <%@ include file="togetherListForShellB.jsp"%>
    </c:forEach>
  </div>

</div>

</div>

<div id="p_togetherAjaxContainer">
  <a href="javascript:void(0)" id="p_togetherAjaxClose" onclick="closebyID('p_togetherAjaxContainer')">&times;</a>
  <div id="p_togetherAjax"></div>
</div>

<div class="p_footer p_oursHead" onclick="openNav()">중앙 602호 1조: 강성민, 박성인,
  서인준, 윤형석, 이성용, 조용철, 차연지, 허미희</div>
</body>
</html>
