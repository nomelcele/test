<%@page import="suggest.Suggest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
[<%
 	// ��2�� ��ȯ�� ��-> �𵨿��� �ް� �ϰ� suggests �迭 ���� attribute�� ������ foreach ������ ������.
	request.setCharacterEncoding("euc-kr"); 
	// �񵿱������ ����ڷκ��� �˻�� ���� ���̴�. (��û�� suggestload.jsp���� ����)
	String key = request.getParameter("key");
	// xml�� �о���� ���ؼ� ���� Ŭ������ �޼��带 ȣ��
	String[] suggests = Suggest.getSuggest().getSuggest(key);
	if(suggests != null){
		for(int i=0; i<suggests.length; i++){	
%>"<%=suggests[i]%>"<% if(!(i == suggests.length-1)){out.print(",");}%><%}}%>]