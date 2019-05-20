package service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SaintpDao;
import dto.Member;
import dto.Together;

/**
 * 첫화면을 띄워주는 부분이다.
 * 검색도 여기서 처리한다.
 * 
 * 첫화면은 각 상태별 최신 Together 3개씩을 list에 request의 Attribute에 담아 보낸다.
 * 검색의 경우는 검색 결과를 request의 Attribute에 담아 보낸다.
 * 
 * 그리고 게스트가 아니라 로긴한 사용자라면 화면의 오른쪽에 정보를 띄워주기 위해
 * 본인이 참여한 투게더 리스트와 본인이 생성한 투게더 리스트를 구해 세션의 Attribute에 담는다.
 *  
 * 
 * @author saintp
 *
 */
public class HomeAction implements InterfaceForAction
{

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		SaintpDao dao = SaintpDao.getInstance();

		try {
			String searchWord = request.getParameter("searchWord");
			searchWord = (searchWord == null ? "" : searchWord.trim());
			String canceled = request.getParameter("canceled");
			String recruit = request.getParameter("recruit");
			String ing = request.getParameter("ing");
			String finished = request.getParameter("finished");
			String all = request.getParameter("all");

			System.out.println("[HomeAction.java] searchWord = " + searchWord);

			System.out.println("[HomeAction.java] canceled = " + canceled);
			System.out.println("[HomeAction.java] recruit = " + recruit);
			System.out.println("[HomeAction.java] ing = " + ing);
			System.out.println("[HomeAction.java] finished = " + finished);
			System.out.println("[HomeAction.java] all = " + all);

			ArrayList<Together> list = null;

			if (searchWord.equals("") && canceled == null && recruit == null && ing == null && finished == null
					&& all == null)
				list = dao.getTogetherListForHome();
			else
				list = dao.getTogetherListForSearch(searchWord, canceled != null, recruit != null, ing != null,
						finished != null, all != null);
			
			
			request.setAttribute( "searchWord", searchWord);
			request.setAttribute( "canceled", canceled);
			request.setAttribute( "recruit", recruit);
			request.setAttribute( "ing", ing);
			request.setAttribute( "finished", finished);
			request.setAttribute( "all", all);
			
			request.setAttribute("list", list);

			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("member");
			if (member != null && member.getID() != null) {
				ArrayList<Together> myTolist = dao.getMyTogetherList(member.getID());
				ArrayList<Together> CreatedListbyMe = dao.getTogetherListCreatedByMe(member.getID());
				
				session.setAttribute("myTogetherList", myTolist);
				session.setAttribute("CreatedListbyMe", CreatedListbyMe);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}

		return "homeView.jsp";
	}

}
