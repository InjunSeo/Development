<%@page import="dto.Member"%>
<%@page import="dao.SaintpDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="dao.JunDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String sToNo  = request.getParameter("toNo");
	String mID = request.getParameter("ID");
	System.out.println("[certProAjax.jsp] " + sToNo + ", " + mID);
	int result = 0;
	int toNo = 0;
	JunDao jun = JunDao.getInstance();

	if (sToNo != null && !sToNo.equals("")) {
		toNo = Integer.parseInt(sToNo);
 		//file upload를 위해, cos.jar 추가 & 객체 생성
		MultipartRequest multi = null;
		//upload될 파일의 최대 사이즈 설정
		int sizeLimit = 10*1024*1024;
		// Real path for uploading file
/*  		String realPath  = request.getRealPath("/img");
		System.out.println("[certProAjax] Real path: " +realPath);
		multi = new MultipartRequest(request, realPath, sizeLimit, "UTF-8", new DefaultFileRenamePolicy());

		String fileName = multi.getFilesystemName("uploadFile");
 */
String fileName = "aaa";
		System.out.println("[certProAjax]fileName: " + fileName);
		 

		// Cert Table에 해당 toNo, ID, filePath insert하기 
	 	result = jun.insertCert(toNo, mID, fileName);
		if(result > 0 ) {
			SaintpDao saint = SaintpDao.getInstance();
			Member member = saint.getMember(mID);
			session.setAttribute("member", member);
		}
		System.out.println("[certProAjax.jsp] result = " + result);
	}
%>

<%=result %>