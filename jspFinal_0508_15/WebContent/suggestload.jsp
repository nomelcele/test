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
	// ���� ���� ����(script ���� �ȿ��� ���)
	var lastKey = '';
	var check = false;
	var loopKey = false;
	
	// ���� ����(1)
	// Ŭ���̾�Ʈ�� �Է��ϸ� ����ȴ�.
	function startSuggest() {
		if (check == false) { // ������������ false�� �����Ǿ� �����Ƿ�
			// ó�� ����� �� �� if���� ����ȴ�.
			setTimeout("sendKeyword();", 500);
			// 0.5�� �� sendKeyword() ȣ��
			loopKey = true; 
			// delay ���ȿ� �� �κ��� ����ȴ�.
			// setTimeout�� 0.5�ʵ��� ���� ����, �� ���� �Ʒ� �ڵ���� ����ǰ�
			// 0.5�� �Ŀ� setTimeout�� ù��° ������ �Լ��� ����
		}
		check = true;
	}
	
	// ���� ����(2)
	function sendKeyword() {
		if (loopKey == false) {
			return; // sendKeyword() �Լ��� ������.
		}
		var key = f.word.value; // f��� name�� form �±� �ȿ� �ִ� 
		// word��� name�� ���� �±��� value�� �����´�.
		// => ����ڰ� �Է��� ��
		if (key == '' || key == ' ') { // �� ���̰ų� ������ ���� ��
			lastKey = ''; 
			document.getElementById("view").style.display = 'none';
			// name�� view�� div�� ������ �ʰ� �Ѵ�.
		} else if (key != lastKey) {
			lastKey = key; 
			var param = "key=" + encodeURIComponent(key); // ���� ����
			sendRequest("suggest.jsp", param, res, "post"); 
			// url, param, callback, method
			// �񵿱������ ó���� ������, �Ķ����, �ݹ��Լ�, ���� ���
		}
		setTimeout("sendKeyword();", 500);
	}

	var jsonObj = null;
	function res() {
		if (xhr.readyState == 4) { 
			if (xhr.status == 200) {
				var response = xhr.responseText; // ����
				jsonObj = JSON.parse(response); 
				// parse: ���� ���� �� jsonObj�� �ִ´�.
				viewTable();
			} else {
				document.getElementById("view").style.display = 'none';
			}
		}
	}
	
	function viewTable() {
		// ���̺��� ����� �Լ�
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
			<!-- onkeydown: Ű�� ������ �� ���� -->
		<input type="submit" value="�˻�" />
		<div id="view"></div>
	</form>
</body>
</html>