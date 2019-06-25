package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.KsmDao;
import dto.Member;

public class UpdateMemberProAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int result 		= 0;
		String view 	= "";
		String updatePw	= "";
		Member member	= new Member();
		// session에서 member를 가져온다
		HttpSession session = request.getSession();
		member				= (Member)session.getAttribute("member");
		
		// 입력된 새 pw가 있다면 업데이트 비번을 새 pw으로 하고 그렇지 않다면 기존 pw를 업데이트 비번으로 한다
		if (request.getParameter("newpw") != "") {
			updatePw = request.getParameter("newpw");
		} else {
			updatePw = request.getParameter("pwchk");
		}
		
		try {
			
			member.setName(request.getParameter("name"));
			member.setPassword(request.getParameter("pwchk"));
			member.setEmail(request.getParameter("email"));
			member.setTel(request.getParameter("tel"));
			
			KsmDao kd		= KsmDao.getInstance();
			result			= kd.updateMember(member, updatePw);
			
			// updateMember에 실패했을 경우 기존의 session 정보를 가지고 회원정보수정 Form으로 돌아간다
			if ( result == 0 ) {
				request.setAttribute("updateFailed", "updateFailed");
				view  = "updateMemberFormView.jsp";
			
			// 성공 했을 경우 성공한 session 정보를 갱신하고 home.do로 돌아간다
			} else {
				session.setAttribute("member", member);
				view = "/home.do";
			}
			
		} catch ( Exception e) {
			System.out.println(e.getMessage());
		} 

		return view;
	}

}
