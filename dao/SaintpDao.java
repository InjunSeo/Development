package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Cert;
import dto.Join;
import dto.Member;
import dto.Together;

public class SaintpDao
{	
	private static SaintpDao singleTon;

	private SaintpDao() {
	}

	public static SaintpDao getInstance() {
		if (singleTon == null) {
			singleTon = new SaintpDao();
		}
		return singleTon;
	}
	
	/**
	 * [Thread...] 
	 * 2. 투게더의 상태 처리
	 *  [모집중->진행중 or 취소]
	 *    -투게더.상태 = 모집중 이고
	 *    -투게더.시작일 <= 오늘 이고
	 *    -투게더.최소인원 > 투게더.참여인원 이면 취소
	 *      +투게더.상태를 취소 && 투게더.참여인원을 0으로 업데이트
	 *      +회원.열정포인트 += 투게더.참여포인트
	 *      +참여 테이블에서 Row 삭제
	 *    -투게더.최소인원 <= 투게더.참여인원 이면 진행중
	 *      +투게더.상태를 진행중 
	 *      +투게더.총잔여포인트 = 참여포인트X참여인원 으로 업데이트.
	 *  [진행중->종료]
	 *    -투게더.상태 = 진행중 이고
	 *    -투게더.종료일 < 오늘 이면
	 *      +참여.보상포인트 += 종료보상포인트
	 *      +회원.열정포인트 += 종료보상포인트
	 *      +투게더.상태 = 종료 & 투게더.총잔여포인트 = 0 으로 업데이트 
  	 */
	public void operTogetherStatus() {
		System.out.println("[SaintpDao.java] operTogetherStatus() start -----------");
		
		//[모집중->진행중 or 취소]
		executeUpdate( 
				"UPDATE Together SET " + 
				"  status = CASE WHEN minPerson > joinPerson THEN 0 ELSE 2 END, " +
				"  joinPerson = CASE WHEN minPerson > joinPerson THEN 0 ELSE joinPerson END, " +
				"  remainPoint = CASE WHEN minPerson > joinPerson THEN 0 ELSE joinPoint*joinPerson END " +
				"WHERE status = 1 " + 
				"  AND startDate <= TO_CHAR(SYSDATE,'YYYYMMDD')");
		
		//[모집중->취소: 회원.열정포인트 += 투게더.참여포인트]
		executeUpdate( "UPDATE Member m SET " + 
				"  Point = Point + ( SELECT SUM(t.joinPoint) FROM Together t, Join j " + 
				"              WHERE t.status = 0 " + 
				"                AND t.toNo = j.toNo " + 
				"                AND j.memberID = m.ID " + 
				"          ) " + 
				"  WHERE ID IN ( SELECT j.memberID FROM Together t, Join j " + 
				"              WHERE t.status = 0 " + 
				"                AND t.toNo = j.toNo)");
		//[모집중->취소: 참여 테이블에서 Row들 삭제]
		executeUpdate( 
				"DELETE FROM Join " + 
				"  WHERE toNo IN ( SELECT toNo FROM Together WHERE status = 0)");
		
		//[모집중->종료: 참여.보상포인트 += 종료보상포인트]
		executeUpdate( 
				"UPDATE Join j SET " + 
				"    rewardPoint = rewardPoint +  " + 
				"      ( " + 
				"      SELECT t.remainPoint*a.ct/b.ct " + 
				"        FROM Together t,  " + 
				"          ( " + 
				"          SELECT c.toNo, c.memberID, COUNT(*) ct FROM Cert c " + 
				"                GROUP BY c.toNo, memberID) a,  " + 
				"          ( " + 
				"          SELECT c.toNo, COUNT(*) ct FROM Cert c " + 
				"                GROUP BY c.toNo " + 
				"            ) b " + 
				"        WHERE j.memberID = a.memberID " + 
				"            AND j.toNo = t.toNo " + 
				"            AND j.toNo = a.toNo " + 
				"            AND j.toNo = b.toNo " + 
				"      ) " + 
				"  WHERE (j.toNo, j.memberID) IN  " + 
				"          ( SELECT DISTINCT j.toNo, j.memberID FROM Join j, Together t  " + 
				"              WHERE t.status = 2 " + 
				"                AND t.endDate < TO_CHAR(SYSDATE,'YYYYMMDD') " + 
				"                AND t.toNo = j.toNo )");
		
		//[모집중->종료: 회원.열정포인트 += 종료보상포인트]
		executeUpdate( 
				"UPDATE Member m SET " + 
				"    Point = Point +  " + 
				"      (SELECT SUM(t.remainPoint*a.ct/b.ct) " + 
				"        FROM Together t,  " + 
				"          ( " + 
				"          SELECT c.toNo, memberID, COUNT(*) ct FROM Cert c " + 
				"                GROUP BY c.toNo, memberID) a,  " + 
				"          ( " + 
				"          SELECT c.toNo, COUNT(*) ct FROM Cert c " + 
				"                GROUP BY c.toNo " + 
				"            ) b " + 
				"        WHERE m.ID = a.memberID " + 
				"            AND a.toNo = t.toNo " + 
				"            AND a.toNo = b.toNo " + 
				"            AND b.toNo = t.toNo " + 
				"        GROUP BY a.memberID " + 
				"      ) " + 
				"  WHERE m.ID IN  " + 
				"          ( SELECT DISTINCT j.memberID FROM Join j, Together t  " + 
				"              WHERE t.status = 2 " + 
				"                AND t.endDate < TO_CHAR(SYSDATE,'YYYYMMDD') " + 
				"                AND t.toNo = j.toNo )");
		
		//[모집중->종료: 투게더.상태를 종료 & 총잔여포인트를 0으로]
		executeUpdate( 
				"UPDATE Together SET " + 
				"  status = 3,  " + 
				"  remainPoint = 0 " + 
				"WHERE status = 2 " + 
				"  AND endDate < TO_CHAR(SYSDATE,'YYYYMMDD')");
	}

