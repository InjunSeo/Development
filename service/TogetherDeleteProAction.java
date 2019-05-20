package service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SaintpDao;
import dao.SyDao;
import dto.Member;
import dto.Together;

public class TogetherDeleteProAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession(); 
		Member member = (Member) session.getAttribute("member");
		
		try {
				String id = member.getID();
				int toNo = Integer.parseInt(request.getParameter("toNo"));
				SyDao sd = SyDao.getInstance();
				int delResult = sd.toDelete(toNo, id);
				
				if(delResult > 0) {
					delResult = 1;
				} else {
					delResult = 0;
					request.setAttribute("delResult", delResult);
					return "info.do?toNo="+toNo;
					
				}
				
				System.out.println("[TogetherEnrollFormAction.java] toNo : " + toNo);
				
				SaintpDao dao = SaintpDao.getInstance();
		         if (member != null && member.getID() != null) {
		            ArrayList<Together> myTolist = dao.getMyTogetherList(member.getID());
		            ArrayList<Together> CreatedListbyMe = dao.getTogetherListCreatedByMe(member.getID());
		            
		            member = dao.getMember(id);
		            session.setAttribute("member", member);
		            session.setAttribute("myTogetherList", myTolist);
		            session.setAttribute("CreatedListbyMe", CreatedListbyMe);
		         }
		         
				request.setAttribute("delResult", delResult);
				request.setAttribute("toNo", toNo);
				
			} catch (Exception e) {
				System.out.println("[togetherDeletePro.java]"+e.getMessage());
			}
		return "enrollListForm.do";
	}

}
