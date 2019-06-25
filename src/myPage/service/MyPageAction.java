package service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.JunDao;
import dto.Member;
import dto.Together;

public class MyPageAction implements InterfaceForAction {
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		JunDao jun = JunDao.getInstance();
		int sessionCheck = 0;
		try {
			HttpSession session = request.getSession();
			Member member = (Member) session.getAttribute("member");

			if (member != null && !member.equals("")) {
				sessionCheck = 1;  // 로그인 상태임
				String id = member.getID();
				System.out.println("[MyPageAcion.java] id: " + id);
				
				String listSort = request.getParameter("listSort");
				System.out.println("[MyPageAcion.java] listSort: " +listSort);

				//<나의 투게더>에서 사용할 myTogetherlist 
				if (listSort == null || listSort.equals("")) { listSort = "2";	} // 기본: 진행중인 투게더 
				System.out.println("[MyPageAcion.java] listSort: " +listSort);
				
				request.setAttribute("listSort",  listSort);
				
				Object[] arrList = jun.myTogetherList(id, listSort);
				System.out.println("[MyPageAcion.java] myTogether: " + arrList[0]);
				System.out.println("[MyPageAcion.java] myTogether: " + arrList[1]);

				request.setAttribute("myTogether", arrList[0]);
				request.setAttribute("countRateList",  arrList[1]);

				// <인증하기>에서 사용할 myIngList 
				ArrayList<Together> myIngList = jun.getMyIngTogetherList(id);
				request.setAttribute("myIngList", myIngList);
				System.out.println("[MyPageAcion.java] myIngList: " + myIngList);
				
/*				// 종료된 투게더 list에 대한 Test 
				Object[] arrList = jun.getMyFinishedTogetherList(id);
				
				@SuppressWarnings("unchecked")
				ArrayList<Together> myFinishedList = (ArrayList<Together>) arrList[0];
				System.out.println("[MyPageAcion.java] myFinishedList: " + myFinishedList);
*/				
				// 달성률(=certCount/period) 계산하여 countRateList에 넣기
//				int toNo = 0;
//				double period = 0;
//				ArrayList<Object> countRateList = new ArrayList<>();
				

//				ArrayList<String> countRateList = (ArrayList<String>) arrList[1];
//				
//				for(Together to : myTogetherList) {			
//					toNo = to.getToNo();
//					period = to.getPeriod();
//					System.out.println("toNo: "+ toNo);
//					System.out.println("period: " + period);
//
////					double certCount = jun.certCount(id, toNo);
//					 
//							
////					System.out.println("cerCount: "+ certCount);
////					Math.round((certCount/period)*100);
////					System.out.println("countRate: " +Math.round((certCount/period)*100));
//				
////					countRateList.add(Math.round((certCount/period)*100));
////				}
			//	System.out.println("[MyPageAcion.java]countRateList: " +countRateList);
				
				// 로그인 상태 아닐 경우, sessionCheck = 0
			} else {
				sessionCheck = 0; 
			}
			
			request.setAttribute("sessionCheck", sessionCheck);
			System.out.println("[MyPageAcion.java]sessionCheck: " +sessionCheck);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return "myPageView.jsp";
	}
} 
