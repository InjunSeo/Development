function chk() {
	if(!frm.startDate.value){
		alert("투게더 시작 날짜를 입력해주세요.")
		return false;
	}
	if(!frm.endDate.value){
		alert("투게더 종료 날짜를 입력해주세요.")
		return false;
	}
	return true;
}

/*
 * 		최대모집인원(maxPerson)은 최소인원(minPerson) 보다 작을 수 없음  
 */
function minValue(){
	var a = document.getElementById("l_minPerson").value;
	document.getElementById("l_maxPerson").value = a;
	document.getElementById("l_maxPerson").min = a;
}

/*		
 *		시작일(startDate)은 종료일(endDate) 이후 날짜 선택 불가
 *		종료일(endDate)은 시작일(startDate) 이전 날짜 선택 불가
 */
//시작일.
$(function() {
	$( '#l_startDate' ).datepicker({
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		dayNamesMin:["일","월","화","수","목","금","토"],
		changeMonth: true,
		changeYear: true,
		dateFormat: "yymmdd", 
		minDate : "+1D",
		onClose: function() {
			var endMin = $("#l_startDate").datepicker("getDate");
			endMin.setDate(endMin.getDate()+1);
			$("#l_endDate").datepicker( "option", "minDate", endMin );
		}
	});
	$('#l_endDate').datepicker({
		monthNamesShort: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
		dayNamesMin:["일","월","화","수","목","금","토"],
		changeMonth: true,
		changeYear: true,
		dateFormat: "yymmdd",
		changeMonth: true,
		onClose: function() {
			var startMax = $("#l_endDate").datepicker("getDate");
			startMax.setDate(startMax.getDate()-1); 
			$("#l_startDate").datepicker( "option", "maxDate", startMax );
		}                
	});
});

//이미지파일 유효성검사
function fileCheck(obj){
	var val = obj.value;
	var point = val.lastIndexOf('.');
	var tempFileType = val.substring(point+1, val.length);
	var fileType = tempFileType.toUpperCase()
	if(fileType=='JPG'||fileType=='GIF'||fileType=='PNG'||fileType=='JPEG'||fileType=='BMP' || fileType==null || filType==''){
		return true;
	} else {
		alert("이미지 파일(JPG, GIF, PNG, JPEG, BMP)만 등록가능 합니다.")
		frm.thumPath.value = "";
		return false;
	}
}

$(document).ready(function(){
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
            reader.onload = function (e) { 
            //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                $('#l_preView').attr('src', e.target.result);
                //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                //(아래 코드에서 읽어들인 dataURL형식)
            }                    
            reader.readAsDataURL(input.files[0]);
            //File내용을 읽어 dataURL형식의 문자열로 저장
        }
    }//readURL()--

    //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
    $("#l_thum").change(function(){
    	readURL(this);
    });
 });

