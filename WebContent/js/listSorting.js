/**
 * 
 */

function listSortingAjax(sortNum) {
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var result = this.responseText;

			$("#c_list").html(result);
			
		}
	};
	xhttp.open("GET", "ajax/sortingFinListAjax.jsp?sortNum="+sortNum, true);
	xhttp.send();
}