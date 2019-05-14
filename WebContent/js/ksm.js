function formChk() {
	let string = undefined;
	let stringByteLength = 0;

	stringBL = function(string, b, i, c) {
		for (b = i = 0; c = string.charCodeAt(i++); b += c >> 11 ? 3
				: c >> 7 ? 2 : 1)
			;
		return b;
	};
	
	if (stringBL(signupForm.id.value) > 20) {
		alert("아이디가 너무 깁니다.");
		signupForm.id.value = "";
		signupForm.id.focus();
		return false;
	} else if (stringBL(signupForm.name.value) > 50) {
		alert("이름이 너무 깁니다.");
		signupForm.name.value = "";
		signupForm.name.focus();
		return false;
	} else if (stringBL(signupForm.pw.value) > 20) {
		alert("비밀번호가 너무 깁니다.");
		signupForm.pw.value = "";
		signupForm.pwchk.value = "";
		signupForm.pw.focus();
		return false;
	} else if (stringBL(signupForm.email.value) > 30) {
		alert("이메일이 너무 깁니다.");
		signupForm.email.value = "";
		signupForm.email.focus();
		return false;
	}

	if (signupForm.pw.value != signupForm.pwchk.value) {
		alert("비밀번호가 일치하지 않습니다. 다시 입력하세요");
		signupForm.pw.value = "";
		signupForm.pwchk.value = "";
		signupForm.pw.focus();
		return false;
	}
	
	if (document.getElementById("K_button").textContent != "사용 가능") {
		alert("아이디 중복확인을 하세요");
		return false
	}

	return true;
};

function idChk() {
	let tryId = document.getElementById("K_id").value;

	if (tryId.length < 4) {
		alert("아이디는 4자 이상이어야 합니다");
		document.getElementById("K_id").value = "";
		document.getElementById("K_id").focus();
		return false;
	}

	let xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {

		if (this.readyState == 4 && this.status == 200) {
			
			let result = this.responseText;
			
			if (result == 'false') {
				document.getElementById("K_button").textContent = "사용 가능";
				document.getElementById("K_button").style.backgroundColor = "#a4e0f9";
				document.getElementById("K_button").style.color = "#14516b";
			} else {
				document.getElementById("K_button").textContent = "사용 불가";
				document.getElementById("K_button").style.backgroundColor = "#ff9284";
				document.getElementById("K_button").style.color = "#991504";
			}
		}
	};

	xhttp.open("GET", "ajax/existIdAjax.jsp?id=" + tryId, true);
	xhttp.send();
};

function activeBtn() {
	document.getElementById("K_button").textContent = "중복 확인";
	document.getElementById("K_button").style.backgroundColor = "#d6d8db";
	document.getElementById("K_button").style.color = "#28292b";
	document.getElementById("K_id").value = "";
}

function formChk() {

	if (updateForm.newpw.value != updateForm.newpwchk.value) {
		alert("비밀번호가 일치하지 않습니다. 다시 입력하세요");
		updateForm.newpw.value = "";
		updateForm.newpwchk.value = "";
		updateForm.newpw.focus();
		return false;
	}
	
	return true;
};

function loginOpen() {
	
	let xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			let result = this.responseText;

			$( ".p_side").html(result);
		}
	};
	xhttp.open("GET", "loginFormView.jsp", true);
	xhttp.send();
}

function loginPro() {
	let id = document.getElementById("K_id").value;
	let pw = document.getElementById("K_pw").value;

	if (id == "" || pw == "") {
		alert("아이디와 비밀번호를 입력하여 주세요");
		return false;
	} else {
		let xhttp = new XMLHttpRequest();
		
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				let result = this.responseText;
				
				// 로그인에 실패했을 경우
				if (result == 0) {
					document.getElementById("K_lgLoginFailed").innerHTML = "아이디가 없거나 비밀번호가 다릅니다";
					document.getElementById("K_pw").value = "";
					document.getElementById("K_id").focus();
				// 로그인에 성공했을 경우
				} else {
					window.location = "home.do";
				}
			} 
		}
		xhttp.open("POST", "ajax/loginProAjax.jsp", true);
		xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhttp.send("id=" + id + "&pw=" + pw);
	}
	return true;
};

function logOut() {

	let xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if ( this.readyState == 4 && this.status == 200) {
			let result = this.responseText;
			
			if (result == '1') {
				window.location.href = "home.do";
			}
		}
	};
	xhttp.open("GET", "ajax/loginOutAjax.jsp", true);
	xhttp.send();
}