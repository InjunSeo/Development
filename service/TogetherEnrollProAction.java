package service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.SaintpDao;
import dao.SyDao;
import dto.Join;
import dto.Member;
import dto.Together;

public class TogetherEnrollProAction implements InterfaceForAction {
	public String requestPro(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		

		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		session.removeAttribute("together");

		try {			
			
			
			/*
			 * 이미지파일 저장받을
			 */
			request.setCharacterEncoding("utf-8");
			int maxSize = 10 * 1024 * 1024;
			String uploadPath = "img";
			String realPath = request.getServletContext().getRealPath(uploadPath);
			MultipartRequest multi = new MultipartRequest(
					request, realPath, maxSize,"utf-8", new DefaultFileRenamePolicy());
			Enumeration en = multi.getFileNames();
			
			String fileName1 = (String)en.nextElement(); //input 태그의 속성이 file인 태그의 name 속성값 : 파라미터이름
			String fileName = multi.getFilesystemName(fileName1); //서버에 저장된 파일 이름
			String original = multi.getOriginalFileName(fileName1); // 전송전 원래의 파일 이름
			String type = multi.getContentType(fileName1); //전송된 파일의 내용 타입
			File file = multi.getFile(fileName1);  //전송된 파일속성이file인 태그의 name 속성값을 이용해 파일객체생성
			String thumFilePath = "";
			
			if(original == null || original.equals("")){
				thumFilePath = "img/null.jpg";
			} else {
				thumFilePath = "img/"+ fileName;
			}
			
			
			/*
			 * together DTO에 값을 set함
			 */
			
			String id = member.getID();
			String startDate = multi.getParameter("startDate");
			String endDate = multi.getParameter("endDate");
			int joinPoint = Integer.parseInt(multi.getParameter("joinPoint"));
			
			Together together = new Together();
			together.setTitle(multi.getParameter("title"));
			together.setThumPath(thumFilePath);
			together.setDescription(multi.getParameter("description"));
			together.setJoinPoint(joinPoint);
			together.setStartDate(startDate);
			together.setEndDate(endDate);
			together.setMinPerson(Integer.parseInt(multi.getParameter("minPerson")));
			together.setMaxPerson(Integer.parseInt(multi.getParameter("maxPerson")));
			together.setCreatorID(id);
					
			/*
			 *  DAO 활용
			 */
			
			SyDao sd = SyDao.getInstance();
			Join join = new Join();
			int result = sd.Insert(together, join, id);
			
			if(startDate == null || startDate.equals("") || endDate == null || endDate.equals("")) {
				result = 0;
			}
			if(result > 0) {
				int updateResult = sd.pointUpdate(id, joinPoint);
				int joinUResult = sd.joinUpdate(joinPoint);
				
				System.out.println("[TogetherEnrollProAction.java] updateResult :" + updateResult);
				System.out.println("[TogetherEnrollProAction.java] joinUResult :" + joinUResult);
				result = 1;
			} else { 
				session.setAttribute("together", together);
				result = 0;
			}
			
			System.out.println("[TogetherEnrollProAction.java] result :" + result);
			
			request.setAttribute("id", together.getCreatorID());
			if (result == 0 ) {
				request.setAttribute("result", result);
				return "togetherEnrollForm.do";
			}
			request.setAttribute("result", result);
			
			 SaintpDao dao = SaintpDao.getInstance();
	         if (member != null && member.getID() != null) {
	            ArrayList<Together> myTolist = dao.getMyTogetherList(member.getID());
	            ArrayList<Together> CreatedListbyMe = dao.getTogetherListCreatedByMe(member.getID());
	            member = dao.getMember(id);
	            session.setAttribute("member", member);
	            
	            session.setAttribute("myTogetherList", myTolist);
	            session.setAttribute("CreatedListbyMe", CreatedListbyMe);
	         }
			
			
			/*
			 *   체크
			 */
			
			System.out.println("[TogetherEnrollProAction.java] Path : " + realPath);
			System.out.println("[TogetherEnrollProAction.java] 파라메터 이름 : " + fileName1);
			System.out.println("[TogetherEnrollProAction.java] 실제 파일 이름 : " + original);
			System.out.println("[TogetherEnrollProAction.java] 저장된 파일 이름 : " + thumFilePath);
			System.out.println("[TogetherEnrollProAction.java] 파일 타입: " + type);
				
			if(file != null) {
				System.out.println("[TogetherEnrollProAction.java] 파일크기 : " + file.length());
			}
			
			System.out.println("[TogetherEnrollProAction.java] 제목 " + together.getTitle());
			System.out.println("[TogetherEnrollProAction.java] 썸네일 " + together.getThumPath());
			System.out.println("[TogetherEnrollProAction.java] 최소인원 " + together.getMinPerson());
			System.out.println("[TogetherEnrollProAction.java] 최대인원 " + together.getMaxPerson());
			System.out.println("[TogetherEnrollProAction.java] 시작일 " + together.getStartDate());
			System.out.println("[TogetherEnrollProAction.java] 마감일 " + together.getEndDate());
			System.out.println("[TogetherEnrollProAction.java] 참가비용 " + together.getJoinPoint());
			System.out.println("[TogetherEnrollProAction.java] 투게더설명 " + together.getDescription());
			System.out.println("[TogetherEnrollProAction.java] 아이디 " + together.getCreatorID());
			
		} catch (Exception e) {
			System.out.println("[TogetherEnrollProAction.java]" + e.getMessage());
		}
		return "enrollListForm.do";
	}

}
