<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- studyboardDetail.jsp --%>
<%@include file="top.jsp" %>
<style>
	#content {
		width: 100%; text-align: center;
	}
	#content #stboardWriter{
	width:850px; margin-left: 100px; 
	}
	#content table,  tbody td{ border-collapse: collapse; border: 1px solid #7d7d7d;}
	#content #stTitle, #stContent{
		width: 100%; margin-top: 30px;
	}
	#content #stTitle tr td{
		height: 40px; background-color: #007bbe;
		color:#FFFFFF; font-family:"돋움"; font-size: 25px;
	}
	#content #stContent thead td{
		height: 30px; background-color: #007bbe;
		color:#FFFFFF; font-family:"돋움"; font-size: 15px;
	}
	#content #stContent tbody td{
		height: 30px; background-color: #FFFFFF;
		color:#7d7d7d; font-family:"돋움"; font-size: 15px;
	}
	/* 스타일에서 클래스를  중복해서 정의하기 위한방법 */
	#content #stContent .td { text-align: left; padding-left: 25px;}
	#content #stContent .title input{width:350px;}
	#content #stContent .title2 input{width:150px;}
	#content #stContent .instyle {
	  background-color: #0099ff; height: 30px; color:#fff;
	  font-weight: bold; font-size: 14px; font-family:"맑은고딕"; 
	 }
	 #content #stContent .instyle2 {
	  background-color: #0099ff; height: 30px; color:#fff;
	  font-weight: bold; font-size: 14px; font-family:"맑은고딕"; 
	 }
	#content #stContent .writer input{width:250px;}
	#content #stContent .content textarea{ width: 250px; height: 300px; text-align: left;}
	
	/*btn*/
	#content #stContent .btn {
		width: 120px; background-color: #f927a9; height:25px;
		color:#fff;
	    font-weight: bold; font-size: 14px; font-family:"맑은고딕";
	}
</style>
<c:if test="${tar=='t' }">
<%-- requestScope에 저장되어서 넘어온 tar의 값이 t이면 if문이 실행  --%>
<script>
	self.location.hash='tar';
	// name이 tar인 앵커태그로 위치를 이동시켜준다.
</script>
</c:if>
<script>
	function imgChange(){
		$("#targetIcon").click(function(){
			$("#iconView").show();
			/*$('#commF').submit(
					function(e){
						// submit을 못하게 해줌	
						e.preventDefault();
					}
				);*/
		});
		
		$(".subIcon").click(function(){
			$("#targetIcon").attr("src",$(this).attr("src"));
			$("#resIcon").val($(this).attr("src"));
			$("#iconView").hide();
			
		});
			// input의 속성 중 value
			// text: div나 p 등에 들어가 있는 문자
			
		$("#sub").click(function(){
			$("#commF").submit();
		});
	}
</script>
		<div id="banner1">
			<img src="img/kostabanner.PNG">
		</div>
		<div id="content">
				<div id="stboardWriter">
				<table id="stTitle">
					<tr>
						<td>현재 페이지 : 스터디게시판 작성폼</td>
					</tr>
				</table>
					<table id="stContent">
						<tr><td colspan="2">스터디 게시판 작성폼</td></tr>
						<tr>
							<td>번호/날짜</td>
							<td class="td title2">
							<input name="no" id="no" class="instyle2" 
							readonly="readonly" value="${v.no}">/
							<input name="regdate" id="regdate" class="instyle2" 
							readonly="readonly" value="${v.regdate}">
							</td>
						</tr>
						<tr>
							<td>제목</td>
							<td class="td title"><input name="title" id="title" class="instyle" 
							readonly="readonly" value="${v.title}"></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td class="td writer"><input name="writer" id="writer" class="instyle"
							readonly="readonly" value="${v.writer}"></td>
							<!-- readonly(읽기 전용): input 태그에서 커서가 들어가지 못하게 하는 속성 -->
						</tr>
<!-- 						<tr> -->
<!-- 							<td>아무개</td> -->
<!-- 							<td class="td writer"> -->
<!-- 							<input name="code" id="code1" class="instyle"> -->
<!-- 							<input name="code" id="code2" class="instyle"> -->
<!-- 							<input name="code" id="code3" class="instyle"> -->
<!-- 							</td> -->
<!-- 						</tr> -->
						<tr>
							<td><a name="tar">내용</a></td>
							<td class="td content">
							<!--  <textarea rows="10" cols="30" 
							name="content" id="content" class="instyle"
							readonly="readonly"> -->
							${v.content}</td>
						</tr>
						<tr>
						<!-- 댓글 리스트(commList) -->
							<td colspan="2">
							<div>
								<table style="width: 100%">
									<c:forEach var="ctList" items="${clist}">
									<tr>
										<td style="width: 128px">
										<img src="${ctList.imgicon}" style="width: 50px;">
										</td>
										<td style="width: 128px">${ctList.writer}</td>
										<td>${ctList.comm}</td>
										<td style="width: 50px">x</td>
									</tr>
									</c:forEach>
									<tr>
									<td colspan="4">
									<c:set var="pageUrl" 
									value="stboard.kosta?cmd=board&subcmd=boardDetail&no=${v.no}&tar=t"/>
									<%@include file="page.jsp" %>
									</td>
									</tr>
								</table>
							</div>
							</td>
						</tr>
						<tr>
						<td colspan="2">
						<div style="width: 100%">
						<form method="post" action="stboard.kosta" id="commF">
						<input type="hidden" name="cmd" value="board">
						<input type="hidden" name="page" value="1">
						<input type="hidden" name="subcmd" value="boardDetail">
						<input type="hidden" name="childcmd" value="in">
						<input type="hidden" name="code" value="${v.no}">
						<input type="hidden" name="no" value="${v.no}">
						<input type="hidden" name="targetIcon" id="resIcon" 
						value="icon/kko_01.png">
							<table style="width: 100%">
								<tr>
									<td style="width: 127px">
										<div>
										<img src="icon/kko_01.png" id="targetIcon"
										style="width: 40px; height: 40px">
										<!-- image type 기본 cursor: pointer 
										image type 안에는 내부적으로 submit -->
										</div>
									</td>
									<td>
										<div id="iconView" style="margin-left: 5px; 
										text-align: left; display: none">
											<c:forEach begin="1" end="9" step="1" varStatus="idx">
												<img src="icon/kko_0${idx.count }.png" 
												style="width:30px; cursor: pointer;" class="subIcon">	
											</c:forEach>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: left;">
									<textarea name="comm" id="comm"
									style="background: yellow; height: 100px; width: 100%; 
									font-size:13px; resize:none;"></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="text-align: right; padding-right: 5px;">
									<input type="submit" value="확인" class="btn">
									</td>
								</tr>
							</table>
							</form>
						</div>
						</td>
						</tr>
						<tr><td colspan="2">
							<input type="button" value="글작성" class="btn" onclick="location='studyboardWriter.kosta?cmd=board&subcmd=boardForm'">&nbsp;
							<input type="button" value="list" class="btn" onclick="location='studyboardWriter.kosta?cmd=board&subcmd=boardList&page=1'">
						</td></tr>
					</table>
					
				</div>
		</div>
<%@include file="bottom.jsp"%>