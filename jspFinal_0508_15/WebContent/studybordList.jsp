<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- studybordList.jsp --%>
<%@include file="top.jsp"%>
<style>
#content {
	width: 100%;
	text-align: center;
}

#content #stboardList {
	width: 850px;
	margin-left: 100px;
}

#content table,tbody td {
	border-collapse: collapse;
	border: 1px solid #7d7d7d;
}

#content #stTitle,#stContent {
	width: 100%;
	margin-top: 30px;
}

#content #stTitle tr td {
	height: 40px;
	background-color: #007bbe;
	color: #FFFFFF;
	font-family: "����";
	font-size: 25px;
}

#content #stContent thead td {
	height: 30px;
	background-color: #007bbe;
	color: #FFFFFF;
	font-family: "����";
	font-size: 15px;
}

#content #stContent tbody td {
	height: 30px;
	background-color: #FFFFFF;
	color: #7d7d7d;
	font-family: "����";
	font-size: 15px;
}

#content .no,.hit {
	width: 10%;
}

#content .title {
	width: 50%;
}

#content .writer {
	width: 15%
}

#content .regdate {
	width: 15%
}

#content #stContent tfoot td {
	height: 30px;
	background-color: #007bbe;
	color: #FFFFFF;
	font-family: "����";
	font-size: 15px;
}

#content .writer_v {
	text-align: left;
	padding-left: 10px;
}
/*btn*/
#content #stContent .btn {
	width: 120px;
	background-color: #f927a9;
	height: 25px;
	color: #fff;
	font-weight: bold;
	font-size: 14px;
	font-family: "�������";
}
</style>
<script>
	function gourl() {
		location = "studyboardWriter.kosta?cmd=board&subcmd=boardForm";
	}
</script>
<div id="banner1">
	<img src="img/kostabanner.PNG">
</div>
<div id="content">
	<div id="stboardList">
		<table id="stTitle" style="width: 100%; border: 1px dotted">
			<tr>
				<td>���� ������ : ���͵�Խ��� ����Ʈ</td>
			</tr>
		</table>
		<table id="stContent">
			<thead>
				<tr>
					<td class="no">��ȣ</td>
					<td class="title">����</td>
					<td class="writer">�ۼ���</td>
					<td class="hit">��ȸ��</td>
					<td class="regdate">�����</td>
				</tr>
			</thead>
			<tbody>
			<!-- var, items, begin, end, step, varStatus
			var: ���� jsp view �ȿ� �ִ� �޸��� ���� ������ ����
			items: �÷����̳� �迭 Ÿ��
			begin: �ʱ��, end: ���ǽ�, step: ������
			varStatus: �ε��� ���� ��� ��(���Ŀ�)
			
			=> var, items ����صα� -->
				<c:forEach var="stList" items="${list}">
					<tr>
						<td>${stList.no}</td>
						<td class="writer_v">
						<a href="stboard.kosta?cmd=board&subcmd=boardDetail&no=${stList.no}&page=1">
						${stList.title}</a>
						</td>
						<td>${stList.writer}</td>
						<td>${stList.hit}</td>
						<td>${stList.regdate}</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot>

				<tr>
					<td colspan="5">
					<!-- c:set) ���� jsp ���Ͽ��� ������ �����ϰڴ� -->
					<c:set var="pageUrl" value="stboard.kosta?cmd=board&subcmd=boardList" />
					<%@include file="page.jsp" %>
					</td>
				</tr>

				<tr>
					<td colspan="5"><input type="button" value="���ۼ�"
						onclick="gourl()" class="btn"></td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
<%@include file="bottom.jsp"%>