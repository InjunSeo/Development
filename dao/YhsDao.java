package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Join;
import dto.Member;
import dto.Together;

public class YhsDao {
	//싱글 톤
	private static YhsDao instance;
	private YhsDao() { }
	
	public static YhsDao getInstance() {
		if( instance == null) { instance = new YhsDao(); }
		return instance;
	}
	
	//DBCP
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	
	public List<Together> recruitList(int startRow, int endRow, String sorting) throws SQLException {
		List<Together> list = new ArrayList<Together>();	// 공간을 잡아줌
		Connection conn = null;	
		PreparedStatement pstmt = null;
		String sql1 = "SELECT toNo, title, startDate, endDate, joinPoint, joinPerson, maxPerson, thumPath FROM (SELECT ROWNUM rn , a.* FROM	(SELECT * FROM together WHERE status=1 ORDER BY createDate DESC) a ) WHERE rn BETWEEN ? AND ?";
		String sql2 = "SELECT toNo, title, startDate, endDate, joinPoint, joinPerson, maxPerson, thumPath FROM (SELECT ROWNUM rn , a.* FROM	(SELECT * FROM together WHERE status=1 ORDER BY joinPerson DESC) a ) WHERE rn BETWEEN ? AND ?";
		String sql3 = "SELECT toNo, title, startDate, endDate, joinPoint, joinPerson, maxPerson, thumPath FROM (SELECT ROWNUM rn , a.* FROM	(SELECT * FROM together WHERE status=1 ORDER BY joinPoint DESC) a ) WHERE rn BETWEEN ? AND ?";
		ResultSet rs = null;
		try {	
			conn = getConnection();
			if (sorting.equals("1")) {
			    pstmt = conn.prepareStatement(sql1);
			    System.out.println("sql1->"+sql1);
			} else if (sorting.equals("2")) {
				pstmt = conn.prepareStatement(sql2);
			    System.out.println("sql2->"+sql2);
			} else { 
			    System.out.println("sql3->"+sql3);
				pstmt = conn.prepareStatement(sql3);
			}
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				rs = pstmt.executeQuery();
				while(rs.next()) {
						Together recruit = new Together();
						recruit.setTitle(rs.getString("title"));
						recruit.setStartDate(rs.getString("startDate"));
						recruit.setEndDate(rs.getString("endDate"));
						recruit.setJoinPoint(rs.getInt("joinPoint"));
						recruit.setJoinPerson(rs.getInt("joinPerson"));
						recruit.setMaxPerson(rs.getInt("maxPerson"));
						recruit.setThumPath(rs.getString("thumPath"));
						recruit.setToNo(rs.getInt("toNo"));
						list.add(recruit);
						
						System.out.println("dao title=>"+recruit.getTitle());
				}
		} catch(Exception e) { System.out.println(e.getMessage());
		} finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return list;
	}

