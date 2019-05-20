package service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SyDao;
import dto.Member;
import dto.Together;

public class EnrollListFormAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) {
		
		SyDao sd = SyDao.getInstance();
		
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		
		try {
			String id = member.getID();
			int status = 0;
			int check = 0;
			
			if(id == null || id.equals("")) { check = 1;
			}else {check = 0;}
			
			List<Together> enrollList = sd.enrollList(id, status);
			request.setAttribute("enrollList", enrollList);
			request.setAttribute("check", check);
		} catch (Exception e) {
			System.out.println("[EnrollListAction.java] : "+e.getMessage());
		}
		
		
		return "enrollListView.jsp";
	}

}
