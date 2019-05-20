package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;

public class TogetherEnrollFormAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
			
		HttpSession session = request.getSession(); 
		Member member = (Member) session.getAttribute("member");
		int check = 0;
		try {
			String id = member.getID();
			int point = member.getPoint();
			
			System.out.println("[TogetherEnrollFormAction.java] id : " + id);
			System.out.println("[TogetherEnrollFormAction.java] point : " + point);
			int pointCheck = 0;
			
			if(id == null || id.equals("")) { check = 1;
			}else {check = 0;}
			
			if(point < 100) {pointCheck = -1;}
			else {pointCheck = 0;}
			
			System.out.println("[TogetherEnrollFormAction.java] check :" + check);
			request.setAttribute("check", check);
			request.setAttribute("point", point);
			request.setAttribute("pointCheck", pointCheck);
		} catch(Exception e) {	System.out.println("[TogetherEnrollFormAction.java]"+e.getMessage()); }
		return "togetherEnrollFormView.jsp";
	}

}
