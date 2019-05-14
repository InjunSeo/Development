package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Member;
import dto.Together;

public class JunDao {
	private static JunDao instance;
	private JunDao() {}
	
	public static JunDao getInstance() {
		if(instance== null)  instance = new JunDao();
		return instance;
	}
	
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	
	public Member select(String id) throws SQLException {
		ResultSet rs = null;
		Connection conn = null;
		PreparedStatement psmt = null;
		Member member = new Member();
		String sql = "SELECT NAME, POINT FROM MEMBER WHERE ID=?";
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				member.setName(rs.getString(1));
				member.setPoint(rs.getInt(2));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(conn!=null) conn.close();
		}
		return member;
	}
	
	public int update(String id, int charge) throws SQLException {
		int result = 0;
		Connection conn = null; 
		PreparedStatement psmt = null;
		String sql= "update MEMBER Set POINT=POINT+? WHERE ID=?";
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, charge);
			psmt.setString(2, id);
			result = psmt.executeUpdate();
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			if(psmt != null) psmt.close();
			if(conn != null) conn.close();
		}
		return result;
	}
	
	public ArrayList<Together> getMyIngTogetherList(String id) throws SQLException {
		ArrayList<Together> list = new ArrayList<Together>();
		System.out.println("[JunDao]getMyIngTogetherList");
		Connection conn = null; PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "Select a.* "
				+ " FROM together a, Join b "
				+ " WHERE a.status = 2 AND a.toNo = b.toNo " 
				   + " AND b.memberID = ? ORDER BY a.toNo DESC";

		System.out.println("[JunDao] getMyIngTogetherList [SQL] : " + sql);
		Together together = null;
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
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
		
				list.add(together);
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(conn != null) conn.close();
		}
		
		return list;
	}

	public ArrayList<Together> getMyFinishedTogetherList(String id) throws SQLException {
		ArrayList<Together> toList = new ArrayList<Together>();
		System.out.println("[JunDao.java] start");
		Connection conn = null; PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "Select a.* "
				+ " FROM together a, Join b "
				+ " WHERE a.status = 2 AND a.toNo = b.toNo " 
				   + " AND b.memberID = ? ORDER BY a.toNo DESC";

		System.out.println("[JunDao] getMyFinishedTogetherList [SQL]: " + sql);
		Together together = null;
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			while(rs.next()) {
				together = new Together();
				
				together.setToNo(rs.getInt("toNo"));
				together.setTitle(rs.getString("title"));
				together.setDescription(rs.getString("description"));
				together.setThumPath(rs.getString("thumPath"));
				together.setJoinPoint(rs.getInt("joinPoint"));

				together.setStartDate(rs.getString("startDate"));
				together.setEndDate(rs.getString("endDate"));

				together.setMinPerson(rs.getInt("minPerson"));
				together.setMaxPerson(rs.getInt("maxPerson"));
				together.setJoinPerson(rs.getInt("joinPerson"));
				together.setRemainPoint(rs.getInt("remainPoint"));
				together.setCreatorID(rs.getString("creatorID"));
				together.setCreateDate(rs.getString("createDate"));
				together.setStatus(rs.getInt("status"));
		
				toList.add(together);
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			if(rs != null) rs.close();
			if(ps != null) ps.close();
			if(conn != null) conn.close();
		}
		return toList;
	}

	public int insertCert(int toNo, String id, String fileName) throws SQLException {
		
		System.out.println("[JunDao.insertCert] start");
		Connection conn = null; PreparedStatement ps = null;
		String sql = "INSERT INTO Cert(toNO, memberID, createDate, filePath) Values(?, ?, To_char(sysdate, 'YYYYmmDD'), ?)";
		System.out.println("[JunDao] insertCert [SQL]: " + sql);
		int result = 0;
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setInt(1, toNo);
			ps.setString(2, id);
			ps.setString(3,  fileName);
			result = ps.executeUpdate();
			System.out.println("[JunDao][insertCert]sql실행 직후: " + result);
	
			if(result == 0) {
				// 이미 (오늘 날짜로) 인증을 했다면
				if (isAlreadyCert(toNo, id, fileName)) {
					result = -1;
				}
			}else {
				result = 1;
			}
		}catch( java.sql.SQLIntegrityConstraintViolationException e) {
			System.out.println("[SaintpDao.java] join() SQLIntegrityConstraintViolationException ");
			if (isAlreadyCert(toNo, id, fileName)) {
				result = -1;
			}
		
		}catch (Exception e) {
			System.out.println(e.getMessage());// TODO: handle exception
		}finally {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}
		return result;
	}

	private boolean isAlreadyCert(int toNo, String id, String fileName) {
		SaintpDao ohMyCap = SaintpDao.getInstance();
		return ohMyCap.checkExistence("SELECT * FROM Cert WHERE toNo = " + toNo + " AND memberID = '" + id + "' AND CREATEDATE = To_char(sysdate, 'YYYYmmDD')");
	}


	public int certCount(String id, int toNo) throws SQLException {
		System.out.println("[JunDao.certCount] start");
		Connection conn = null; PreparedStatement ps = null;
		ResultSet rs = null;
		int certCount = 0; 
		String sql = "SELECT count(*) \r\n" + 
				"FROM Cert\r\n" + 
				"WHERE memberid = ? AND tono = ?";
		System.out.println("[JunDao.certCount]SQL: " +sql);
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setInt(2,  toNo);
			rs = ps.executeQuery();
			while(rs.next()) {
				certCount = rs.getInt(1);				
			}
			
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}finally {
			if (ps != null) ps.close();
			if (conn != null) conn.close();
		}
		return certCount;
	}

	public Object[] myTogetherList(String id, String listSort) throws SQLException {
		System.out.println("[JunDao][myTogether] start");
		Object[] arrList = new Object[2];
		ArrayList<String> rateList = new ArrayList<String>();
		ArrayList<Together> toList = new ArrayList<Together>();
		
		Connection conn = null; PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "Select a.*,  "
				+ " ROUND((SELECT COUNT(*) FROM Cert WHERE toNo = a.toNo AND memberID = b.memberID)/(a.endDate - a.startDate + 1), 4)*100 rate "
				+ " FROM together a, Join b "
				+ " WHERE a.status = ? AND a.toNo = b.toNo " 
				+ " AND b.memberID = ? ORDER BY a.toNo DESC";
		String sql2 = "Select a.*\r\n" + 
				"FROM together a, Join b\r\n" + 
				"WHERE a.status = 1 AND a.toNo = b.toNo \r\n" + 
				"   AND b.memberID = ?\r\n" + 
				"ORDER BY a.toNo DESC"; 
		String sql3 = "SELECT *\r\n" + 
				"FROM Together\r\n" + 
				"WHERE creatorid = ?\r\n" + 
				"ORDER BY toNo DESC";
		System.out.println("[JunDao]myTogether [SQL2]: " +sql2);
		System.out.println("[JunDao]myTogether [SQL3]: " +sql3);
		Together together = null;

		if(listSort != "4") { //status=1,2,3
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql);
				ps.setString(1,  listSort); //listSort = 1,2,3
				ps.setString(2, id);
				rs = ps.executeQuery();
				while(rs.next()) {
					together = new Together();
					together.setToNo(rs.getInt("toNo"));
					together.setTitle(rs.getString("title"));
					together.setDescription(rs.getString("description"));
					together.setThumPath(rs.getString("thumPath"));
					together.setJoinPoint(rs.getInt("joinPoint"));
					together.setStartDate(rs.getString("startDate"));
					together.setEndDate(rs.getString("endDate"));
					together.setMinPerson(rs.getInt("minPerson"));
					together.setMaxPerson(rs.getInt("maxPerson"));
					together.setJoinPerson(rs.getInt("joinPerson"));
					together.setRemainPoint(rs.getInt("remainPoint"));
					together.setCreatorID(rs.getString("creatorID"));
					together.setCreateDate(rs.getString("createDate"));
					together.setStatus(rs.getInt("status"));					
					together.setToNo(rs.getInt("toNo"));
					
					toList.add(together);
					rateList.add( String.valueOf( rs.getDouble("rate")));
				}
				
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}finally {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn != null) conn.close();
			} 
		} else if (listSort.equals("4")) { 
			try {
				conn = getConnection();
				ps = conn.prepareStatement(sql3);				 
				ps.setString(1, id);
				rs = ps.executeQuery();
				while(rs.next()) {
					Together together1 = new Together();
					
					together1.setToNo(rs.getInt("toNo"));
					together1.setTitle(rs.getString("title"));
					together1.setDescription(rs.getString("description"));
					together1.setThumPath(rs.getString("thumPath"));
					together1.setJoinPoint(rs.getInt("joinPoint"));

					together1.setStartDate(rs.getString("startDate"));
					together1.setEndDate(rs.getString("endDate"));

					together1.setMinPerson(rs.getInt("minPerson"));
					together1.setMaxPerson(rs.getInt("maxPerson"));
					together1.setJoinPerson(rs.getInt("joinPerson"));
					together1.setRemainPoint(rs.getInt("remainPoint"));
					together1.setCreatorID(rs.getString("creatorID"));
					together1.setCreateDate(rs.getString("createDate"));
					together1.setStatus(rs.getInt("status"));					
					together1.setToNo(rs.getInt("toNo"));
					
					toList.add(together1);
				}
			}catch (Exception e) {
				System.out.println(e.getMessage());
			}finally {
				if(rs!=null) rs.close();
				if(ps!=null) ps.close();
				if(conn != null) conn.close();
			}
		} 
		arrList[0] = toList;
		arrList[1] = rateList;
		return arrList;
	}
	
}
