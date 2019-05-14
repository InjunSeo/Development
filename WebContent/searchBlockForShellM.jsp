<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>

<div class="p_searchContainer">
  <form action="home.do" method="post">
    <div class="p_searchBlock">
      <input type="text" name="searchWord" placeholder=" 검색할 투게더명을 입력하세요." value="${searchWord}"><input type="submit" value="검색">
    </div>

    <div class="p_checkBoxs">
      <input id="p_checkedCancel" type="checkbox" name="canceled"
        ${ canceled == null ? "" : "checked"}
        value="${Together.getStatusCanceled()}"
        onclick="handleStatusChxBxForAll()">
      취소
      <input id="p_checkedRecruit" type="checkbox" name="recruit"
        ${ recruit == null ? "" : "checked"}
        value="${Together.getStatusRecruit()}"
        onclick="handleStatusChxBxForAll()">
      모집중
      <input id="p_checkedIng" type="checkbox" name="ing"
        ${ ing == null ? "" : "checked"} value="${Together.getStatusIng()}"
        onclick="handleStatusChxBxForAll()">
      진행중
      <input id="p_checkedFinished" type="checkbox" name="finished"
        ${ finished == null ? "" : "checked"}
        value="${Together.getStatusFinished()}"
        onclick="handleStatusChxBxForAll()">
      종료

      <input id="p_checkedAll" type="checkbox" name="all"
        ${ all == null ? "" : "checked"} value="${Together.getStatusAll()}"
        onclick="handleStatusChxBxByAll()">
      모두
    </div>
  </form>
</div>