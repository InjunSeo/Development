function handleStatusChxBxForAll() {
	var all = document.getElementById("p_checkedAll");
	var cancel = document.getElementById("p_checkedCancel");
	var recruit = document.getElementById("p_checkedRecruit");
	var ing = document.getElementById("p_checkedIng");
	var finished = document.getElementById("p_checkedFinished");

	if (cancel.checked == true && recruit.checked == true
			&& ing.checked == true && finished.checked == true) {
		all.checked = true;
	} else if (cancel.checked == false || recruit.checked == false
			|| ing.checked == false || finished.checked == false) {
		all.checked = false;
	}
}

function handleStatusChxBxByAll() {
	var all = document.getElementById("p_checkedAll");
	var cancel = document.getElementById("p_checkedCancel");
	var recruit = document.getElementById("p_checkedRecruit");
	var ing = document.getElementById("p_checkedIng");
	var finished = document.getElementById("p_checkedFinished");

	if (all.checked == true) {
		cancel.checked = true;
		recruit.checked = true;
		ing.checked = true;
		finished.checked = true;
	} else {
		cancel.checked = false;
		recruit.checked = false;
		ing.checked = false;
		finished.checked = false;
	}
}

function openNav() {
	$("#p_mySidenav").css("display", "block");
}

function closeNav() {
	$("#p_mySidenav").css("display", "none");
	$("#p_intro").css("display", "none");
}
function visibleIntro(Nm) {
	var disp = "none";
	switch (Nm) {
	case "Kang":
		name = "강성민";
		cont = "로그인/가입";
		break;
	case "Park":
		name = "박성인";
		cont = "초기화면/검색 및 전체 구성";
		disp = "block";
		break;
	case "Seo":
		name = "서인준";
		cont = "MyPage, 인증";
		break;
	case "Youn":
		name = "윤형석";
		cont = "recruiting";
		break;
	case "Lee":
		name = "이성용";
		cont = "투게더 등록/수정/삭제";
		break;
	case "Jo":
		name = "조용철";
		cont = "상세페이지와 댓글";
		break;
	case "Cha":
		name = "차연지";
		cont = "finished";
		break;
	case "Hu":
		name = "허미희";
		cont = "진행 투게더";
		break;
	default:
		name = "박성인";
		cont = "초기화면 및 전체 구성";
		disp = "block";
	}

	$("#p_intName").text(name);
	$("#p_intCont").text(cont);
	$("#p_process").css("display", disp);
	$("#p_intro").css("display", "block");
}

function operCertNTogoStatus(ID) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;

			alert("처리 완료!");
			reloadMemberInfo(ID);
			reloadMyTogetherList(ID);
			reloadTogetherListCreatedByMe(ID);
		}
	};
	xhttp.open("GET", "ajax/operCertNTogoStatusAjax.jsp");
	xhttp.send();
}

function closebyID(id) {
	/* $("#p_togetherAjaxContainer").css("display", "none"); */
	$("#" + id).css("display", "none");
}

function viewTogetherAjax(toNo, element) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;

			var x = $("#" + element).position();

			$("#p_togetherAjax").html(result);
			$("#p_togetherAjaxContainer").css("top", x.top);
			$("#p_togetherAjaxContainer").css("display", "block");
		}
	};
	xhttp.open("GET", "ajax/getTogetherAjax.jsp?toNo=" + toNo, true);
	xhttp.send();
}

