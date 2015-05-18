package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;


@WebServlet("*.kosta")
// 업로드할 파일의 최대 크기와 업로드할 파일이 저장되는 경로
@MultipartConfig(maxFileSize=1024*1024*10, location="C:\\kosta97\\webapp\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\jspFinal_0508_15\\upload\\")
public class ControllServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public ControllServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doService(request,response);
	}
	protected void doService(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("euc-kr");
			// 사용자로 부터 요청을 받는다. 
			String cmd = request.getParameter("cmd");
			// cmd가 꼭 있을 경우 (사용자로 부터 요청이 있담)
			if(cmd != null){
				ActionFactory factory = ActionFactory.getFactory();
				Action action = factory.getAction(cmd);
//				if(cmd.equals("index")){
//					action = new IndexAction();
//				}else if(cmd.equals("today")){
//					action = new TodayAction();
//				}
				ActionForward af = action.execute(request,response);
				if(af.isMethod()){
					response.sendRedirect(af.getUrl());
				}else{
					//forward
					RequestDispatcher rd = request.getRequestDispatcher(af.getUrl());
					rd.forward(request, response);
				}
				
			}else{
				// 요청이 없다면 처리할 로직...
			}
	}

}
