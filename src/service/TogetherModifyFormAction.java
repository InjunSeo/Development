package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SyDao;
import dto.Member;
import dto.Together;

public class TogetherModifyFormAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(); 
		Member member = (Member) session.getAttribute("member");
		try {
			String id = member.getID();
			int toNo = Integer.parseInt(request.getParameter("toNo"));			
			int check = 0;
			
			System.out.println("[TogetherEnrollFormAction.java] toNo : " + toNo);
			
			SyDao sd = SyDao.getInstance();
			Together together = sd.toModify(toNo);
			
			// 로그인이 되어있는지 체크
			if(id == null || id.equals("")) { check = 1;
			}else {check = 0;}
			
			System.out.println("[TogetherModifyFormAction.java] check :" + check);
			request.setAttribute("together", together);
			request.setAttribute("check", check);
			
		} catch(Exception e) {	System.out.println("[TogetherModifyFormAction.java]"+e.getMessage()); }
		return "togetherModifyFormView.jsp";
	}

}
