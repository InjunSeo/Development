package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.KsmDao;
import dto.Member;

public class CloseMemberProAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String view 			= "";
		String confirmPW		= "";
		int result				= 0;
		Member member			= new Member();
		
		// 세션에서 member dto를 가져온다(회원정보)
		// request에서 확인비밀번호를 가져온다
		HttpSession session 	= request.getSession();
		member					= (Member)session.getAttribute("member");
		confirmPW				= request.getParameter("pw");
		
		System.out.println("[CloseMemberProAction][confirmPW]"+confirmPW);
		System.out.println("[CloseMemberProAction][password]"+member.getPassword());
		
		try {
			// 확인 비밀번호가 현 세션의 비밀번호와 일치하면 삭제 프로세스를 실행한다
			if (confirmPW.equals(member.getPassword())) {
				 KsmDao kd		= KsmDao.getInstance();
				 result 		= kd.closeMember(member);	

			// 확인 비밀번호가 현 세션위 비밀번호와 일치하지 않으면 실패값(0)을 가지고 화면으로 돌아간다
			} else {
				request.setAttribute("pwFailed", "비밀번호가 틀립니다");
				result = 0;
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		if (result == 0) {
			view = "closeMemberFormView.jsp";
		} else {
			session.invalidate();
			view = "/home.do";
		}
		
		return view;
	}

}
