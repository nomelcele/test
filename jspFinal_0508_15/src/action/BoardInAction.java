package action;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.MyMap;
import vo.BoardVO;
import controller.ActionForward;
import dao.BoardDao;

public class BoardInAction implements Action{


	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		 System.out.println("Test:");

		 HashMap<String, String> maps = MyMap.getMaps().getMapList(request);
		 BoardDao.getDao().insert(maps);

		return new ActionForward("index.jsp", false);
	}

}
