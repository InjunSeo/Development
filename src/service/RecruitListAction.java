package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.YhsDao;
import dto.Together;

public class RecruitListAction implements InterfaceForAction {

	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		YhsDao dao = YhsDao.getInstance();
		request.setCharacterEncoding("UTF-8");
		String sorting = request.getParameter("sorting");
		System.out.println("sorting->"+sorting);
		
		if (sorting == null || sorting.equals("")) { 
			sorting = "1"; 	// 기본은 무조건 진행 순
		}

		try {
			int totCnt = dao.getTotalCnt();
			String pageNum = request.getParameter("pageNum");
			if(pageNum == null || pageNum.equals("")) {
				pageNum = "1";
			}
			int currentPage = Integer.parseInt(pageNum);
			System.out.println("ListAction pageNum->"+pageNum);
			int pageSize = 9, blockSize = 9;
			int startRow = (currentPage - 1) * pageSize + 1;  // 1   10
			int endRow = startRow + pageSize - 1;             // 9   
			int startNum = totCnt - startRow + 1;
			List<Together> togelist = dao.recruitList(startRow, endRow, sorting);
			int pageCnt = (int) Math.ceil((double) totCnt / pageSize);
			int startPage = (int)(currentPage - 1) / blockSize * blockSize + 1;
			int endPage = startPage + blockSize - 1;
			if (endPage > pageCnt)
				endPage = pageCnt;
			
			request.setAttribute("totCnt", totCnt);
			request.setAttribute("pageNum", pageNum);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startNum", startNum);
			request.setAttribute("list", togelist);
			request.setAttribute("blockSize", blockSize);
			request.setAttribute("pageCnt", pageCnt);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);	
			request.setAttribute("sorting", sorting);	
			System.out.println("---------------------------------------------------");
			System.out.println("startNum-->" + startNum);			//     /ch16/list.do
			System.out.println("totCnt-->" + totCnt);				//     /ch16/list.do
			System.out.println("currentPage-->" + currentPage);		//     /ch16/list.do
			System.out.println("blockSize-->" + blockSize);			//     /ch16/list.do
			System.out.println("pageSize-->" + pageSize);			//     /ch16/list.do
			System.out.println("pageCnt-->" + pageCnt);				//     /ch16/list.do
			System.out.println("startPage-->" + startPage);	
			System.out.println("[RecruitListAction.java] listSorting = " + togelist);

		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return "recruitListView.jsp";
	}
	
}
