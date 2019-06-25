package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MhDao;
import dto.Together;

public class IngListAction implements InterfaceForAction {
	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		MhDao md = MhDao.getInstance();

		String ingListSort = request.getParameter("ingListSort");
		System.out.println("[ingListAction.java] ingListSort->"+ingListSort);

		if (ingListSort == null || ingListSort.equals("")) { ingListSort = "1";	} // 기본은 무조건 진행순
		
		try {			
		    List<Together> ingList = md.getIngList(ingListSort);
			
			request.setAttribute("ingList", ingList);
			System.out.println( "[ingListAction.java] ingList = " + ingList);
    

	} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "ingListView.jsp";
	}

}