	public List<Together> search(String title) throws SQLException {
	
		List<Together> search = new ArrayList<Together>();	// 공간을 잡아줌
		Connection conn = null;	
		PreparedStatement pstmt = null;	
		String sql = "SELECT toNo, title, startDate, endDate, joinPoint, joinPerson, maxPerson, thumPath FROM together WHERE title LIKE ? AND status=1 ORDER BY createDate DESC";
		ResultSet rs = null;
		title = "%"+title+"%";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			System.out.println("sql->"+sql); 
			pstmt.setString(1, title);
			rs = pstmt.executeQuery();
				while(rs.next()) {
						Together recruit = new Together();
						recruit.setToNo(rs.getInt("toNo"));
						recruit.setTitle(rs.getString("title"));
						recruit.setStartDate(rs.getString("startDate"));
						recruit.setEndDate(rs.getString("endDate"));
						recruit.setJoinPoint(rs.getInt("joinPoint"));
						recruit.setJoinPerson(rs.getInt("joinPerson"));
						recruit.setMaxPerson(rs.getInt("maxPerson"));
						recruit.setThumPath(rs.getString("thumPath"));
						search.add(recruit);
						
						System.out.println("title search=>"+recruit.getTitle());
			}
		} catch(Exception e) { System.out.println(e.getMessage());
		} finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return search;
	}
	
	public int getTotalCnt() throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "SELECT count(*) FROM together WHERE status=1";	//board에서 총 row 개수
		int result = 0;
		try {
			conn = getConnection();
			stmt = conn.createStatement(); 		//DB에 sql 송신위해 생성
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				result = rs.getInt(1);			//sql문의 1번째 즉 count값을 result에 넣는다.
			}
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		finally {
			if(conn != null) conn.close();
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			
		}
		return result;
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

	public boolean existTogether(int toNo) {
		return checkExistence("SELECT * FROM Together WHERE toNo = " + toNo);
	}

	public boolean checkExistence(String sql) {
		System.out.println("[YhsDao.java] checkExistence() start");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		boolean result = false;

		try {
			System.out.println("[YhsDao.java] checkExistence() [sql] " + sql);
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
	
	public int join(int toNo, String memberID) {
		System.out.println("[YhsDao.java] join() start");
		Connection conn = getConnection();
		PreparedStatement ps = null;
		int result = 0;

		try {

			String sql = "INSERT INTO Join ( toNo, memberID, joinDate) VALUES (?, ?, TO_CHAR(SYSDATE, 'YYYYMMDD'))";

			// 상태가 모집중인 투게더에 대해서만 Join 테이블에 Insert.
			// 이 사용자의 열정포인트가 충분한지 확인.
//			sql = " INSERT INTO Join ( toNo, memberID, joinDate) " + " (SELECT  toNo, ? , TO_CHAR(SYSDATE, 'YYYYMMDD') "
//					+ " FROM Together WHERE Status = " + Together.STATUS_RECRUIT + " AND toNo = ?) ";

			sql = "INSERT INTO Join(toNo, memberID, joinDate) " + "(SELECT  a.toNo, b.ID, TO_CHAR(SYSDATE, 'YYYYMMDD') "
					+ " FROM Together a, Member b " + " WHERE a.Status = " + Together.STATUS_RECRUIT
					+ " AND a.joinPoint <= b.point AND b.ID = ? AND a.toNo = ?)";
			System.out.println("[YhsDao.java] join() [sql] " + sql);
			ps = conn.prepareStatement(sql);

			ps.setString(1, memberID);
			ps.setInt(2, toNo);

			result = ps.executeUpdate();

			if (result == 0) {
				if (isJoined(toNo, memberID)) {
					// 이미 참여중이거나
					result = Join.JOINED_ALREADY;
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
			else {
				result = Join.JOIN_SUCCESS;
			}
		}
		catch( java.sql.SQLIntegrityConstraintViolationException e) {
			System.out.println("[YhsDao.java] join() SQLIntegrityConstraintViolationException ");
			if (isJoined(toNo, memberID)) {
				// 이미 참여중이거나
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
/*	public List<Together> listSorting(String sorting) throws SQLException {
		List<Together> listSorting = new ArrayList<Together>();	// 공간을 잡아줌
		Connection conn = null;	
		PreparedStatement pstmt = null;
		String sql1 = "SELECT * FROM Together WHERE status=1 ORDER BY createDate DESC";
		String sql2 = "SELECT * FROM Together WHERE status=1 ORDER BY joinPoint DESC";
		String sql3 = "SELECT * FROM Together WHERE status=1 ORDER BY joinPerson DESC";
		System.out.println("YhsDao listSorting sorting->"+sorting);
		ResultSet rs = null;
		try {
				conn = getConnection();
				if (sorting.equals("1")) {
				    pstmt = conn.prepareStatement(sql1);
				    System.out.println("sql1->"+sql1);
				} else if (sorting.equals("2")) {
					pstmt = conn.prepareStatement(sql2);
				    System.out.println("sql2->"+sql2);
				} else { 
				    System.out.println("sql3->"+sql3);

					pstmt = conn.prepareStatement(sql3);
				}
				rs = pstmt.executeQuery();
				while(rs.next()) {
						Together recruit = new Together();
						recruit.setTitle(rs.getString("title"));
						recruit.setStartDate(rs.getString("startDate"));
						recruit.setEndDate(rs.getString("endDate"));
						recruit.setJoinPoint(rs.getInt("joinPoint"));
						recruit.setJoinPerson(rs.getInt("joinPerson"));
						recruit.setMaxPerson(rs.getInt("maxPerson"));
						recruit.setThumPath(rs.getString("thumPath"));
						recruit.setToNo(rs.getInt("toNo"));
						listSorting.add(recruit);
						
						System.out.println("dao title=>"+recruit.getTitle());
				}
		} catch(Exception e) { System.out.println(e.getMessage());
		} finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return listSorting;
	}*/
/*	public List<Together> InfoForRecruitList(int toNo) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM together WHERE toNo=?";	//board에서 총 row 개수
		int result = 0;
		try {
			List<Together> infoList = new ArrayList<Together>(); 
			conn = getConnection();
			pstmt = conn.prepareStatement(sql); 		//DB에 sql 송신위해 생성
			pstmt.setInt(1, toNo);
			rs = pstmt.executeQuery();
			System.out.println("toNo->"+toNo);
			while(rs.next()) {
				Together infoRecruit = new Together();
			}
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		finally {
			if(conn != null) conn.close();
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			
		}
		return result;
	}*/
}