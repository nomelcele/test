<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
#view {
	width: 200px;
	border: 1px solid gray;
	border-top: 0px;
	margin-top: -1px;
	display: none;
	font-family: NanumGothic;
	font-size: 10px
}

table {
	width: 200px;
	border: 1px;
	color: gray;
	font-size: 12px
}
</style>
<script src="js/http.js"></script>
<script src="js/json2.js"></script>
<script>
	// 전역 변수 선언(script 구문 안에서 사용)
	var lastKey = '';
	var check = false;
	var loopKey = false;
	
	// 실행 순서(1)
	// 클라이언트가 입력하면 실행된다.
	function startSuggest() {
		if (check == false) { // 전역변수에서 false로 설정되어 있으므로
			// 처음 실행될 때 이 if문이 수행된다.
			setTimeout("sendKeyword();", 500);
			// 0.5초 후 sendKeyword() 호출
			loopKey = true; 
			// delay 동안에 이 부분이 수행된다.
			// setTimeout은 0.5초동안 멈춤 상태, 그 동안 아래 코드들이 실행되고
			// 0.5초 후에 setTimeout의 첫번째 인자인 함수가 실행
		}
		check = true;
	}
	
	// 실행 순서(2)
	function sendKeyword() {
		if (loopKey == false) {
			return; // sendKeyword() 함수를 나간다.
		}
		var key = f.word.value; // f라는 name의 form 태그 안에 있는 
		// word라는 name을 가진 태그의 value를 가져온다.
		// => 사용자가 입력한 값
		if (key == '' || key == ' ') { // 빈 값이거나 공백이 있을 때
			lastKey = ''; 
			document.getElementById("view").style.display = 'none';
			// name이 view인 div를 보이지 않게 한다.
		} else if (key != lastKey) {
			lastKey = key; 
			var param = "key=" + encodeURIComponent(key); // 깨짐 방지
			sendRequest("suggest.jsp", param, res, "post"); 
			// url, param, callback, method
			// 비동기식으로 처리할 페이지, 파라미터, 콜백함수, 보낼 방식
		}
		setTimeout("sendKeyword();", 500);
	}

	var jsonObj = null;
	function res() {
		if (xhr.readyState == 4) { 
			if (xhr.status == 200) {
				var response = xhr.responseText; // 응답
				jsonObj = JSON.parse(response); 
				// parse: 문법 점검 후 jsonObj에 넣는다.
				viewTable();
			} else {
				document.getElementById("view").style.display = 'none';
			}
		}
	}
	
	function viewTable() {
		// 테이블을 만드는 함수
		var vD = document.getElementById("view");
		var htmlTxt = "<table>";
		for (var i = 0; i < jsonObj.length; i++) {
			htmlTxt += "<tr><td style='cursor:pointer;'onmouseover='this.style.background=\"silver\"'onmouseout='this.style.background=\"white\"' onclick='select("
					+ i + ")'>" + jsonObj[i] + "</td></tr>";
		}
		htmlTxt += "</table>";
		vD.innerHTML = htmlTxt;
		vD.style.display = "block";
	}
	
	function select(index) {
		f.word.value = jsonObj[index];
		document.getElementById("view").style.display = 'none';
		check = false;
		loopKey = false;
	}
</script>
</head>
<body>
	<form name="f">
		<input type="text" style="width: 200px;" name="word"
			onkeydown="startSuggest();" autocomplete="off"/> 
			<!-- onkeydown: 키가 눌렸을 때 실행 -->
		<input type="submit" value="검색" />
		<div id="view"></div>
	</form>
</body>
</html>