function joinAjax(toNo, ID) {
	if (ID == null || ID == "") {
		alert("로긴해 주세요.");
		return;
	}

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;

			// result는 아래의 값 중 하나를 가진다.
			// Join.JOIN_SUCCESS -29
			// Join.JOIN_REJECT_MEMBER_POINT -23
			// Join.JOINED_ALREADY -21
			// Member.NOT_EXIST -31
			// Together.NOT_EXIST -51
			// Join.JOIN_REJECT_TOGETHER_STATUS -22
			switch (Number(result)) {
			case -29:
				msg = "성공적으로 참여하였습니다.";
				reloadMemberInfo(ID);
				reloadMyTogetherList(ID);
				break;
			case -23:
				msg = "회원님의 열정포인트가 참여포인트보다 적습니다.\n"
						+ "포인트를 충전하시거나 참여 취소를 하여 포인트를 늘여주세요.";
				break;
			case -21:
				msg = "이미 참여하셨습니다.";
				break;
			case -31:
				msg = "로긴해 주세요.";
				break;
			case -51:
				msg = "투게더가 삭제되었습니다.";
				break;
			case -52:
				msg = "투게더의 참여자가 이미 최대 인원수에 도달하여 참여하실 수가 없습니다.";
				break;
			case -22:
				msg = "투게더의 상태가 모집중이 아닙니다.";
				break;
			}
			alert(msg);
		}
	};
	xhttp.open("POST", "ajax/joinProAjax.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("toNo=" + toNo + "&ID=" + ID);
}

function withdrawAjax(toNo, ID) {
	if (ID == null || ID == "") {
		alert("로긴해 주세요.");
		return;
	}

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;

			// result는 아래의 값 중 하나를 가진다.
			// Join.JOIN_SUCCESS -29
			// Member.NOT_EXIST -31
			// Together.NOT_EXIST -51
			// Join.JOIN_REJECT_TOGETHER_STATUS -22
			// Join.IS_CREATOR_OF_TOGETHER -28
			switch (Number(result)) {
			case -29:
				msg = "참여를 취소하였습니다.";
				reloadMemberInfo(ID);
				reloadMyTogetherList(ID);
				break;
			case -31:
				msg = "로긴해 주세요.";
				break;
			case -51:
				msg = "투게더가 삭제되었습니다.";
				break;
			case -22:
				msg = "투게더의 상태가 모집중이 아니어서 [참여취소]를 하실 수가 없습니다.";
				break;
			case -28:
				msg = "투게더 생성자는 [참여취소]를 하실 수가 없습니다.";
				break;
			}
			alert(msg);
		}
	};
	xhttp.open("POST", "ajax/withdrawProAjax.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("toNo=" + toNo + "&ID=" + ID);
}

function certAjax_saintp(toNo, ID) {
	if (ID == null || ID == "") {
		alert("로긴해 주세요.");
		return;
	}

	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;

			// result는 아래의 값 중 하나를 가진다.
			// CERT.CERT_SUCCESS -11
			// CERT.ALREADY_CERT -12
			// Member.NOT_EXIST -31
			// Together.NOT_EXIST -51


			switch (Number(result)) {
			case -11:
				msg = "인증되었습니다.";
				break;
			case -12:
				msg = "오늘은 이미 인증하셨습니다.";
				break;
			case -31:
				msg = "로긴해 주세요.";
				break;
			case -51:
				msg = "투게더가 삭제되었습니다.";
				break;
			}
			alert(msg);
		}
	};
	xhttp.open("POST", "ajax/certProAjax_saintp.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("toNo=" + toNo + "&ID=" + ID);
}

function reloadTogetherListCreatedByMe(ID) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;
			$("#p_CreatedListbyMe").html(result);
		}
	};
	xhttp.open("GET", "ajax/getTogetherListCreatedByMeAjax.jsp?ID=" + ID, true);
	xhttp.send();
}

function reloadMyTogetherList(ID) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;
			$("#p_myTogetherList").html(result);
		}
	};
	xhttp.open("GET", "ajax/getMyTogetherListAjax.jsp?ID=" + ID, true);
	xhttp.send();
}

function reloadMemberInfo(ID) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;
			$("#p_memberInfo").html(result);
		}
	};
	xhttp.open("GET", "ajax/getMemberInfoAjax.jsp?ID=" + ID, true);
	xhttp.send();
}

function checkLoginStatus(ID) {
	if (ID == null || ID == "") {
		alert("로긴해 주세요.");
		return;
	}
}

// var x = { name: "saintp", age: 10 };
// function test(){
// arguments[0].gender = "여";
// }
//
// alert( "[pre]" + x.gender);
// test(x);
// alert( "[post]" + x.gender);
