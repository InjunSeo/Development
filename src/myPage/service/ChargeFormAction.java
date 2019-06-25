package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.JunDao;
import dto.Member;

public class ChargeFormAction implements InterfaceForAction {
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {

		try {
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("member");
			
			JunDao jun = JunDao.getInstance();
			Member member2 = jun.select(member.getID());
			
			request.setAttribute("name",  member2.getName());
			request.setAttribute("nowPoint", member2.getPoint());

		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "chargeFormView.jsp";
	}
}
