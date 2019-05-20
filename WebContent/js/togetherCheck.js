$(function(){
	var creatorID = document.getElementById("creatorID").value;
	var id = document.getElementById("id").value;
	var status = document.getElementById("status").value;
	if(creatorID != id){
		$('#l_modbtn').hide();
		$('#l_delbtn').hide();
	}
	if(status != 1){
		$('#l_modbtn').hide();
	
	}
	if(status == 2 || status == 3 ){
		$('#l_delbtn').hide();
	}
});

function modifyCheck() {
	var status = document.getElementById("status").value;
	var toNo = document.getElementById("toNo").value;
	var creatorID = document.getElementById("creatorID").value;
	var id = document.getElementById("id").value;
	
	if(creatorID != id){
		alert("투게더 수정 권한이 없습니다.")
		return false;
	}
	if(status != 1){
		alert("모집중인 투게더만 수정 할 수 있습니다.")
		return false;
	}
	return location.href="togetherModifyForm.do?toNo="+toNo;
}

function deleteCheck() {
	var status = document.getElementById("status").value;
	var toNo = document.getElementById("toNo").value;
	var creatorID = document.getElementById("creatorID").value;
	var id = document.getElementById("id").value;
	
	if(creatorID != id){
		alert("투게더 삭제 권한이 없습니다.")
		return false;
	}
	if(status == 2 || status == 3){
		alert("삭제할 수 없는 투게더 입니다.")
		return false;
	}
	return location.href="togetherDeletePro.do?toNo="+toNo;
}
