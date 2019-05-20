package service;



import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.JycDao;
import dto.Reply;
import dto.Together;

public class InfoAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		JycDao jd = JycDao.getInstance(); //싱글톤, DBCP
	try {	
		
		int toNo = Integer.parseInt(request.getParameter("toNo"));
		
		//투게더 정보
		Together toInfo = jd.getTogetherInfo(toNo);
		request.setAttribute("together", toInfo);
		
		//해당 투게더 댓글 정보		
		List<Reply> list = jd.getReplyList(toNo);
		request.setAttribute("replyList", list);
	}
	catch(Exception e){
		System.out.println(e.getMessage());
	}
		return "infoView.jsp";
	}

}
