package dto;

import util.Util;

public class Cert {
	public final static int CERT_SUCCESS = -11;	// 인증 성공.
	public final static int ALREADY_CERT = -12;	// 오늘은 이미 인증함.
	
	private String createDate = "";
	private int toNo = 0;
	private String memberID = "";
	private String filePath = "";

	public String getCreateDate() {
		return createDate;
	}

	public String getCreateDateWithDelimiter() {

		return Util.addDelimiterToStringDate( createDate);
	}
	
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public int getToNo() {
		return toNo;
	}

	public void setToNo(int toNo) {
		this.toNo = toNo;
	}

	public String getMemberID() {
		return memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

}
