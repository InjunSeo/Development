package service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.KsmDao;
import dto.Member;

public class SignupProAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 날짜 기입을 위한
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();

		// Session 활성화
		HttpSession userSession = request.getSession();

		int result 	= 0;
		String view = "";
		
		try {
			Member member	= new Member();
			member.setID(request.getParameter("id"));
			member.setName(request.getParameter("name"));
			member.setPassword(request.getParameter("pw"));
			member.setTel(request.getParameter("tel"));
			member.setEmail(request.getParameter("email"));
			member.setPoint(Integer.parseInt(request.getParameter("point")));
			member.setCreateDate(dateformat.format(date).toString());
	
			KsmDao kd		= KsmDao.getInstance();
			
			result			= kd.signup(member);
			
			// 가입에 성공했을 경우 회원정보을 세션에 저장한다
			if (result == 1) {
				System.out.println(member.getCreateDate());
				userSession.setAttribute("member", member);
				view = "/home.do";
			// 가입에 실패했을 경우 가입실패 결과 0을 가지고 다시 회원가입 창으로 돌아간다
			} else {
				request.setAttribute("result", result);
				view = "signupFormView.jsp";
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
		
		return view;
	}

}
