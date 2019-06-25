package dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import util.Util;

public class Together {
	public final static int STATUS_CANCELED = 0; // 폭파됨
	public final static int STATUS_RECRUIT = 1; // 모집중
	public final static int STATUS_ING = 2; // 진행중
	public final static int STATUS_FINISHED = 3; // 종료
	public final static int STATUS_ALL = -1; // 검색 시 상태 전부를 원할 때를 위해
	
	public final static int NOT_EXIST = -51;	// 그 투게더는 존재하지 않는다.
	public final static int JOINPERSON_FULL = -52;	// 그 투게더는 존재하지 않는다.

	public static int getNotExist() {
		return NOT_EXIST;
	}

	private int toNo = 0;
	private String title = "";
	private String description = "";
	private String thumPath = "";
	private int joinPoint = 0;
	private String startDate = "";
	private String endDate = "";
	private int minPerson = 0;
	private int maxPerson = 0;
	private int joinPerson = 0;
	private int remainPoint = 0;
	private String creatorID = "";
	private String createDate = "";
	private int status = 0;
	
	private int maxRewardPoint = 0;	// 해당 투게더의 가장 높은 리워드 포인트 

	

	public int getMaxRewardPoint() {
		return maxRewardPoint;
	}

	public void setMaxRewardPoint(int maxRewardPoint) {
		this.maxRewardPoint = maxRewardPoint;
	}

	public static int getStatusCanceled() {
		return STATUS_CANCELED;
	}

	public static int getStatusRecruit() {
		return STATUS_RECRUIT;
	}

	public static int getStatusIng() {
		return STATUS_ING;
	}

	public static int getStatusFinished() {
		return STATUS_FINISHED;
	}
	
	public static int getStatusAll() {
		return STATUS_ALL;
	}

	/**
	 * 이 투게더의 총 합산 포인트를 리턴한다.
	 * 
	 * @return 총 합산 포인트
	 */
	public int getGrossPoint() {
		return joinPoint * joinPerson;
	}

	public String getCreateDateWithDelimiter() {

		return Util.addDelimiterToStringDate( createDate);
	}

	public String getStartDateWithDelimiter() {

		return Util.addDelimiterToStringDate( startDate);
	}
	
	public String getEndDateWithDelimiter() {

		return Util.addDelimiterToStringDate( endDate);
	}

	public int getToNo() {
		return toNo;
	}

	public void setToNo(int toNo) {
		this.toNo = toNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getThumPath() {
		return thumPath;
	}

	public void setThumPath(String thumPath) {
		this.thumPath = thumPath;
	}

	public int getJoinPoint() {
		return joinPoint;
	}

	public void setJoinPoint(int joinPoint) {
		this.joinPoint = joinPoint;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getMinPerson() {
		return minPerson;
	}

	public void setMinPerson(int minPerson) {
		this.minPerson = minPerson;
	}

	public int getMaxPerson() {
		return maxPerson;
	}

	public void setMaxPerson(int maxPerson) {
		this.maxPerson = maxPerson;
	}

	public int getJoinPerson() {
		return joinPerson;
	}

	public void setJoinPerson(int joinPerson) {
		this.joinPerson = joinPerson;
	}

	public int getRemainPoint() {
		return remainPoint;
	}

	public void setRemainPoint(int remainPoint) {
		this.remainPoint = remainPoint;
	}

	public String getCreatorID() {
		return creatorID;
	}

	public void setCreatorID(String creatorID) {
		this.creatorID = creatorID;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	public double getProgressRate() {
		double result = 0f;
		Date now = new Date();
		SimpleDateFormat sdf = 
				new SimpleDateFormat("yyyyMMdd");
		Date startD = null;
		Date endD = null;
		
		try {
			startD = sdf.parse(startDate);
			endD = sdf.parse(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		System.out.println( "[Together.java] startDate = " + startDate);
		System.out.println( "[Together.java] endDate = " + endDate);
		System.out.println( "[Together.java] startD = " + startD);
		System.out.println( "[Together.java] endD = " + endD);
		System.out.println( "[Together.java] now = " + now);
		System.out.println( "[Together.java] now.getTime() = " + now.getTime());
		System.out.println( "[Together.java] startD.getTime() = " + startD.getTime());
		System.out.println( "[Together.java] endD.getTime() = " + endD.getTime());
		
		System.out.println( "[Together.java] ( now.getTime() - startD.getTime() ) = " + (now.getTime() - startD.getTime()));
		
		long diffM = endD.getTime() - startD.getTime() + (24*60*60*1000);
		long diffJ = now.getTime() - startD.getTime();

		System.out.printf( "[Together.java] diffM = %d", diffM);
		System.out.printf( ", [Together.java] diffJ = %d", diffJ);
		
		result = (double) diffJ / diffM;
		
		System.out.printf( "\n[Together.java] result = %5.2f", result);
		
		if(result > 1) { result = 1; }
		
		return result;
	}
	
	public int getPeriod() {
		int result  = 0;
		Date date1 = null;
		Date date2 = null; 
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
			date1 = format.parse(startDate);
			date2 = format.parse(endDate);
			System.out.println("date1: "+ date1);
			System.out.println("date2: "+ date2);
			
			long calDate  = date2.getTime() - date1.getTime();
			long calDateDays = calDate/ (24*60*60*1000);
			System.out.println("[Together.java] getPeriod() date2-date1: " +calDateDays);
			result = (int) calDateDays;
		}catch (Exception e) {
			System.out.println(e.getMessage());// TODO: handle exception
		}
		return result;
	}
}
