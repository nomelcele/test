package action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;

public class CommAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String subcmd = request.getParameter("subcmd");
		
		String url ="studyBoardDetail.jsp";
		boolean method=false;
		
		if(subcmd != null && subcmd.equals("boardForm")){
			method=false;
		}
		return new ActionForward(url, method);
	}

}
