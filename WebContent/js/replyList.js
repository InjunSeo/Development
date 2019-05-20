/**
 * 
 */

function regReplyAjax(toNo, ID, reply) {
	var xhttp = new XMLHttpRequest();
	var reply = document.getElementById("replyText").value
	//var reply = $("#replyText").val(); ->jQuery

	xhttp.onreadystatechange = function() {					//요청에 대한 상태가 변화할 때 특정 함수가 불려진다. (함수수행 x , 단순히 불려지는것)(서버로부터 준비)
		if (this.readyState == 4 && this.status == 200) {
			var xmlDoc = this.responseText;
			//open으로 처리된 부분을 responseText로 받아와 xmlDoc 넣음
			$("#J_textCenterAlign").html(xmlDoc);		//업데이트 되어야할 부분
		}
	};
	xhttp.open("POST", "ajax/regReplyAjax.jsp", true);	//1.http요구방식 , 2.요구하는 URL, 3.true=비동기식, false=동기식
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("toNo=" + toNo + "&ID=" + ID + "&reply=" + reply);														//POST 방식으로 요구한 경우 서버로 보내고 싶은 어떠한 데이터라도 가능
}
