<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>
   

<%@ include file="togetherShellT.jsp"%>


  <!-- 이부분에 본인의 css를 넣으세요. 시작 -->
  <link type="text/css" rel="stylesheet" href="css/recruitList.css"> 
  <!-- 이부분에 본인의 css를 넣으세요. 끝 -->
     
  <!-- 이부분에 본인의 .js를 넣으세요. 시작 -->
   <!-- <script src="js/recruitList.js"></script> -->
  <!-- 이부분에 본인의 .js를 넣으세요. 끝 -->
  
<%@ include file="togetherShellM.jsp"%>

<!-- 각자 변경해야 하는 부분 시작 -->

<div class="y_bigGathTo">
		<div class="y_sorting">		
			
			<c:if test="${sorting == 1 }">
				<input type="radio" name="sorting" value="1" onclick= "location.href='recruitList.do?sorting=1'" checked="checked"> 최신순
				<input type="radio" name="sorting" value="2" onclick= "location.href='recruitList.do?sorting=2'"> 인원순
				<input type="radio" name="sorting" value="3" onclick= "location.href='recruitList.do?sorting=3'"> 금액순
	        </c:if>
			<c:if test="${sorting == 2 }">
				<input type="radio" name="sorting" value="1" onclick= "location.href='recruitList.do?sorting=1'" > 최신순
				<input type="radio" name="sorting" value="2" onclick= "location.href='recruitList.do?sorting=2'" checked="checked"> 인원순
				<input type="radio" name="sorting" value="3" onclick= "location.href='recruitList.do?sorting=3'"> 금액순
	        </c:if>
			<c:if test="${sorting == 3 }">
				<input type="radio" name="sorting" value="1" onclick= "location.href='recruitList.do?sorting=1'"> 최신순
				<input type="radio" name="sorting" value="2" onclick= "location.href='recruitList.do?sorting=2'"> 인원순
				<input type="radio" name="sorting" value="3" onclick= "location.href='recruitList.do?sorting=3'" checked="checked"> 금액순
	        </c:if>
		</div>
		
	<c:forEach var="together" items="${list}">
		<div class="y_gathTo">
			<a id= "y_anchor" href="info.do?toNo=${together.toNo}">
			<div class="y_gathImg">
				<img alt="${together.thumPath}" src="${together.thumPath}">
			</div>
			<div class="y_gathTitle">
				${together.title}
			</div>
			<div class="y_gathinfo">
			기간: ${together.startDateWithDelimiter} ~ ${together.endDateWithDelimiter} <br><br>
			참여인원: ${together.joinPerson }/${together.maxPerson }명 <br><br>
			참가금액: ${ String.format( "%,10d", together.joinPoint) }원
			</div>
			</a>
			<div class="y_gathJoin">
			<button id="y_joinButton" onclick="joinAjax(${together.toNo}, '${member.ID}')">참여하기</button>
			</div>
		</div>

	</c:forEach>

		<div class="y_pageBottom">										
			<div class="y_search">
				<form name= "form" action="recruitSearch.do" >
					<input  type="text" name="search" placeholder="투게더명을 입력하세요">
					<input  type="submit" value="검색" >
				</form>		
			</div>
			<div class="y_pageNumber">
				<c:if test="${startPage > blockSize}">								<!-- 게시판페이지 --> 
					<a href='recruitList.do?pageNum= ${startpage-blocksize}'>[이전]</a>			<!-- 이전페이지 -->
				</c:if>
				<c:forEach var="i" begin="${startPage }" end="${endPage }">				<!-- 데이터가 있는 수만큼 페이지 수 -->
					<a href='recruitList.do?pageNum=${i}&sorting=${sorting}'>[${i}]</a>
				</c:forEach>
					<c:if test="${endPage < pageCnt }">									<!-- 끝 페이지 보다 페이지카운트가 크다면 -->
						<a href='recruitList.do?pageNum=${startPage+blockSize }'>[다음]</a>		<!-- 다음페이지 -->
					</c:if>
			</div>
		</div>
</div>


<!-- 각자 변경해야 하는 부분 끝-->


<%@ include file="togetherShellB.jsp" %>

