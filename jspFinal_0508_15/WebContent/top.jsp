<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>index.jsp</title>
<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<link href="css/base.css" rel="stylesheet" type="text/css">
<style type="text/css">
#wrap #topcont #logo {
	margin-top: 10px;
	margin-left: 20px;
	width: 120px;
	float: left; /*왼쪽 정렬*/
}

#topcont {
	width: 100%;
	height: 55px;
}

#wrap #topcont #t_menu {
	margin-right: 50px;
}

#wrap #topcont #t_menu ul {
	margin-top: 8px;
	margin-left: 10px;
}

#wrap #topcont #t_menu ul li {
	float: left;
	margin-left: 10px;
}

#wrap #topcont #t_menu {
	width: 300px;
	float: right; /*오른쪽 정렬*/
}

#wrap #top #nav {
	width: 1000px;
	height: 30px;
	background-color: #007bbe;
	padding-left: 120px;
	clear: both;
}

#wrap #top #nav ul li {
	float: left;
}
</style>
<script src="js/board.js"></script>

<c:if test="${param.subcmd == 'boardForm'}">
	<%-- top.jsp로 넘어온 파라미터들 중, name이 subcmd인 파라미터의 값이 boardForm일 경우 if문 실행
	자바에서는 request.getParameter("subcmd")=="boardForm"로 표현할 수 있다.
	subcmd가 boardForm인 경우는 글 작성 버튼을 클릭했을 때이므로 
	글 작성 페이지(studyBoardWriter.jsp)를 보여줘야 한다.--%>
	<script src="//cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>

	<%-- 이 때 글 작성 페이지의 내용 영역에서 체크 에디터를 적용하기 위해서
	ckeditor cdn(콘텐츠 전송 네트워크)을 통해 ckeditor.js 파일을 불러온다.--%>
	<script src="js/myckeditor.js"></script>

	<%-- 에디터의 속성을 필요에 맞게 설정하기 위해 
	myckeditor.js(자바 스크립트 소스 파일)을 별도로 만든다. --%>
	<script>
		$(function() {
			chkUpload();
		});
	</script>

</c:if>

<c:if test="${param.cmd == '' || param.cmd == 'index' }">
	<link rel='stylesheet' href='fjs/fullcalendar.min.css' />
	<script src="fjs/lib/moment.min.js"></script>
	<script src="fjs/fullcalendar.min.js"></script>
	<script src="fjs/lang/lang-all.js"></script>
	<script>
		$(function() {
			var currentLangCode = 'ko';
			$('#calendar').fullCalendar('destroy');
			$('#calendar').fullCalendar(
					{

						//lang: currentLangCode,
						dragable : false, //드래그앤 드랍 옵션
						timeFormat : 'hh:mm', //시간 포멧
						// lang: 'ko',  //언어타입
						header : {
							left : 'prev,next today',
							center : 'title',
							right : 'month,agendaWeek,agendaDay'
						},
						// 클릭 이벤트
						eventClick : function(calEvent, jsEvent, view) {
							var r = confirm("Delete " + calEvent.title+": "+calEvent._id);
							if (r == true) {
								$('#calendar').fullCalendar('removeEvents',
										calEvent._id);

							}
						},
						defaultView : 'agendaWeek',//기본 뷰 - 옵션   //첫 페이지 기본 뷰 옵션
						editable : false, //에디터 가능 옵션
						selectable : true,
						selectHelper : true,
						select : function(start, end) {
							var title = prompt('Event Title:');
							var eventData;
							if (title) {
								eventData = {
									title : title,
									start : start,
									end : end
								};
								$('#calendar').fullCalendar('renderEvent',
										eventData, true); // stick? = true
							}
							$('#calendar').fullCalendar('unselect');
							alert("selected from: " + start.format() + ", to: "
									+ end.format());
							// 셀렉트된 결과를 서버로 전송
							$.ajax({
								url : "testAjax.jsp",
								type : "GET",
								data : {
									q : "test"
								},
								dataType : "html",
								success : function(a) {
									alert("Data: " + a);
								},
								error : function(a, b) {
									alert("Request: " + JSON.stringify(a));
								}
							});
						},
						editable : true,
						eventLimit : true,
						events : [

						{
							title : 'All Day Event',
							start : '2015-05-01'
						}, {
							title : 'Long Event',
							start : '2015-05-07',
							end : '2015-05-10'
						}, {
							id : 999,
							title : 'Repeating Event',
							start : '2015-05-09T16:00:00'
						}, {
							id : 999,
							title : 'Repeating Event',
							start : '2015-05-16T16:00:00'
						}, {
							title : 'Conference',
							start : '2015-05-11',
							end : '2015-05-13'
						}, {
							title : 'Meeting',
							start : '2015-05-12T10:30:00',
							end : '2015-05-12T12:30:00'
						}, {
							title : 'Lunch',
							start : '2015-05-12T12:00:00'
						}, {
							title : 'Meeting',
							start : '2015-05-12T14:30:00'
						}, {
							title : 'Happy Hour',
							start : '2015-05-12T17:30:00'
						}, {
							title : 'Dinner',
							start : '2015-05-12T20:00:00'
						}, {
							title : 'Birthday Party',
							start : '2015-05-13T07:00:00'
						}, {
							title : 'Click for Google',
							url : 'http://google.com/',
							start : '2015-05-28'
						} ]
					})
		});
	</script>
</c:if>

<script>
	$(function() {
		imgChange()
	})
</script>

<script type="text/javascript">
	// jQuery로 변경
	function chmenu(img, num) {
		//alert(img.src.replace(".png","_on.png")+":"+num);
		// menu01.png 에서 .png를 찾아서 _on.png로 변경하기 위해서 replace()를 사용.
		if (num == 1) {
			img.src = img.src.replace(".png", "_on.png");
		} else if (num == 2) {
			img.src = img.src.replace("_on.png", ".png");
		}
	}
</script>
</head>
<body>
	<div id="wrap">
		<!--  탑 영역  -->
		<div id="top">
			<!--  탑로고및 탑메뉴영역  -->
			<div id="topcont">
				<div id="logo">
					<a href="index.jsp"><img src="img/logo.png"></a>
				</div>
				<div id="t_menu">
					<ul>
						<li><a href="">Home</a>|</li>
						<li><a href="">Login</a>|</li>
						<li><a href="">Join</a>|</li>
						<li><a href="">고객지원</a>|</li>
						<li><a href="">사이트맵</a></li>
					</ul>
				</div>
			</div>
			<!-- 메뉴영역 -->
			<div id="nav">
				<ul>
					<!-- onmouseover : 마우스를 올렸을 때, onmouseout :마우스를 내렸을 때  -->
					<li><a href="kostainfo.jsp"><img src="img/menu1.png"
							alt="KOSTA50기소개" onmouseover="chmenu(this,'1')"
							onmouseout="chmenu(this,'2')"></a></li>
					<li><a
						href="studyBoard.kosta?cmd=board&page=1&subcmd=boardList"><img
							src="img/menu2.png" alt="스터디게시판" onmouseover="chmenu(this,'1')"
							onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu3.png" alt="포토폴리오"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu4.png" alt="질문과답변"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu5.png" alt="겔러리"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu6.png" alt="면접후기"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu7.png" alt="뉴스&공지"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
				</ul>
			</div>
		</div>