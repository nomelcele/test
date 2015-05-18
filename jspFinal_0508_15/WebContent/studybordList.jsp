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
	font-family: "돋움";
	font-size: 25px;
}

#content #stContent thead td {
	height: 30px;
	background-color: #007bbe;
	color: #FFFFFF;
	font-family: "돋움";
	font-size: 15px;
}

#content #stContent tbody td {
	height: 30px;
	background-color: #FFFFFF;
	color: #7d7d7d;
	font-family: "돋움";
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
	font-family: "돋움";
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
	font-family: "맑은고딕";
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
				<td>현재 페이지 : 스터디게시판 리스트</td>
			</tr>
		</table>
		<table id="stContent">
			<thead>
				<tr>
					<td class="no">번호</td>
					<td class="title">제목</td>
					<td class="writer">작성자</td>
					<td class="hit">조회수</td>
					<td class="regdate">등록일</td>
				</tr>
			</thead>
			<tbody>
			<!-- var, items, begin, end, step, varStatus
			var: 현재 jsp view 안에 있는 메모리의 지역 변수를 선언
			items: 컬렉션이나 배열 타입
			begin: 초기식, end: 조건식, step: 증감식
			varStatus: 인덱스 값을 찍는 것(추후에)
			
			=> var, items 기억해두기 -->
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
					<!-- c:set) 현재 jsp 파일에서 변수로 저장하겠다 -->
					<c:set var="pageUrl" value="stboard.kosta?cmd=board&subcmd=boardList" />
					<%@include file="page.jsp" %>
					</td>
				</tr>

				<tr>
					<td colspan="5"><input type="button" value="글작성"
						onclick="gourl()" class="btn"></td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
<%@include file="bottom.jsp"%>