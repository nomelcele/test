<%@page import="suggest.Suggest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
[<%
 	// 모델2로 변환할 때-> 모델에서 받게 하고 suggests 배열 값을 attribute로 보내서 foreach 문으로 돌린다.
	request.setCharacterEncoding("euc-kr"); 
	// 비동기식으로 사용자로부터 검색어를 받을 것이다. (요청은 suggestload.jsp에서 보냄)
	String key = request.getParameter("key");
	// xml을 읽어오기 위해서 만든 클래스의 메서드를 호출
	String[] suggests = Suggest.getSuggest().getSuggest(key);
	if(suggests != null){
		for(int i=0; i<suggests.length; i++){	
%>"<%=suggests[i]%>"<% if(!(i == suggests.length-1)){out.print(",");}%><%}}%>]