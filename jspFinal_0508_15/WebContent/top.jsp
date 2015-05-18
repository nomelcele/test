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
	float: left; /*���� ����*/
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
	float: right; /*������ ����*/
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
	<%-- top.jsp�� �Ѿ�� �Ķ���͵� ��, name�� subcmd�� �Ķ������ ���� boardForm�� ��� if�� ����
	�ڹٿ����� request.getParameter("subcmd")=="boardForm"�� ǥ���� �� �ִ�.
	subcmd�� boardForm�� ���� �� �ۼ� ��ư�� Ŭ������ ���̹Ƿ� 
	�� �ۼ� ������(studyBoardWriter.jsp)�� ������� �Ѵ�.--%>
	<script src="//cdn.ckeditor.com/4.4.7/standard/ckeditor.js"></script>

	<%-- �� �� �� �ۼ� �������� ���� �������� üũ �����͸� �����ϱ� ���ؼ�
	ckeditor cdn(������ ���� ��Ʈ��ũ)�� ���� ckeditor.js ������ �ҷ��´�.--%>
	<script src="js/myckeditor.js"></script>

	<%-- �������� �Ӽ��� �ʿ信 �°� �����ϱ� ���� 
	myckeditor.js(�ڹ� ��ũ��Ʈ �ҽ� ����)�� ������ �����. --%>
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
						dragable : false, //�巡�׾� ��� �ɼ�
						timeFormat : 'hh:mm', //�ð� ����
						// lang: 'ko',  //���Ÿ��
						header : {
							left : 'prev,next today',
							center : 'title',
							right : 'month,agendaWeek,agendaDay'
						},
						// Ŭ�� �̺�Ʈ
						eventClick : function(calEvent, jsEvent, view) {
							var r = confirm("Delete " + calEvent.title+": "+calEvent._id);
							if (r == true) {
								$('#calendar').fullCalendar('removeEvents',
										calEvent._id);

							}
						},
						defaultView : 'agendaWeek',//�⺻ �� - �ɼ�   //ù ������ �⺻ �� �ɼ�
						editable : false, //������ ���� �ɼ�
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
							// ����Ʈ�� ����� ������ ����
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
	// jQuery�� ����
	function chmenu(img, num) {
		//alert(img.src.replace(".png","_on.png")+":"+num);
		// menu01.png ���� .png�� ã�Ƽ� _on.png�� �����ϱ� ���ؼ� replace()�� ���.
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
		<!--  ž ����  -->
		<div id="top">
			<!--  ž�ΰ�� ž�޴�����  -->
			<div id="topcont">
				<div id="logo">
					<a href="index.jsp"><img src="img/logo.png"></a>
				</div>
				<div id="t_menu">
					<ul>
						<li><a href="">Home</a>|</li>
						<li><a href="">Login</a>|</li>
						<li><a href="">Join</a>|</li>
						<li><a href="">������</a>|</li>
						<li><a href="">����Ʈ��</a></li>
					</ul>
				</div>
			</div>
			<!-- �޴����� -->
			<div id="nav">
				<ul>
					<!-- onmouseover : ���콺�� �÷��� ��, onmouseout :���콺�� ������ ��  -->
					<li><a href="kostainfo.jsp"><img src="img/menu1.png"
							alt="KOSTA50��Ұ�" onmouseover="chmenu(this,'1')"
							onmouseout="chmenu(this,'2')"></a></li>
					<li><a
						href="studyBoard.kosta?cmd=board&page=1&subcmd=boardList"><img
							src="img/menu2.png" alt="���͵�Խ���" onmouseover="chmenu(this,'1')"
							onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu3.png" alt="����������"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu4.png" alt="�������亯"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu5.png" alt="�ַ���"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu6.png" alt="�����ı�"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu7.png" alt="����&����"
							onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
				</ul>
			</div>
		</div>