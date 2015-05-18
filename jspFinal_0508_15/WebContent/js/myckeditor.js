function chkUpload(){
	// 해당 id로 된 textarea에 에디터를 적용
	// id가 content인 textarea에 에디터가 적용된다.
	CKEDITOR.replace('content',{
		// 에디터의 사이즈 설정
		width:'80%',
		height:'350px',
		// 이 경로로 파일을 전달하여 업로드시킨다.
		// cmd 값이 board, subcmd 값이 ckBoard이므로
		// BoardAction 안의 if문에서 업로드 작업을 하게 된다.
		filebrowserImageUploadUrl: 'study.kosta?cmd=board&subcmd=ckBoard'
	});
	
	CKEDITOR.on('dialogDefinition',function(ev){
		// 에디터 내부의 버튼을 클릭했을 때 실행
		// ev는 이벤트
		var dialogName = ev.data.name;
		// 이미지 업로드 버튼을 클릭했을 경우에는 'image'라는 문자열이 들어간다.
		var dialogDefinition = ev.data.definition;
		
		switch(dialogName){
			case 'image': // 이미지 업로드 버튼을 클릭했을 때
				// dialog 창 설정
				// dialogDefinition.removeContents('info');
				dialogDefinition.removeContents('Link');
				dialogDefinition.removeContents('advanced');
				break;
		}
	});
}