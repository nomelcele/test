<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 
	String q = request.getParameter("q");
	// 파라미터를 분석 후 해당 테이블에 입력
	System.out.println("Query: "+q);
%>