<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%-- Ajax로 callback 받을 CKEDITOR 형식의 함수 --%>
<script type="text/javascript">
	window.parent.CKEDITOR.tools.callFunction('${callback}',
			'${fileUrl}','이미지를 업로드하였습니다.');
	<%-- 미리보기를 찾아가는 함수 
	ckeditor의 화면값, 업로드된 파일의 경로, 실행 시 나타날 경고창 --%>
</script>



<%-- <!-- --> 형식의 주석은 Ajax로 넘어갈 때 함께 넘어가니까 사용하지 말 것 --%>