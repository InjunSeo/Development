package dto;

import util.Util;

public class Reply {
	private int seq = 0;
	private int ToNo = 0;
	private String Reply = "";
	private String creatorID = "";
	private String createDate = "";

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getToNo() {
		return ToNo;
	}

	public void setToNo(int toNo) {
		ToNo = toNo;
	}

	public String getReply() {
		return Reply;
	}

	public void setReply(String reply) {
		Reply = reply;
	}

	public String getCreatorID() {
		return creatorID;
	}

	public void setCreatorID(String creatorID) {
		this.creatorID = creatorID;
	}
	
	public String getCreateDateWithDelimiter() {

		return Util.addDelimiterToStringDate( createDate);
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
}
