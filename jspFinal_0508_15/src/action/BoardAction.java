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
		// ctrl + 1: �޼��� �����
		
		if(subcmd != null && subcmd.equals("boardForm")){
			url ="studyBoardWriter.jsp";
			method=false;
		} else if(subcmd != null && subcmd.equals("ckBoard")){
			Part part = null;
			// ���۵� �����Ϳ� �����ϱ� ���� Part�� ����
			try {
				part = request.getPart("upload");
				// getPart(name)�� ���ڷ� �� �̸��� �ش��ϴ� Part�� �������� �޼���
			} catch (ServletException e) {
				e.printStackTrace();
			}
			System.out.println("--------------");
			System.out.println("Part: "+part);
			
			// ���۵� ������ �̸��� �������� �޼��� ȣ��
			String fileName = getFileName(part);
			System.out.println("Name: "+fileName);
			
			// ���� �̸��� ������ ���ε�
			if(fileName != null && fileName.length() != 0){
				part.write(fileName);
			}
			
			// chk callback ����: ajax�� �Ѿ�� ��û�� response ���ֱ� ���� ����
			String callback = request.getParameter("CKEditorFuncNum");
			// url ���
			String fileUrl = "upload/" + fileName; 
			// �̵��� url�� �Ѱ��� �Ӽ���
			request.setAttribute("callback", callback);
			request.setAttribute("fileUrl", fileUrl);
			url = "callback.jsp";
			method = false;
			 
		} else if(subcmd != null && subcmd.equals("boardIn")){
			//�ڵ����� �Ķ���͸� �޾Ƽ� ó�����ִ� �ֿ� �ٽ� �ڵ�
			// useBeanActionTag (set property) ��� ����
			HashMap<String, String> maps = MyMap.getMaps().getMapList(request);
			BoardDao.getDao().insert(maps);
			
			url="*.kosta?cmd=board&subcmd=boardList&page=1";
			method=true;
		}else if(subcmd != null && subcmd.equals("boardList")){
			url="studybordList.jsp";
			method=false;
			/*Page ó�� ���� */
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
			
			// comm ó�� �κ�
			if(childcmd != null && childcmd.equals("in")){
				HashMap<String, String> maps = MyMap.getMaps().getMapList(request);
				// dao ó�� (insert)
				BoardDao.getDao().insertComm(maps);
				// �� no�� ������ �ϴ���
				url = "studyboardDetail.kosta?no="+no+"&cmd=board&subcmd=boardDetail&tar=t&page=1";
				// tar=t ��Ŀ�±׿� ��ġ�ϱ� ���ؼ�
				// page=1
				// ����� ����Ʈ
				method = true;
			}
			
			// commList
			// list, commList�� total ���� ����
			Map<String,Integer> map = pageProcess(request,1);
			map.put("no", no);
			ArrayList<CommVO> clist = BoardDao.getDao().getCommList(map);
			request.setAttribute("clist", clist);
			request.setAttribute("tar", tar);
		}
		
		return new ActionForward(url, method);
	}
	
	private String getFileName(Part part) {
		// ������ �̸��� ������ ����
		String fileName = "";
		
		// ���ε带 �ϱ� ���� ������ ��� ����� ����
		String header = part.getHeader("content-disposition");
		System.out.println(header);
		
		// header�� ����: form-data; name="file"; filename="seohyeon.jpg";
		// header�� ������ ;�� �������� �����ؼ� �迭�� ����
		String[] elements = header.split(";");
		
		// elements���� filename�� �ش��ϴ� ������ ã��
		for(String element: elements){
			// filename���� �����ϴ� element�� ã����
			// filename= ������ ���ڿ��� fileName�� ����
			if(element.trim().startsWith("filename")){
				fileName = element.substring(element.indexOf('=')+1);
				// fileName�� [\"] ["]�� �ִٸ� ����
				// "�� ���� ���簡 �Ұ���
				fileName = fileName.trim().replace("\"", "");
			}
		}
		
		return fileName;
	}

	private Map<String, Integer> pageProcess(HttpServletRequest request, int etc){
		PageVO pageInfo = new PageVO();
		
		int rowsPerPage = 5; // �������� ������ ���� ��
		// 5�ϱ� �� �������� 5�� ��Ÿ��
		int pagesPerBlock = 5;
		// �ܺο��� ���� ������ ���� �޾� ���°� ���� ����
		// => properties�� �и�
		
		// �ܺο������� ������ ���� �޾ƿ��� �ͺ��� ����
		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		// ���� �������� ���ϴ� ����
		int currentBlock = 0;
		if(currentPage % pagesPerBlock == 0){
			currentBlock = currentPage / pagesPerBlock;
		}else{
			currentBlock = currentPage / pagesPerBlock + 1;
		}
		
		// ���� ��ϰ� �������� ���� ������ ���������� ������������ : �Ѻ�Ͼȿ� ����������
		int startRow = (currentPage - 1) * rowsPerPage + 1;
		int endRow = currentPage * rowsPerPage;
		
		int totalRows = 0;
		// ����Ʈ����, comm������ ������
		// �޼��带 ȣ�� �ÿ� etc�� ���� 0�̶�� ����Ʈ�� �� �����͸�,
		// 1�̶�� comm�� �� �����͸� �������� dao�� �޼��带 ���� �޾ƿ´�.
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
