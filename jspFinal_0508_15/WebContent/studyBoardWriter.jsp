<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- studyBoardWriter.jsp --%>
<%@include file="top.jsp" %>
<style>
	#content2 {
		width: 100%; text-align: center;
	}
	#content2 #stboardWriter{
	width:850px; margin-left: 100px; 
	}
	#content2 table,  tbody td{ border-collapse: collapse; border: 1px solid #7d7d7d;}
	#content2 #stTitle, #stContent{
		width: 100%; margin-top: 30px;
	}
	#content2 #stTitle tr td{
		height: 40px; background-color: #007bbe;
		color:#FFFFFF; font-family:"돋움"; font-size: 25px;
	}
	#content2 #stContent thead td{
		height: 30px; background-color: #007bbe;
		color:#FFFFFF; font-family:"돋움"; font-size: 15px;
	}
	#content2 #stContent tbody td{
		height: 30px; background-color: #FFFFFF;
		color:#7d7d7d; font-family:"돋움"; font-size: 15px;
	}
	/* 스타일에서 클래스를  중복해서 정의하기 위한방법 */
	#content2 #stContent .td { text-align: left; padding-left: 25px;}
	#content2 #stContent .title input{width:350px;}
	#content2 #stContent .instyle {
	  background-color: #0099ff; height: 30px; color:#fff;
	  font-weight: bold; font-size: 14px; font-family:"맑은고딕";
	 
	 }
	#content2 #stContent .writer input{width:250px;}
	#content2 #stContent .content textarea{ width: 250px; height: 300px; text-align: left;}
	
	/*btn*/
	#content2 #stContent .btn {
		width: 120px; background-color: #f927a9; height:25px;
		color:#fff;
	    font-weight: bold; font-size: 14px; font-family:"맑은고딕";
	}
</style>
		<div id="banner1">
			<img src="img/kostabanner.PNG">
		</div>
		<div id="content2">
				<div id="stboardWriter">
				<table id="stTitle">
					<tr>
						<td>현재 페이지 : 스터디게시판 작성폼</td>
					</tr>
				</table>
				<form action="stBoardin.kosta" method="post">
				<input type="hidden" name="cmd" value="board">
				<input type="hidden" name="subcmd" value="boardIn">
					<table id="stContent">
						<tr><td colspan="2">스터디 게시판 작성폼</td></tr>
						<tr>
							<td>제목</td>
							<td class="td title"><input name="title" id="title" class="instyle"></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td class="td writer"><input name="writer" id="writer" class="instyle"></td>
						</tr>
						<!--  
 						<tr>
 							<td>전화번호</td>
							<td class="td writer">
 							<input name="code" id="code1" class="instyle">
 							<input name="code" id="code2" class="instyle">
 							<input name="code" id="code3" class="instyle">
							</td>
 						</tr> -->
						<tr>
							<td>내용</td>
							<td class="td content">
							<textarea rows="10" cols="30" name="content" id="content" class="instyle"></textarea></td>
						</tr>
						<tr><td colspan="2">
							<input type="submit" value="글작성" class="btn">&nbsp;
							<input type="button" value="list" class="btn" onclick="location='studyboardWriter.kosta?cmd=stboardList&page=1'">
						</td></tr>
					</table>
				</form>
				</div>
		</div>
<%@include file="bottom.jsp"%>