package dao;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

import dto.Join;
import dto.Together;

	public class MhDao {
	private static MhDao instance;
	private MhDao() {}
	public static MhDao getInstance() {
		if (instance == null) { instance = new MhDao(); }
		return instance;
	}

	private Connection getConnection() {
		Connection conn = null;
		try { 
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)
					ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) { System.out.println(e.getMessage()); }  
		
		return conn;
	}
	
	public List<Together> getIngList(String ingListSort) throws SQLException {
		List<Together> getIngList = new ArrayList<Together>();
		Connection conn = null;
		
/*		oraDB에 함수를 등록했었다. 근데 그건 운영차원에서 비효율적이라 sql 구문으로 대체 .
		String sql1 = "SELECT * FROM Together WHERE STATUS=2 " 
		            + "ORDER BY progressRate(startDate , EndDate) DESC" ;
		-.sql1은 진행율 기준 내림차수 정렬
		-.sql2는 참여(인원)율 기준 내림차수 정렬
*/		            
		String sql1 = "SELECT (sysdate - to_date(startDate)) /(to_date(endDate) - to_date(startDate) + 1) Rate, a.* "
					+ "FROM Together a WHERE STATUS=2 ORDER BY Rate DESC";
		String sql2 = "SELECT * FROM Together WHERE STATUS=2  AND joinperson IS NOT NULL ORDER BY joinperson DESC" ;
		PreparedStatement pstmt = null;
		System.out.println("[MhDao.java] oraDB.ingListSort sql1->"+sql1);
		ResultSet rs = null;
		try { conn = getConnection();
		      if (ingListSort.equals("1")) {     //ingListAction에 ingListSort 정의
		    	  pstmt = conn.prepareStatement(sql1);
		  		  System.out.println("[MhDao.java] ingListSort.equals(1) ");  		  

		      } else {	    	  
		    	  pstmt = conn.prepareStatement(sql2);
		      }
			  rs = pstmt.executeQuery();
			  while(rs.next()) {
		  		  System.out.println("[MhDao.java] getIngList while ");
		  		  System.out.println("[MhDao.java] getIngList title "+rs.getString("title"));
			      Together together = new Together();
				  together.setToNo(rs.getInt("toNo"));
				  together.setTitle(rs.getString("title"));
				  together.setDescription(rs.getString("description"));
				  together.setThumPath(rs.getString("thumPath"));
				  together.setStartDate(rs.getString("startDate"));
				  together.setEndDate(rs.getString("endDate"));
				  together.setJoinPerson(rs.getInt("joinPerson"));
				  together.setRemainPoint(rs.getInt("remainPoint"));
				  getIngList.add(together);				  
			  }
		} catch (Exception e) {
			System.out.println(e.getMessage());;
		} finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return getIngList;
	}
	public List<Join> getIngRwdList(int toNo) throws SQLException {
		List<Join> ingRwdList = new ArrayList<Join>();
		Connection conn = null;
		String sql = "SELECT memberID, rewardPoint FROM Join WHERE toNo= ?";
		
		System.out.println( "[MhDao.java] getIngRwdList() sql = " + sql + ", toNo " + toNo);
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
				ingRwdList.add(join);
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
		return ingRwdList;
	}
}
