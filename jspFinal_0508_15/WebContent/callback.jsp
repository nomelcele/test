<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- Ajax�� callback ���� CKEDITOR ������ �Լ� --%>
<script type="text/javascript">
	window.parent.CKEDITOR.tools.callFunction('${callback}',
			'${fileUrl}','�̹����� ���ε��Ͽ����ϴ�.');
	<%-- �̸����⸦ ã�ư��� �Լ� 
	ckeditor�� ȭ�鰪, ���ε�� ������ ���, ���� �� ��Ÿ�� ���â --%>
</script>



<%-- <!-- --> ������ �ּ��� Ajax�� �Ѿ �� �Բ� �Ѿ�ϱ� ������� �� �� --%>