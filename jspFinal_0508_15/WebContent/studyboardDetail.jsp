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
		color:#FFFFFF; font-family:"����"; font-size: 25px;
	}
	#content #stContent thead td{
		height: 30px; background-color: #007bbe;
		color:#FFFFFF; font-family:"����"; font-size: 15px;
	}
	#content #stContent tbody td{
		height: 30px; background-color: #FFFFFF;
		color:#7d7d7d; font-family:"����"; font-size: 15px;
	}
	/* ��Ÿ�Ͽ��� Ŭ������  �ߺ��ؼ� �����ϱ� ���ѹ�� */
	#content #stContent .td { text-align: left; padding-left: 25px;}
	#content #stContent .title input{width:350px;}
	#content #stContent .title2 input{width:150px;}
	#content #stContent .instyle {
	  background-color: #0099ff; height: 30px; color:#fff;
	  font-weight: bold; font-size: 14px; font-family:"�������"; 
	 }
	 #content #stContent .instyle2 {
	  background-color: #0099ff; height: 30px; color:#fff;
	  font-weight: bold; font-size: 14px; font-family:"�������"; 
	 }
	#content #stContent .writer input{width:250px;}
	#content #stContent .content textarea{ width: 250px; height: 300px; text-align: left;}
	
	/*btn*/
	#content #stContent .btn {
		width: 120px; background-color: #f927a9; height:25px;
		color:#fff;
	    font-weight: bold; font-size: 14px; font-family:"�������";
	}
</style>
<c:if test="${tar=='t' }">
<%-- requestScope�� ����Ǿ �Ѿ�� tar�� ���� t�̸� if���� ����  --%>
<script>
	self.location.hash='tar';
	// name�� tar�� ��Ŀ�±׷� ��ġ�� �̵������ش�.
</script>
</c:if>
<script>
	function imgChange(){
		$("#targetIcon").click(function(){
			$("#iconView").show();
			/*$('#commF').submit(
					function(e){
						// submit�� ���ϰ� ����	
						e.preventDefault();
					}
				);*/
		});
		
		$(".subIcon").click(function(){
			$("#targetIcon").attr("src",$(this).attr("src"));
			$("#resIcon").val($(this).attr("src"));
			$("#iconView").hide();
			
		});
			// input�� �Ӽ� �� value
			// text: div�� p � �� �ִ� ����
			
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
						<td>���� ������ : ���͵�Խ��� �ۼ���</td>
					</tr>
				</table>
					<table id="stContent">
						<tr><td colspan="2">���͵� �Խ��� �ۼ���</td></tr>
						<tr>
							<td>��ȣ/��¥</td>
							<td class="td title2">
							<input name="no" id="no" class="instyle2" 
							readonly="readonly" value="${v.no}">/
							<input name="regdate" id="regdate" class="instyle2" 
							readonly="readonly" value="${v.regdate}">
							</td>
						</tr>
						<tr>
							<td>����</td>
							<td class="td title"><input name="title" id="title" class="instyle" 
							readonly="readonly" value="${v.title}"></td>
						</tr>
						<tr>
							<td>�ۼ���</td>
							<td class="td writer"><input name="writer" id="writer" class="instyle"
							readonly="readonly" value="${v.writer}"></td>
							<!-- readonly(�б� ����): input �±׿��� Ŀ���� ���� ���ϰ� �ϴ� �Ӽ� -->
						</tr>
<!-- 						<tr> -->
<!-- 							<td>�ƹ���</td> -->
<!-- 							<td class="td writer"> -->
<!-- 							<input name="code" id="code1" class="instyle"> -->
<!-- 							<input name="code" id="code2" class="instyle"> -->
<!-- 							<input name="code" id="code3" class="instyle"> -->
<!-- 							</td> -->
<!-- 						</tr> -->
						<tr>
							<td><a name="tar">����</a></td>
							<td class="td content">
							<!--  <textarea rows="10" cols="30" 
							name="content" id="content" class="instyle"
							readonly="readonly"> -->
							${v.content}</td>
						</tr>
						<tr>
						<!-- ��� ����Ʈ(commList) -->
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
										<!-- image type �⺻ cursor: pointer 
										image type �ȿ��� ���������� submit -->
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
									<input type="submit" value="Ȯ��" class="btn">
									</td>
								</tr>
							</table>
							</form>
						</div>
						</td>
						</tr>
						<tr><td colspan="2">
							<input type="button" value="���ۼ�" class="btn" onclick="location='studyboardWriter.kosta?cmd=board&subcmd=boardForm'">&nbsp;
							<input type="button" value="list" class="btn" onclick="location='studyboardWriter.kosta?cmd=board&subcmd=boardList&page=1'">
						</td></tr>
					</table>
					
				</div>
		</div>
<%@include file="bottom.jsp"%>