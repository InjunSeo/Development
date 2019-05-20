<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>


<c:forEach var="together" items="${list}">
	<div class="p_firstScreenTitle">${together.title}</div>
	<div class="p_firstScreen">
		<a href="info.html">
			<img class="p_TogetherImg" alt="투게더 썸네일 ${together.thumPath}"
				src="${together.thumPath}">
		</a>

		<div class="p_firstScreenBrief">
			총포인트: ${together.grossPoint} 만원,<br> 참여포인트: ${together.joinPoint}, <br>
			잔액: ${together.remainPoint} 만원, <br> 참여자: ${together.joinPerson} 명, <br>
			기간: ${together.startDateWithDelimiter}~${together.endDateWithDelimiter}
		</div>
		<div class="p_firstScreenDesc">${together.description}</div>
	</div>
<br>

</c:forEach>
