package service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.SaintpDao;
import dao.SyDao;
import dto.Member;
import dto.Together;

public class TogetherModifyProAction implements InterfaceForAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(); 		
		Member member = (Member) session.getAttribute("member");
		System.out.println("[TogetherModifyProAction.java]:성공??!!!");
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
			System.out.println("[TogetherModifyProAction.java]:53535353!!");
			
			/*
			 * together DTO에 값을 set함
			 */
			
			String id = member.getID();
			System.out.println("[TogetherModifyProAction.java]:id !" +id);
			int toNo = Integer.parseInt(multi.getParameter("toNo"));
			System.out.println("[TogetherModifyProAction.java]:toNo !" +toNo);
			
			Together together = new Together();
			together.setToNo(toNo);
			together.setTitle(multi.getParameter("title"));
			together.setThumPath(thumFilePath);
			together.setDescription(multi.getParameter("description"));
			together.setMinPerson(Integer.parseInt(multi.getParameter("minPerson")));
			together.setMaxPerson(Integer.parseInt(multi.getParameter("maxPerson")));
			
			System.out.println("[TogetherModifyProAction.java]:69line !");
			/*
			 *  DAO 활용
			 */
			
			SyDao sd = SyDao.getInstance();
			int modResult = sd.toUpdate(together, id);
			
			if(modResult > 0) {
				modResult = 1;
			} else { 
				modResult = 0;
			}

			System.out.println("[TogetherModifyProAction.java] modResult :" + modResult);
			
			request.setAttribute("id", id);
			if (modResult == 0 ) {
				request.setAttribute("modResult", modResult);
				return "togetherModifyForm.do";
			}
			request.setAttribute("modResult", modResult);
			
			
			 SaintpDao dao = SaintpDao.getInstance();
	         if (member != null && member.getID() != null) {
	            ArrayList<Together> myTolist = dao.getMyTogetherList(member.getID());
	            ArrayList<Together> CreatedListbyMe = dao.getTogetherListCreatedByMe(member.getID());
	            
	            session.setAttribute("myTogetherList", myTolist);
	            session.setAttribute("CreatedListbyMe", CreatedListbyMe);
	         }
			
			/*
			 *  체크리스트
			 */
			
			System.out.println("[TogetherModifyProAction.java] Path : " + realPath);
			System.out.println("[TogetherModifyProAction.java] 파라메터 이름 : " + fileName1);
			System.out.println("[TogetherModifyProAction.java] 실제 파일 이름 : " + original);
			System.out.println("[TogetherModifyProAction.java] 저장된 파일 이름 : " + thumFilePath);
			System.out.println("[TogetherModifyProAction.java] 파일 타입: " + type);
				
			if(file != null) {
				System.out.println("[TogetherModifyProAction.java] 파일크기 : " + file.length());
			}
			
			System.out.println("[TogetherModifyProAction.java] 제목 " + together.getTitle());
			System.out.println("[TogetherModifyProAction.java] 썸네일 " + together.getThumPath());
			System.out.println("[TogetherModifyProAction.java] 최소인원 " + together.getMinPerson());
			System.out.println("[TogetherModifyProAction.java] 최대인원 " + together.getMaxPerson());
			System.out.println("[TogetherModifyProAction.java] 시작일 " + together.getStartDate());
			System.out.println("[TogetherModifyProAction.java] 마감일 " + together.getEndDate());
			System.out.println("[TogetherModifyProAction.java] 참가비용 " + together.getJoinPoint());
			System.out.println("[TogetherModifyProAction.java] 투게더설명 " + together.getDescription());
			System.out.println("[TogetherModifyProAction.java] 아이디 " + together.getCreatorID());
			
		} catch (Exception e) {
			System.out.println("[TogetherModifyProAction.java]" + e.getMessage());
		}
		return "enrollListForm.do";
	}

}
