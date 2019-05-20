<%@page import="dto.Together"%>
<%@page import="java.util.List"%>
<%@page import="dao.YnvlyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	request.setCharacterEncoding("utf-8");
	String sortNum = null;
	sortNum = request.getParameter("sortNum");
	YnvlyDao yd = YnvlyDao.getInstance();
	System.out.println("[sortingFinListAjax.jsp]sortNum=>"+sortNum);
	
	List<Together> rwdSortFinList = yd.getFinList();
	List<Together> dateSortFinList = yd.getFinList();
	
	for(Together t: rwdSortFinList){
		System.out.println("[for]together RewardPoint=>"+ t.getMaxRewardPoint());
	}
	for(int i = 0; i<rwdSortFinList.size()-1; i++) {
		int iRwdPoint = rwdSortFinList.get(i).getMaxRewardPoint();
		System.out.println("iRwdPoint first=>"+iRwdPoint);
		for(int j=i+1; j<rwdSortFinList.size();j++) {
			int jRwdPoint = rwdSortFinList.get(j).getMaxRewardPoint();
			System.out.println("jRwdPoint second=>"+jRwdPoint);
			if(iRwdPoint<jRwdPoint) {
				Together temp = rwdSortFinList.get(i);
				rwdSortFinList.set(i, rwdSortFinList.get(j));
				rwdSortFinList.set(j, temp);
			}
			if(iRwdPoint==jRwdPoint){
				System.out.println("here->"+rwdSortFinList.get(i).getEndDate());
				int endDate1= Integer.parseInt(rwdSortFinList.get(i).getEndDate());
				
				int endDate2= Integer.parseInt(rwdSortFinList.get(j).getEndDate());
				System.out.println("endDate1=>"+endDate1+"endDate2=>"+endDate2);
				if(endDate1<endDate2) {
					Together temp = rwdSortFinList.get(i);
					rwdSortFinList.set(i, rwdSortFinList.get(j));
					rwdSortFinList.set(j, temp);
				}
			}
		}
	}
	System.out.println("[rwdSortFinList]"+rwdSortFinList);
	for(int i = 0; i<dateSortFinList.size()-1; i++) {
		int endDate1= Integer.parseInt(dateSortFinList.get(i).getEndDate());
		
		for(int j=i+1; j<rwdSortFinList.size();j++) {
			int endDate2= Integer.parseInt(dateSortFinList.get(j).getEndDate());
			
			if(endDate1<endDate2) {
				Together temp = dateSortFinList.get(i);
				dateSortFinList.set(i, dateSortFinList.get(j));
				dateSortFinList.set(j, temp);
			}
			if(endDate1==endDate2){
				int iRwdPoint = dateSortFinList.get(i).getMaxRewardPoint();
				int jRwdPoint = dateSortFinList.get(j).getMaxRewardPoint();
				
				if(iRwdPoint<jRwdPoint) {
					Together temp = dateSortFinList.get(i);
					dateSortFinList.set(i, dateSortFinList.get(j));
					dateSortFinList.set(j, temp);
				}
			}
		}
	}
	System.out.println("[dateSortFinList]"+dateSortFinList);
	System.out.println("[rwdSortFinList]sortNum=>"+sortNum);
	
	if(sortNum.equals("0")){
		request.setAttribute("finList", rwdSortFinList);
		for(Together t: rwdSortFinList){
			System.out.println("rwdSortFinList->"+t.getEndDate());
		}
	}
	else if(sortNum.equals("1")){
		request.setAttribute("finList", dateSortFinList);
	}  else {
		System.out.println("here sortNum"+sortNum);
	}

%>

<%@ include file = "../finListFormView.jsp" %>