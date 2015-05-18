package action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;

public class IndexAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		System.out.println("Log : IndexAction�� ������ ��!");
		// requestScope�� ���� ����
		request.setAttribute("msg", "hello ~ my first MVC!");
		// false: forward, true : redirect ������ �������� ����.
		return new ActionForward("index.jsp", false);
	}

}
