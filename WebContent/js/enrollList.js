function listFilter(s) {
	var status = s;
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var xmlDoc = this.responseText;
			$("#listView").html(xmlDoc);
		}
	}
	xhttp.open("GET", "ajax/enrollListAjax.jsp?status=" + status, true);
	xhttp.send();	
}

function btnActive() {
	var btnContainer = document.getElementById("l_BtnContainer");
	var btns = btnContainer.getElementsByClassName("l_btn");
	for (var i = 0; i < btns.length; i++) {
	   btns[i].addEventListener("click", function(){
			var current = document.getElementsByClassName("active");
			current[0].className = current[0].className.replace(" active", "");
	   		this.className += " active";
	   });
	}
}