	/**
	 * [Thread...] 
	 * 매일 24시에 깨어나 인증 처리 및 종료 처리를 한다. 그 중 인증 처리.
	 * 1. 인증처리
	 *  -인증테이블을 읽어
	 *  -인증.날짜가 (작업정보.처리한날짜+1일) ~ 어제까지인 Row들에 대해 하루치 보상포인트를 나누어 준다.
	 *  -참여.보상포인트 += 하루치 보상포인트
	 *  -회원.열정포인트 += SUM(본인이 인증한 투게더 하루치 보상포인트들)
	 *  -투게더.총잔여포인트 -= SUM(지불한 하루치 보상포인트)
	 *  -(작업정보.최종처리일자,작업정보.작업일) = (어제, 오늘)
	 */
	public void operCert() {
		System.out.println("[SaintpDao.java] operCert() start -----------");

		// 작업일 다음날 부터 어제까지 인증한 것에 대해 참여.보상포인트 += 하루치 보상포인트
		executeUpdate( 
				"UPDATE Join j SET " + 
				"  rewardPoint = rewardPoint + " + 
				"    (SELECT SUM(t.joinPoint/(TO_DATE(t.endDate) - TO_DATE(t.startDate) +1)) " + 
				"      FROM Cert c,Together t " + 
				"            WHERE c.toNo =j.toNo " + 
				"              AND c.memberID = j.memberID " + 
				"              AND c.createDate > (SELECT MAX(lastProcDate) FROM operInfo) " + 
				"              AND c.createDate < TO_CHAR( SYSDATE, 'YYYYMMDD')" + 
				"              AND c.toNo = t.toNo " + 
				"              AND t.status = 2 " + 
				"      GROUP BY c.toNo, c.memberID) " + 
				"  WHERE (toNo, memberID) IN  " + 
				"  (SELECT DISTINCT c.toNo, c.memberID " + 
				"    FROM Cert c, Together t " + 
				"          WHERE c.createDate > (SELECT MAX(lastProcDate) FROM operInfo) " + 
				"            AND c.createDate < TO_CHAR( SYSDATE, 'YYYYMMDD') " + 
				"            AND c.toNo = t.toNo " + 
				"            AND t.status = 2 " + 
				"  ) ");

		//작업일 다음날 부터 어제까지 인증한 것에 대해 회원.열정포인트 += SUM(본인이 인증한 투게더 하루치 보상포인트들)
		executeUpdate(
				" UPDATE Member m SET " + 
				"    point = point +  " + 
				"      (SELECT SUM(t.joinPoint/(TO_DATE(t.endDate) - TO_DATE(t.startDate) +1)) rp " + 
				"        FROM Cert c, Together t " + 
				"          WHERE m.ID = c.memberID " + 
				"            AND c.createDate > (SELECT MAX(lastProcDate) FROM operInfo) " + 
				"            AND c.createDate < TO_CHAR( SYSDATE, 'YYYYMMDD')" + 
				"            AND c.toNo = t.toNo " + 
				"            AND t.status = 2 " + 
				"         GROUP BY c.memberID) " + 
				"  WHERE ID IN " + 
				"     (SELECT DISTINCT c.memberID " + 
				"        FROM Cert c, Together t " + 
				"          WHERE c.createDate > (SELECT MAX(lastProcDate) FROM operInfo) " + 
				"            AND c.createDate < TO_CHAR( SYSDATE, 'YYYYMMDD')" + 
				"            AND c.toNo = t.toNo " + 
				"            AND t.status = 2 " +
				"     ) " 
				);
		
		// 투게더.총잔여포인트 -= SUM(지불한 하루치 보상포인트)
		executeUpdate("UPDATE Together tg SET " + 
				"  tg.remainPoint = tg.remainPoint - " + 
				"    (SELECT SUM(t.joinPoint/(TO_DATE(t.endDate) - TO_DATE(t.startDate) +1)) rp " + 
				"        FROM Cert c, Together t " + 
				"        WHERE tg.toNo = t.toNo " + 
				"          AND c.createDate > (SELECT MAX(lastProcDate) FROM operInfo) " + 
				"          AND c.createDate < TO_CHAR( SYSDATE, 'YYYYMMDD')" + 
				"          AND c.toNo = t.toNo " + 
				"          AND t.status = 2 " + 
				"        GROUP BY c.toNo, t.remainPoint) " + 
				"  WHERE tg.status = 2 " + 
				"    AND tg.toNo IN  " + 
				"        ( SELECT DISTINCT c.toNo FROM Cert c " + 
				"            WHERE c.createDate > (SELECT MAX(lastProcDate) FROM operInfo) " + 
				"              AND c.createDate < TO_CHAR( SYSDATE, 'YYYYMMDD') " + 
				"        ) " 
				);
		
		//(작업정보.최종처리일자,작업정보.작업일) = (어제, 오늘)
		executeUpdate("UPDATE OperInfo SET " + 
				"  lastProcDate = TO_CHAR(SYSDATE - 1, 'YYYYMMDD'), " + 
				"  operDate = TO_CHAR(SYSDATE, 'YYYYMMDD')");
	}

