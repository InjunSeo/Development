package dto;
import util.Util;

public class Join {
	public final static int JOINED_ALREADY = -21;		// 이미 조인되어 있다.
	public final static int JOIN_REJECT_TOGETHER_STATUS = -22;	// 조인이 불가능하다. 해당 투게더의 상태가 모집중이 아니다.
	public final static int JOIN_REJECT_MEMBER_POINT = -23;	// 조인이 불가능하다. 회원의 열정포인트 < 투게더의 조인포인트
	public final static int JOIN_SUCCESS = -29;		// 조인에 성공하다
	public final static int WITHDRAW_SUCCESS = -29;		// 참여취소에 성공하다
	public final static int WITHDRAW_REJECT_TOGETHER_STATUS = -22;	// 참여취소가 불가능하다. 해당 투게더의 상태가 모집중이 아니다.
	public final static int IS_CREATOR_OF_TOGETHER = -28;	// 참여취소가 불가능하다. 해당 투게더의 상태가 모집중이 아니다.
	
	public static int getJoinSuccess() {
		return JOIN_SUCCESS;
	}

	public static int getJoinedAlready() {
		return JOINED_ALREADY;
	}

	public static int getJoinRejectTogetherStatus() {
		return JOIN_REJECT_TOGETHER_STATUS;
	}

	public static int getJoinRejectMemberPoint() {
		return JOIN_REJECT_MEMBER_POINT;
	}

	private int toNo = 0;
	private String memberID = "";
	private String joinDate = "";
	private int rewardPoint = 0;

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

	public String getJoinDateWithDelimiter() {

		return Util.addDelimiterToStringDate( joinDate);
	}
	
	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public int getRewardPoint() {
		return rewardPoint;
	}

	public void setRewardPoint(int rewardPoint) {
		this.rewardPoint = rewardPoint;
	}
}
