package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Join;
import dto.Together;

public class YnvlyDao {
	private static YnvlyDao instance;
	
	private YnvlyDao() {}
	
	public static YnvlyDao getInstance() {
		if(instance==null) {
			instance = new YnvlyDao();
		}
		return instance;
	}
	
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	
	/**
	 * 상태가 종료(togrther.status=3)인 Together 목록을 가져오는 method.
	 * getGrossPoint()는 값을 따로 받아오지 않고 joinPoint*joinPerson를 return한다.
	 * 
	 * @return getFinList
	 * --> together객체에 저장한 투게더 정보를 getFinList에 담아 List형태로 return한다.
	 * @throws SQLException 
	 */
	public List<Together> getFinList() throws SQLException {
		List<Together> setFinList = new ArrayList<Together>();
		Connection conn = null;
		/*String sql = "SELECT a.tono, a.title, (SELECT MAX(rewardpoint)FROM join j WHERE memberID = a.creatorID) maxRP FROM together a\r\n" + 
				"ORDER BY a.ToNo";*/
		/*String sql = "SELECT toNo,title,description,thumPath,joinPoint,joinPerson FROM Together WHERE status=3";*/
		String sql = "SELECT (SELECT MAX(rewardpoint) FROM join j " + 
				     "WHERE memberID = a.creatorID) maxRwdPnt, a.* " + 
				     "FROM together a WHERE a.status = 3 " +
				     "ORDER BY a.ToNo";
		
		Statement stmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				Together together = new Together();
				together.setToNo(rs.getInt("toNo"));
				together.setTitle(rs.getString("title"));
				together.setDescription(rs.getString("description"));
				together.setThumPath(rs.getString("thumPath"));
				together.setJoinPoint(rs.getInt("joinPoint"));
				together.setJoinPerson(rs.getInt("joinPerson"));
				together.setEndDate(rs.getString("endDate"));
				together.setMaxRewardPoint(rs.getInt("maxRwdPnt"));
				together.getGrossPoint();
				setFinList.add(together);
			}
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		finally {
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (conn != null)
				conn.close();
		}
		return setFinList;
	}
	
	public List<Join> getEachRwdList(int toNo) throws SQLException {
		List<Join> setEachRwd = new ArrayList<Join>();
		Connection conn = null;
		String sql = "SELECT memberID, rewardPoint FROM Join WHERE toNo= ?";
		
		System.out.println( "[YnvlyDao.java] getEachRwdList() sql = " + sql + ", toNo " + toNo);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, toNo);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Join join = new Join();
				join.setMemberID(rs.getString("memberID"));
				join.setRewardPoint(rs.getInt("rewardPoint"));
				setEachRwd.add(join);
			}
		} 
		catch (Exception e) {
			System.out.println(e.getMessage());
		}
		finally {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
			
		}
		return setEachRwd;
	}
	
	
}
