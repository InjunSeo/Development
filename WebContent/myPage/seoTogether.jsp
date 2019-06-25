<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="frm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="dto.Together"%>


<div id="s_tt">

	<c:forEach var="to" items="${param.isCert == null ? myTogether : myIngList}" varStatus="status">
		<div class="s_myTogetherList">
			<div class="s_gallery">
				<a target="_blank" href="info.do?toNo=${to.toNo}"> <img
					src="${to.thumPath}" alt="사진없음"></a>
				<div class="s_title">${to.title}</div>
				<div class="s_desc">
					참여자: ${to.joinPerson} 명 <br>
					기간:${to.startDateWithDelimiter}~${to.endDateWithDelimiter} <br>
				</div>
				<c:if test="${param.isCert != null}">	
				<div class="s_file"> 			
					<input type="file" id="s_certFile" name="uploadFile"
							onchange="constrainedExtension()" class="fileupload"
							required="required"><br>
				</div>
				
					<button class="s_certButton"
							onclick="certAjax(${to.toNo},'${sessionScope.member.ID}')"
							value="인증하기">인증하기(Ajax)</button>
			
				</c:if>
				<c:if test="${param.isFinished != null }">
				<div class="s_achievement">
					달성률: ${countRateList[status.index]}%
				</div>
				</c:if>
			</div>
		</div>
	</c:forEach>
</div>
