package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import util.MyMap;
import vo.BoardVO;
import vo.CommVO;
import vo.PageVO;
import controller.ActionForward;
import dao.BoardDao;

public class BoardAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String subcmd = request.getParameter("subcmd");
		System.out.println("subcmd:"+subcmd);
		String url ="index.jsp";
		boolean method=false;
		// ctrl + 1: 메서드 만들기
		
		if(subcmd != null && subcmd.equals("boardForm")){
			url ="studyBoardWriter.jsp";
			method=false;
		} else if(subcmd != null && subcmd.equals("ckBoard")){
			Part part = null;
			// 전송된 데이터에 접근하기 위해 Part를 생성
			try {
				part = request.getPart("upload");
				// getPart(name)은 인자로 들어간 이름에 해당하는 Part를 가져오는 메서드
			} catch (ServletException e) {
				e.printStackTrace();
			}
			System.out.println("--------------");
			System.out.println("Part: "+part);
			
			// 전송된 파일의 이름을 가져오는 메서드 호출
			String fileName = getFileName(part);
			System.out.println("Name: "+fileName);
			
			// 파일 이름이 있으면 업로드
			if(fileName != null && fileName.length() != 0){
				part.write(fileName);
			}
			
			// chk callback 설정: ajax로 넘어온 요청을 response 해주기 위한 설정
			String callback = request.getParameter("CKEditorFuncNum");
			// url 경로
			String fileUrl = "upload/" + fileName; 
			// 이동할 url로 넘겨줄 속성들
			request.setAttribute("callback", callback);
			request.setAttribute("fileUrl", fileUrl);
			url = "callback.jsp";
			method = false;
			 
		} else if(subcmd != null && subcmd.equals("boardIn")){
			//자동으로 파라미터를 받아서 처리해주는 주요 핵심 코드
			// useBeanActionTag (set property) 기능 구현
			HashMap<String, String> maps = MyMap.getMaps().getMapList(request);
			BoardDao.getDao().insert(maps);
			
			url="*.kosta?cmd=board&subcmd=boardList&page=1";
			method=true;
		}else if(subcmd != null && subcmd.equals("boardList")){
			url="studybordList.jsp";
			method=false;
			/*Page 처리 영역 */
			Map<String,Integer> map = pageProcess(request,0);
			/* ****************************** */
			ArrayList<BoardVO> list = BoardDao.getDao().getList(map);
			request.setAttribute("list", list);
			
		} else if(subcmd != null && subcmd.equals("boardDetail")){
			int no = Integer.parseInt(request.getParameter("no"));
			String tar = request.getParameter("tar");
			String childcmd = request.getParameter("childcmd");
			url = "studyboardDetail.jsp";
			method = false;
			BoardVO v = BoardDao.getDao().getDetail(no);
			request.setAttribute("v", v);
			
			// comm 처리 부분
			if(childcmd != null && childcmd.equals("in")){
				HashMap<String, String> maps = MyMap.getMaps().getMapList(request);
				// dao 처리 (insert)
				BoardDao.getDao().insertComm(maps);
				// 왜 no를 보내야 하는지
				url = "studyboardDetail.kosta?no="+no+"&cmd=board&subcmd=boardDetail&tar=t&page=1";
				// tar=t 앵커태그에 위치하기 위해서
				// page=1
				// 댓글의 리스트
				method = true;
			}
			
			// commList
			// list, commList의 total 값을 구분
			Map<String,Integer> map = pageProcess(request,1);
			map.put("no", no);
			ArrayList<CommVO> clist = BoardDao.getDao().getCommList(map);
			request.setAttribute("clist", clist);
			request.setAttribute("tar", tar);
		}
		
		return new ActionForward(url, method);
	}
	
	private String getFileName(Part part) {
		// 파일의 이름을 저장할 변수
		String fileName = "";
		
		// 업로드를 하기 위한 정보가 담긴 헤더를 얻어옴
		String header = part.getHeader("content-disposition");
		System.out.println(header);
		
		// header의 형태: form-data; name="file"; filename="seohyeon.jpg";
		// header의 내용을 ;을 기준으로 분할해서 배열로 저장
		String[] elements = header.split(";");
		
		// elements에서 filename에 해당하는 데이터 찾기
		for(String element: elements){
			// filename으로 시작하는 element를 찾으면
			// filename= 다음의 문자열만 fileName에 저장
			if(element.trim().startsWith("filename")){
				fileName = element.substring(element.indexOf('=')+1);
				// fileName에 [\"] ["]가 있다면 제거
				// "는 직접 기재가 불가능
				fileName = fileName.trim().replace("\"", "");
			}
		}
		
		return fileName;
	}

	private Map<String, Integer> pageProcess(HttpServletRequest request, int etc){
		PageVO pageInfo = new PageVO();
		
		int rowsPerPage = 5; // 페이지당 보여질 줄의 수
		// 5니까 한 페이지당 5개 나타남
		int pagesPerBlock = 5;
		// 외부에서 부터 페이지 값을 받아 오는것 부터 시작
		// => properties로 분리
		
		// 외부에서부터 페이지 값을 받아오는 것부터 시작
		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		// 현재 페이지를 구하는 공식
		int currentBlock = 0;
		if(currentPage % pagesPerBlock == 0){
			currentBlock = currentPage / pagesPerBlock;
		}else{
			currentBlock = currentPage / pagesPerBlock + 1;
		}
		
		// 현재 블록과 페이지를 구한 다음에 시작페이지 마지막페이지 : 한블록안에 한페이지당
		int startRow = (currentPage - 1) * rowsPerPage + 1;
		int endRow = currentPage * rowsPerPage;
		
		int totalRows = 0;
		// 리스트인지, comm인지를 구분함
		// 메서드를 호출 시에 etc의 값이 0이라면 리스트의 총 데이터를,
		// 1이라면 comm의 총 데이터를 가져오는 dao의 메서드를 따로 받아온다.
		if(etc==0){
			totalRows = BoardDao.getDao().getTotalCount();
		} else if(etc==1){
			int no = Integer.parseInt(request.getParameter("no"));
			totalRows = BoardDao.getDao().getTotalCommCount(no);
		}
		
		int totalPages = 0;
		if(totalRows % rowsPerPage == 0){
			totalPages = totalRows / rowsPerPage;
		}else{
			totalPages = totalRows / rowsPerPage + 1;
		}
		
		int totalBlocks = 0;
		if(totalPages % pagesPerBlock == 0){
			totalBlocks = totalPages / pagesPerBlock;
		}else{
			totalBlocks = totalPages / pagesPerBlock + 1;
		}
		
		pageInfo.setCurrentPage(currentPage);
		pageInfo.setCurrentBlock(currentBlock);
		pageInfo.setRowsPerPage(rowsPerPage);
		pageInfo.setPagesPerBlock(pagesPerBlock);
		pageInfo.setStartRow(startRow);
		pageInfo.setEndRow(endRow);
		pageInfo.setTotalRows(totalRows);
		pageInfo.setTotalPages(totalPages);
		pageInfo.setTotalBlocks(totalBlocks);
		
		request.setAttribute("pageInfo", pageInfo);
		HashMap<String, Integer> map = new HashMap<>();
		map.put("begin", startRow);
		map.put("end", endRow);
		
		return map;
	}

}