	/**
	 * 검색을 위해서는 keyword 테이블을 정의했어야 하고 그 keyword 테이블은 부모인 Together의 PK를 FK로 가지게 되어야
	 * 이때 검색시 옵티마이저를 고려하여 PK는 첫번째 PK로 keyword, 두번째 PK로는 toNo로 하는 것이 좋겠다. 여튼 우리는 그냥
	 * 한다. ㅋ
	 * 
	 * @param searchWord 검색할 단어
	 * @param status     Together.java에 정의된 STATUS_CANCELED, STATUS_RECRUIT,
	 *                   STATUS_ING, STATUS_FINISHED와 전부 검색을 뜻하는 STATUS_ALL
	 * @return 검색 결과인 Together의 List
	 */
	public ArrayList<Together> getTogetherListForSearch(String searchWord, boolean inCanceled, boolean inRecruit,
			boolean inIng, boolean inFinished, boolean inAll) {

		System.out.println("[SaintpDao.java] getTogetherListForSearch() start");
		System.out.println("[SaintpDao.java] getTogetherListForSearch() searchWord = [" + searchWord + "] " + inCanceled
				+ ", " + inRecruit + ", " + inIng + ", " + inFinished);

		ArrayList<Together> list = new ArrayList<Together>();
		Connection conn = getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Together to = null;

		try {

			String statusSql = null;
			String titleSql = (searchWord == null || searchWord.equals("") ? " 1=1"
					: " title LIKE '" + "%" + searchWord + "%'");

			if (inAll || (!inCanceled && !inRecruit && !inIng && !inFinished && !inAll))
				statusSql = " 1=1 ";
			else {
				statusSql = " status IN ( ";
				boolean plusComma = false;
				if (inCanceled) {
					statusSql += Together.STATUS_CANCELED;
					plusComma = true;
				}
				if (inRecruit) {
					statusSql += (plusComma ? ", " : "") + Together.STATUS_RECRUIT;
					plusComma = true;
				}
				if (inIng) {
					statusSql += (plusComma ? ", " : "") + Together.STATUS_ING;
					plusComma = true;
				}
				if (inFinished) {
					statusSql += (plusComma ? ", " : "") + Together.STATUS_FINISHED;
					plusComma = true;
				}

				statusSql += ") ";
			}

			String sql = "SELECT * FROM Together WHERE " + titleSql + " AND " + statusSql
					+ " ORDER BY createDate DESC ";
			System.out.println("[SaintpDao.java] getTogetherListForHome() [sql] " + sql);

			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) {
				to = new Together();

				to.setTitle(rs.getString("title"));
				to.setDescription(rs.getString("description"));
				to.setThumPath(rs.getString("thumPath"));
				to.setStartDate(rs.getString("startDate"));
				to.setEndDate(rs.getString("endDate"));
				to.setCreatorID(rs.getString("creatorID"));
				to.setCreateDate(rs.getString("createDate"));
				to.setToNo(rs.getInt("toNo"));
				to.setJoinPoint(rs.getInt("joinPoint"));
				to.setMinPerson(rs.getInt("minPerson"));
				to.setMaxPerson(rs.getInt("maxPerson"));
				to.setJoinPerson(rs.getInt("joinPerson"));
				to.setRemainPoint(rs.getInt("remainPoint"));
				to.setStatus(rs.getInt("status"));

				list.add(to);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null)
					rs.close();
			}
			catch (Exception e) {
			}
			try {
				if (ps != null)
					ps.close();
			}
			catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			}
			catch (Exception e) {
			}
		}

		return list;
	}

	/**
	 * 
	 * @return
	 */
	public ArrayList<Together> getTogetherListForHome() {
		ArrayList<Together> list = new ArrayList<Together>();
		System.out.println("[SaintpDao.java] getTogetherListForHome() start");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Together to = null;

		try {

			String sql = "SELECT * FROM Together ORDER BY status, createDate DESC ";
			sql = " " + "SELECT ROWNUM, a.*  " + "FROM (SELECT * FROM Together  " + "  WHERE status = 1 "
					+ "  ORDER BY createDate DESC " + "  ) a " + "WHERE ROWNUM <=3 " + "UNION ALL "
					+ "SELECT ROWNUM, a.*  " + "FROM (SELECT * FROM Together  " + "  WHERE status = 2 "
					+ "  ORDER BY createDate DESC " + "  ) a " + "WHERE ROWNUM <=3 " + "UNION ALL "
					+ "SELECT ROWNUM, a.*  " + "FROM (SELECT * FROM Together  " + "  WHERE status = 3 "
					+ "  ORDER BY createDate DESC " + "  ) a " + "WHERE ROWNUM <=3 " + "UNION ALL "
					+ "SELECT ROWNUM, a.*  " + "FROM (SELECT * FROM Together  " + "  WHERE status = 0 "
					+ "  ORDER BY createDate DESC " + "  ) a " + "WHERE ROWNUM <=3";
			System.out.println("[SaintpDao.java] getTogetherListForHome() [sql] " + sql);
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();

			while (rs.next()) {
				to = new Together();

				to.setTitle(rs.getString("title"));
				to.setDescription(rs.getString("description"));
				to.setThumPath(rs.getString("thumPath"));
				to.setStartDate(rs.getString("startDate"));
				to.setEndDate(rs.getString("endDate"));
				to.setCreatorID(rs.getString("creatorID"));
				to.setCreateDate(rs.getString("createDate"));
				to.setToNo(rs.getInt("toNo"));
				to.setJoinPoint(rs.getInt("joinPoint"));
				to.setMinPerson(rs.getInt("minPerson"));
				to.setMaxPerson(rs.getInt("maxPerson"));
				to.setJoinPerson(rs.getInt("joinPerson"));
				to.setRemainPoint(rs.getInt("remainPoint"));
				to.setStatus(rs.getInt("status"));

				list.add(to);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null)
					rs.close();
			}
			catch (Exception e) {
			}
			try {
				if (ps != null)
					ps.close();
			}
			catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			}
			catch (Exception e) {
			}
		}

		return list;
	}

	
	public ArrayList<Together> getTogetherListCreatedByMe(String ID) {
		ArrayList<Together> list = new ArrayList<Together>();
		System.out.println("[SaintpDao.java] getCreatedListbyMe() start");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Together to = null;

		try {

			String sql = "SELECT * FROM Together WHERE creatorID = ? ORDER BY status";
			System.out.println("[SaintpDao.java] getCreatedListbyMe() [sql] " + sql);
			ps = conn.prepareStatement(sql);

			ps.setString(1, ID);

			rs = ps.executeQuery();

			while (rs.next()) {
				to = new Together();

				to.setTitle(rs.getString("title"));
				to.setDescription(rs.getString("description"));
				to.setThumPath(rs.getString("thumPath"));
				to.setStartDate(rs.getString("startDate"));
				to.setEndDate(rs.getString("endDate"));
				to.setCreatorID(rs.getString("creatorID"));
				to.setCreateDate(rs.getString("createDate"));
				to.setToNo(rs.getInt("toNo"));
				to.setJoinPoint(rs.getInt("joinPoint"));
				to.setMinPerson(rs.getInt("minPerson"));
				to.setMaxPerson(rs.getInt("maxPerson"));
				to.setJoinPerson(rs.getInt("joinPerson"));
				to.setRemainPoint(rs.getInt("remainPoint"));
				to.setStatus(rs.getInt("status"));

				list.add(to);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null)
					rs.close();
			}
			catch (Exception e) {
			}
			try {
				if (ps != null)
					ps.close();
			}
			catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			}
			catch (Exception e) {
			}
		}

		return list;
	}

	public ArrayList<Together> getMyTogetherList(String ID) {
		ArrayList<Together> list = new ArrayList<Together>();
		System.out.println("[SaintpDao.java] myTogetherList() start");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Together to = null;

		try {

			String sql = "SELECT a.* FROM Together a, Join b " + "WHERE b.memberID = ? AND b.toNo = a.toNo "
					+ "ORDER BY status";
			System.out.println("[SaintpDao.java] myTogetherList() [sql] " + sql);
			ps = conn.prepareStatement(sql);

			ps.setString(1, ID);

			rs = ps.executeQuery();

			while (rs.next()) {
				to = new Together();

				to.setTitle(rs.getString("title"));
				to.setDescription(rs.getString("description"));
				to.setThumPath(rs.getString("thumPath"));
				to.setStartDate(rs.getString("startDate"));
				to.setEndDate(rs.getString("endDate"));
				to.setCreatorID(rs.getString("creatorID"));
				to.setCreateDate(rs.getString("createDate"));
				to.setToNo(rs.getInt("toNo"));
				to.setJoinPoint(rs.getInt("joinPoint"));
				to.setMinPerson(rs.getInt("minPerson"));
				to.setMaxPerson(rs.getInt("maxPerson"));
				to.setJoinPerson(rs.getInt("joinPerson"));
				to.setRemainPoint(rs.getInt("remainPoint"));
				to.setStatus(rs.getInt("status"));

				list.add(to);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null)
					rs.close();
			}
			catch (Exception e) {
			}
			try {
				if (ps != null)
					ps.close();
			}
			catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			}
			catch (Exception e) {
			}
		}

		return list;
	}

	public Member getMember(String id) {
		System.out.println("[SaintpDao.java] getMember() start");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Member member = null;

		try {

			String sql = "SELECT * FROM Member WHERE ID = ? ";
			System.out.println("[SaintpDao.java] getMember() [sql] " + sql + ", ID = " + id);
			ps = conn.prepareStatement(sql);

			ps.setString(1, id);

			rs = ps.executeQuery();

			if (rs.next()) {
				member = new Member();

				member.setCreateDate(rs.getString("createDate"));
				member.setEmail(rs.getString("email"));
				member.setID(rs.getString("ID"));
				member.setName(rs.getString("name"));
				member.setPassword(rs.getString("password"));
				member.setPoint(rs.getInt("point"));
				member.setTel(rs.getString("tel"));
				member.print("[SaintpDao.jsp] getMember()");
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null)
					rs.close();
			}
			catch (Exception e) {
			}
			try {
				if (ps != null)
					ps.close();
			}
			catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			}
			catch (Exception e) {
			}
		}

		return member;
	}

	public Together getTogether(int toNo) {
		System.out.println("[SaintpDao.java] getTogether() start");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Together together = null;

		try {

			String sql = "SELECT * FROM Together WHERE toNo = ? ";
			System.out.println("[SaintpDao.java] getTogether() [sql] " + sql);
			ps = conn.prepareStatement(sql);

			ps.setInt(1, toNo);

			rs = ps.executeQuery();

			if (rs.next()) {
				together = new Together();

				together.setTitle(rs.getString("title"));
				together.setDescription(rs.getString("description"));
				together.setThumPath(rs.getString("thumPath"));
				together.setStartDate(rs.getString("startDate"));
				together.setEndDate(rs.getString("endDate"));
				together.setCreatorID(rs.getString("creatorID"));
				together.setCreateDate(rs.getString("createDate"));
				together.setToNo(rs.getInt("toNo"));
				together.setJoinPoint(rs.getInt("joinPoint"));
				together.setMinPerson(rs.getInt("minPerson"));
				together.setMaxPerson(rs.getInt("maxPerson"));
				together.setJoinPerson(rs.getInt("joinPerson"));
				together.setRemainPoint(rs.getInt("remainPoint"));
				together.setStatus(rs.getInt("status"));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null)
					rs.close();
			}
			catch (Exception e) {
			}
			try {
				if (ps != null)
					ps.close();
			}
			catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			}
			catch (Exception e) {
			}
		}

		return together;
	}

	public boolean isEnoughPoint(int toNo, String memberID) {
		return checkExistence("SELECT * FROM Together a, Member b " + " WHERE a.joinPoint <= b.point " + " AND b.ID = '"
				+ memberID + "' AND a.toNo = " + toNo);
	}

	public boolean isJoined(int toNo, String memberID) {
		return checkExistence("SELECT * FROM Join WHERE toNo = " + toNo + " AND memberID = '" + memberID + "'");
	}

	public boolean isTogetherRecruit(int toNo) {
		return checkExistence(
				"SELECT * FROM Together WHERE Status = " + Together.STATUS_RECRUIT + " AND toNo = " + toNo);
	}

	public boolean existMember(String memberID) {
		return checkExistence("SELECT * FROM Member WHERE " + " ID = '" + memberID + "'");
	}


	public boolean isCreatorOfTogether(int toNo, String memberID) {
		return checkExistence("SELECT * FROM Together WHERE toNo = " + toNo + " AND CreatorID = '" + memberID + "'");
	}
	
	public boolean existTogether(int toNo) {
		return checkExistence("SELECT * FROM Together WHERE toNo = " + toNo);
	}

	public boolean isJoinPersonFull(int toNo) {
		return checkExistence("SELECT * FROM Together WHERE maxPerson <= joinPerson AND toNo = " + toNo);
	}

	public boolean checkExistence(String sql) {
		System.out.println("[SaintpDao.java] checkExistence() start");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean result = false;

		try {
			System.out.println("[SaintpDao.java] checkExistence() [sql] " + sql);
			ps = conn.prepareStatement(sql);

			rs = ps.executeQuery();
			result = rs.next();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (rs != null)
					rs.close();
			}
			catch (Exception e) {
			}
			try {
				if (ps != null)
					ps.close();
			}
			catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			}
			catch (Exception e) {
			}
		}

		return result;
	}

	public int executeUpdate(String sql) {
		System.out.println("[SaintpDao.java] executeUpdate() start");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		int result = 0;

		try {
			System.out.println("[SaintpDao.java] executeUpdate() [sql] " + sql);
			ps = conn.prepareStatement(sql);

			result = ps.executeUpdate();
			System.out.println("[SaintpDao.java] executeUpdate() result= " + result);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (ps != null)
					ps.close();
			}
			catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			}
			catch (Exception e) {
			}
		}

		return result;
	}

	/**
	 * [특정 투게더 참여 신청시] 
	 * 1. 투게더.최대인원 > 투게더.참여인원 : true -> 참여 허용. false-> 참여 불가.​ 
	 * 2. 투게더.참여포인트 > 본인.열정포인트 이면 참여불가 
	 *    -포인트를 추가 충전 하거나, 
	 *    -다른투게더 참여를 취소해서 본인 포인트를 늘여야 함.
	 *    (주의:참여취소는 투게더.상태가 "모집중"일 때만 가능) 
	 * 3. 참여 허용 
	 *   -회원.열정포인트 업데이트. 
	 *     +회원.열정포인트 -= 투게더.참여포인트. 
	 *   -투게더.참여인원++ 업데이트 
	 *   -참여 테이블에 한 row insert.
	 * 
	 * @param toNo
	 * @param memberID
	 * @return
	 */
	public int join(int toNo, String memberID) {
		System.out.println("[SaintpDao.java] join() start -----------");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		int result = 0;

		try {

			String sql = "INSERT INTO Join ( toNo, memberID, joinDate) VALUES (?, ?, TO_CHAR(SYSDATE, 'YYYYMMDD'))";

			// Join 테이블에 Insert의 조건 체크.
			// 상태가 모집중인 투게더에 대해서만
			// 투게더.최대인원 > 투게더.참여인원
			// 이 사용자의 열정포인트가 충분
			sql = "INSERT INTO Join(toNo, memberID, joinDate) " + "(SELECT  a.toNo, b.ID, TO_CHAR(SYSDATE, 'YYYYMMDD') "
					+ " FROM Together a, Member b " + " WHERE a.Status = " + Together.STATUS_RECRUIT
					+ " AND a.maxPerson > a.joinPerson " + " AND a.joinPoint <= b.point AND b.ID = ? AND a.toNo = ?)";
			System.out.println("[SaintpDao.java] join() [sql] " + sql);
			ps = conn.prepareStatement(sql);

			ps.setString(1, memberID);
			ps.setInt(2, toNo);

			result = ps.executeUpdate();

			if (result == 0) {
				if (isJoined(toNo, memberID)) {
					// 이미 참여중이거나... 이부분은 오지 않을 부분이긴 함. catch로 빠지거든...
					result = Join.JOINED_ALREADY;
				}
				else if (isJoinPersonFull(toNo)) {
					// 투게더 참여자가 이미 최대인원수에 도달했거나
					result = Together.JOINPERSON_FULL;
				}
				else if (!existTogether(toNo)) {
					// 투게더가 삭제되었거나
					result = Together.NOT_EXIST;
				}
				else if (!existMember(memberID)) {
					// 아이디가 삭제되었거나
					result = Member.NOT_EXIST;
				}
				else if (!isTogetherRecruit(toNo)) {
					// 투게더의 상태가 모집중이 아니거나
					result = Join.JOIN_REJECT_TOGETHER_STATUS;
				}
				else if (!isEnoughPoint(toNo, memberID)) {
					// 회원의 열정포인트 < 투게더의 참여포인트
					result = Join.JOIN_REJECT_MEMBER_POINT;
				}
			}
			else { // insert에 성공하면 아래 처리.

				// 회원.열정포인트 업데이트 (회원.열정포인트 -= 투게더.참여포인트)
				executeUpdate(
						" UPDATE Member SET point = point - ( SELECT joinPoint FROM Together WHERE toNo = " + toNo
								+ ") " + " WHERE ID = '" + memberID + "'");

				// 투게더.참여인원 ++ 업데이트
				executeUpdate(
						" UPDATE Together SET joinPerson = joinPerson + 1, remainPoint = joinPoint*(joinPerson+1) " + " WHERE toNo = " + toNo);

				result = Join.JOIN_SUCCESS;
			}
		}
		catch (java.sql.SQLIntegrityConstraintViolationException e) {
			System.out.println("[SaintpDao.java] join() SQLIntegrityConstraintViolationException ");
			if (isJoined(toNo, memberID)) {
				// 이미 참여중이라면
				result = Join.JOINED_ALREADY;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if (ps != null)
					ps.close();
			}
			catch (Exception e) {
			}
			try {
				if (conn != null)
					conn.close();
			}
			catch (Exception e) {
			}
		}

		return result;
	}

	/**
	 * [특정 투게더 참여 취소] 
	 * -본인이 생성한 투게더에서의 참여취소는 불허
	 * -투게더.상태가 모집중일 것
	 * -참여취소가 허용되면 참여 테이블에서 Row를 삭제하고
	 * -본인의 열정포인트 += 투게더.참여포인트 로 업데이트
	 * -투게더.참여인원 -- 로 업데이트
	 * 
	 * @param toNo
	 * @param memberID
	 * @return
	 */
	public int withdraw(int toNo, String memberID) {
		System.out.println("[SaintpDao.java] join() start -----------");
		int result = 0;

		// 참여취소가 허용되면 참여 테이블에서 Row를 삭제하고
		result = executeUpdate("DELETE FROM Join " + 
				"  WHERE memberID = '" + memberID +"' " + 
				"    AND toNo =  " + 
				"        ( SELECT toNo FROM Together  " + 
				"            WHERE toNo = " + toNo + " AND creatorID <> '" + memberID 
				+ 				"' AND status = " + Together.STATUS_RECRUIT + ")");
		
		if ( result > 0) {			
			//본인의 열정포인트 += 투게더.참여포인트 로 업데이트
			executeUpdate("UPDATE Member SET " + 
					"  Point = Point + ( SELECT joinPoint FROM Together WHERE toNo = " + toNo + ") " + 
					"  WHERE ID = '" + memberID + "'");
			
			// 투게더.참여인원 -- 로 업데이트
			executeUpdate("UPDATE Together SET JoinPerson = JoinPerson - 1 WHERE toNo = " + toNo);
			
			result = Join.WITHDRAW_SUCCESS;
		}
		else {		
			if (!isTogetherRecruit(toNo)) {
				// 투게더의 상태가 모집중이 아니거나
				result = Join.WITHDRAW_REJECT_TOGETHER_STATUS;
			}
			else if (!existTogether(toNo)) {
				// 투게더가 삭제되었거나
				result = Together.NOT_EXIST;
			}
			else if (!existMember(memberID)) {
				// 아이디가 삭제되었거나
				result = Member.NOT_EXIST;
			}
			else if (isCreatorOfTogether(toNo, memberID)) {
				// 본인이 생성한 투게더이거나
				result = Join.IS_CREATOR_OF_TOGETHER;
			}
		}
		return result;
	}

	/**
	 * 인증.
	 * 오늘 이미 참여했으면
	 * 
	 * @param toNo
	 * @param memberID
	 * @return
	 */
	public int cert(int toNo, String memberID) {
		System.out.println("[SaintpDao.java] cert() start -----------");
		int result = 0;

		result = executeUpdate("INSERT INTO CERT ( toNo, memberID, filePath, createDate) " + 
				"  VALUES ( " + toNo + ", '" + memberID + "', 'dummy', TO_CHAR( SYSDATE, 'YYYYMMDD'))");
		
		if ( result == 1) {
			result = Cert.CERT_SUCCESS;		
		}
		else {
			if (checkExistence("SELECT * FROM CERT  " + 
					"  WHERE MemberID = '" + memberID + "' " + 
					"    AND toNo = " + toNo + 
					"    AND createDate = TO_CHAR( SYSDATE, 'YYYYMMDD')")) {
				// 이미 인증함.
				result = Cert.ALREADY_CERT;	
			}
			else if (!existTogether(toNo)) {
				// 투게더가 삭제되었거나
				result = Together.NOT_EXIST;
			}
			else if (!existMember(memberID)) {
				// 아이디가 삭제되었거나
				result = Member.NOT_EXIST;
			}
		}
		
		return result;
	}


	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}

		return conn;
	}
}
