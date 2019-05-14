function sessionEmpty() {
	alert("세션이 종료되었습니다.")
	return "home.do";

}

function certAjax(toNo, ID) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if(this.readyState == 4 && this.status == 200) {
			
			var result = Number(this.responseText);
			
			
			if(result > 0) {
				alert("인증 완료했습니다.");

			} else if(result == 0) {
				alert("인증 실패했습니다");

			} else if(result == -1) {
				alert("이미 인증한 바 있습니다.");

			}
		}
	};
	xhttp.open("POST", "ajax/certProAjax.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

	xhttp.send("toNo=" + toNo + "&ID=" + ID);
}

// 인증페이지에서 파일 첨부시 확장자 jpg, jpeg, bmp 등만 가능
function constrainedExtension() {
	var fileExt = document.getElementById("s_certFile").value;
	fileExt = fileExt.slice(fileExt.indexOf('.') +1).toLowerCase();		
	if (fileExt != "jpg" && fileExt != "jpeg" && fileExt != "bmp" && fileExt != "png" && fileExt != "gif" ) {
		$("#s_certFile").val("");
		alert("첨부파일은 이미지만 가능합니다.");
		return
	}
}

function minCharge() {
	var inputNumber  = document.getElementById("s_charge").value;
	if (inputNumber < 1000 ) {
		alert("1000 point 이상의 값을 입력하세요");
		focus.$("#s_certFile").name("");
		return
	}
}

function chargeAjax(str){
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if(this.readyState ==4 && this.status == 200) {
			
			var result = this.responseText;
			switch (Number(result)) {
			case 1:
				msg = "카카오 결재를 선택하셨습니다";
				break;
			case 2:
				msg = "카드 결재를 선택하셨습니다";
				break;
			case 3:
				msg = "계좌 이체를 선택하셨습니다";
				break;
			case 4:
				msg = "상품권 /쿠폰을 선택하셨습니다";
				break;
			}
			alert(msg);
		}
	};
	xhttp.open("POST", "ajax/chargeProFormAjax.jsp", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("check="+ str);
}


