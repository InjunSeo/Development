package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.JunDao;
import dto.Member;



public class ChargeProcAction implements InterfaceForAction {
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("member");
			String id = member.getID();
			
			int prePoint = Integer.parseInt(request.getParameter("nowPoint"));
			System.out.println("[ChargeProcAction.java]prePoint: " + prePoint);
			
			int charge = Integer.parseInt(request.getParameter("charge"));
			System.out.println("[ChargeProcAction.java]charge: " + charge);

			String kakao = request.getParameter("kakao");
			System.out.println("[ChargeProcAction.java]kakaoid: " +kakao);
			if (kakao != null && kakao !="") { 
				request.setAttribute("methodOfPay", kakao);
			} 
			String card = request.getParameter("card");
			System.out.println("[ChargeProcAction.java]card: " +card);
			if (kakao != null && kakao !="") { 
				request.setAttribute("methodOfPay", card);
			}

			JunDao jun = JunDao.getInstance();
			int result = jun.update(id, charge);
			Member member2 = jun.select(id);
			
			request.setAttribute("prePoint",  prePoint);
			request.setAttribute("result",  result);
			request.setAttribute("charge",  charge);
			request.setAttribute("nowPoint", member2.getPoint());
			//Member dto의 point변경
			member.setPoint(member2.getPoint());
			System.out.println("[ChargeProcAction.java]member.point: " + member.getPoint());

			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "chargeProcView.jsp";
	}

}
