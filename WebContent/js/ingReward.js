function closeIngAjax() {
	$("#h_viewAjaxC").css("display", "none");
}



function viewIngAjax(toNo) {
	$("#h_viewAjaxC").css({"position" : "fixed", "top" : "30%", "left" : "30%"});
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if(this.readyState == 4 && this.status == 200) {
			var result = this.responseText;
			// (result) 저장한 값 - > html 형식으로 - > 이 id를 가진 얘한테 뿌려줄꺼야. $("#****")
			$("#h_ingAjax").html(result); // 지금 데이터를 가지고 result 값으로 가지고 있어. 이걸 보여줘
			$("#h_viewAjaxC").css("display", "block");
		}
	};
	xhttp.open("GET", "ajax/ingMemberRewardAjax.jsp?toNo=" + toNo, true);
	xhttp.send();
	
}

function ingFunc1() {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;

			$(".h_contbox").html(result);
			document.getElementById("h_ingListBtn1").style.background = "#FD5F13";
			document.getElementById("h_ingListBtn1").style.color = "white";
			document.getElementById("h_ingListBtn2").style.background = "white";
			document.getElementById("h_ingListBtn2").style.color = "black";
			
		}
	};
	xhttp.open("GET", "ajax/ingListAjax.jsp?ingListSort=1", true);
	xhttp.send();
}

function ingFunc2() {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;

			$(".h_contbox").html(result);
			document.getElementById("h_ingListBtn1").style.background = "white";
			document.getElementById("h_ingListBtn1").style.color = "black";
			document.getElementById("h_ingListBtn2").style.background = "#FD5F13";
			document.getElementById("h_ingListBtn2").style.color = "white";
			
		}
	};
	xhttp.open("GET", "ajax/ingListAjax.jsp?ingListSort=2", true);
	xhttp.send();
}

/*function btnActive() {
	var btnContainer = document.getElementById("l_BtnContainer");
	var btns = btnContainer.getElementsByClassName("l_btn");
	for (var i = 0; i < btns.length; i++) {
	   btns[i].addEventListener("click", function(){
			var current = document.getElementsByClassName("active");
			current[0].className = current[0].className.replace(" active", "");
	   		this.className += " active";
	   });
	}
}*/