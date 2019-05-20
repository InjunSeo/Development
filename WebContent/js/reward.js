/**
 * 
 */
function closeRewardAjax() {
	$("#c_rewardAjaxContainer").css("display", "none");
}
/*function clickRewardAjax() {
	var loc = $("#c_list").offset();
	console.log("left: " + loc.left + "px, top: " + loc.top + "px");
	$("#c_rewardAjaxContainer").css("left", loc.left + 20);
}
*/
function viewRewardAjax(toNo) {
	$("#c_rewardAjaxContainer").css({"position" : "fixed", "top": "30%", "left": "30%" });
	
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText; // 데이터를 포함한 내가 가져온 폼 전체(스클립틀릿 아래 넣은 코드)

			// id로 하는 이유 = class는 중복되어있을 수 있으므로 고유한 id 설정을 해주는 것이 좋음
			$("#c_rewardAjax").html(result); // 내가 가져온 폼을 뿌릴 장소.뿌려줄 형식(데이터가 저장된 변수)
			$("#c_rewardAjaxContainer").css("display", "block");
		}
	};
	xhttp.open("GET", "ajax/memberRewardAjax.jsp?toNo=" + toNo, true);
	xhttp.send();
}