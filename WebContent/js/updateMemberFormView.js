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
