<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>index.jsp</title>
<link href="css/base.css" rel="stylesheet" type="text/css">
<style type="text/css">
	#wrap #topcont #logo {
		margin-top:10px;
		margin-left:20px;
		width: 120px; 
		float: left;/*���� ����*/
	}
	#topcont {
		width: 100%; 
		height: 55px;
	}
	#wrap #topcont #t_menu{ margin-right: 50px;}
	#wrap #topcont #t_menu ul {
	 margin-top:8px;
	 margin-left:10px;
	}
	#wrap #topcont #t_menu ul li{
		float: left; margin-left:10px;
	}
	#wrap #topcont #t_menu{
		width: 300px; 
		float: right;/*������ ����*/
	}
	#wrap #top #nav{
	width:1000px; height:30px;
	background-color:#007bbe;
	padding-left: 120px;
	
	clear: both;
	}
	#wrap #top #nav ul li {
		float: left;
	}
</style>
<script type="text/javascript">
	function chmenu(img,num){
		//alert(img.src.replace(".png","_on.png")+":"+num);
		// menu01.png ���� .png�� ã�Ƽ� _on.png�� �����ϱ� ���ؼ� replace()�� ���.
		if(num == 1){
			img.src = img.src.replace(".png","_on.png");
		}else if(num == 2){
			img.src = img.src.replace("_on.png",".png");
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
					<li><a href="kostainfo.jsp"><img src="img/menu1.png" alt="KOSTA50��Ұ�" 
					onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href="studyBoard.kosta?cmd=stboardList&page=1"><img src="img/menu2.png" alt="���͵�Խ���" onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu3.png" alt="����������" onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu4.png" alt="�������亯" onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu5.png" alt="�ַ���" onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu6.png" alt="�����ı�" onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
					<li><a href=""><img src="img/menu7.png" alt="����&����" onmouseover="chmenu(this,'1')" onmouseout="chmenu(this,'2')"></a></li>
				</ul>
			</div>
		</div>
		<!-- content -->
		<div id="banner1">
			<img src="img/kostabanner.PNG">
		</div>
		<div id="content"></div>
		

		<!-- bottom -->
		<div id="footer" 
		style="width: 1000px; text-align: center; 
		background-color: #7d7d7d; margin-top: 150px;
		 height: 200px;font-weight: bold;"
		 >ȸ��Ұ� |����������ȣ |������� |���¹�ȣ |�൵ 
		 
		 </div>
	</div>
</body>
</html>