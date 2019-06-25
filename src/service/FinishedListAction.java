package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.RequestWrapper;

import dao.YnvlyDao;
import dto.Together;

public class FinishedListAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		YnvlyDao yd = YnvlyDao.getInstance();
		try {
			List<Together> finList = yd.getFinList();
			/*System.out.println( "[FinishedListAction.java] finList = " + finList);*/
			request.setAttribute("finList", finList);
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "finishedListView.jsp";
	}
}
