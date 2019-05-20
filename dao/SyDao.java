package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Join;
import dto.Together;

public class SyDao {
	private static SyDao instance;
	private SyDao() {}
	public static SyDao getInstance() {
		if (instance == null) {	instance = new SyDao();		}
		return instance;
	}
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)
				ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}catch(Exception e) { System.out.println("[SyDao.java]"+e.getMessage());}
		return conn;
	}

//내가 등록한 투게더 갯수 추출
	public int syTotEnroll(String id) throws SQLException {
		int syTot = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="SELECT COUNT(*) FROM together WHERE creatorId = ?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) syTot = rs.getInt(1);
		} catch (Exception e) {
			System.out.println("[SyDao_syTotEnroll.java]"+e.getMessage());
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		return syTot;
	}
	
// 투게더 리스트화면에 사용될 칼럼 추출
		public List<Together> enrollList(String id, int status) throws SQLException {
			List<Together> enrollList = new ArrayList<Together>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "SELECT * FROM together WHERE creatorID = ? AND status != 0  ORDER BY toNo DESC";
			String sql1 = "SELECT * FROM together WHERE creatorID = ? AND status = 1  ORDER BY toNo DESC";
			String sql2 = "SELECT * FROM together WHERE creatorID = ? AND status = 2  ORDER BY toNo DESC";
			String sql3 = "SELECT * FROM together WHERE creatorID = ? AND status = 3  ORDER BY toNo DESC";
			try {
				conn = getConnection();
				if (status == 1) {
					pstmt = conn.prepareStatement(sql1);
				} else if (status == 2) {
					pstmt = conn.prepareStatement(sql2);
				} else if (status == 3) {
					pstmt = conn.prepareStatement(sql3);
				} else {
					pstmt = conn.prepareStatement(sql);
				}
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while (rs.next()){
					Together together = new Together();
					together.setToNo(rs.getInt("toNo"));
					together.setTitle(rs.getString("title"));
					together.setThumPath(rs.getString("thumPath"));
					together.setJoinPoint(rs.getInt("joinPoint"));
					together.setMinPerson(rs.getInt("minPerson"));
					together.setMaxPerson(rs.getInt("maxPerson"));
					together.setJoinPerson(rs.getInt("joinPerson"));
					together.setStartDate(rs.getString("startDate"));
					together.setEndDate(rs.getString("endDate"));
					together.setCreatorID(rs.getString("creatorID"));
					together.setCreateDate(rs.getString("createDate"));
					together.setStatus(rs.getInt("status"));
					enrollList.add(together);
				}
			}catch (Exception e) {
				System.out.println("[SyDao_enrollList.java]"+e.getMessage());
			} finally {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			}
			return enrollList;
		}
	
//투게더등록 + 생성자 자동참여 
	public int Insert(Together together, Join join,String id) throws SQLException {
		int result = 0;
		int toNumber =0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql_seq = "SELECT seqforpk.nextval FROM dual";
		String sql_together = "INSERT INTO together (toNo,title,description,thumPath,joinPoint,startDate,"
							+ "endDate,minPerson,maxPerson,joinPerson,remainPoint,creatorID,createDate,status) "
							+ "VALUES (?,?,?,?,?,?,?,?,?,0,0,?,TO_CHAR(SYSDATE, 'YYYYMMDD'),1)";
		String sql_join = "INSERT INTO join (toNo,memberID,joinDate,rewardPoint) VALUES(?,?,TO_CHAR(SYSDATE, 'YYYYMMDD'),0)";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql_seq);
			rs = pstmt.executeQuery();
			
			if (rs.next()) { toNumber = rs.getInt(1); }
			rs.close(); pstmt.close();
			
			pstmt = conn.prepareStatement(sql_together);	
			pstmt.setInt(1,toNumber);
			pstmt.setString(2,together.getTitle());
			pstmt.setString(3, together.getDescription());
			pstmt.setString(4, together.getThumPath());
			pstmt.setInt(5, together.getJoinPoint());
			pstmt.setString(6, together.getStartDate());
			pstmt.setString(7, together.getEndDate());
			pstmt.setInt(8, together.getMinPerson());
			pstmt.setInt(9, together.getMaxPerson());
			pstmt.setString(10, together.getCreatorID());
			result = pstmt.executeUpdate();
			
			System.out.println("[SyDao_tInsert.java] 투게더 생성 확인 result = : "+ result);
			
			if (result > 0 ) {
				pstmt.close();
				pstmt = conn.prepareStatement(sql_join);
				pstmt.setInt(1, toNumber);
				pstmt.setString(2, id);
				result = pstmt.executeUpdate();
				System.out.println("[SyDao_tInsert.java] 생성자 참여 확인 result = "+ result);
			} else result = 0;
		} catch (Exception e) {
			System.out.println("[SyDao_tInsert.java]"+e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn != null) pstmt.close();
		}
		return result;
	}
	
//투게더가 생성될때 생성자의 포인트차감
	public int pointUpdate(String id, int joinPoint) throws SQLException {
		int updateResult = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "UPDATE member SET point = point - ? WHERE id = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, joinPoint);
			pstmt.setString(2, id);
			updateResult = pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("[SyDao_createPoint.java]"+e.getMessage());
		}finally {
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		return updateResult;
	}
	
	//생성자가 자동 참여될때 joinPerson +, joinPoint +	
	public int joinUpdate(int joinPoint) throws SQLException {
		int joinUResult = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql ="UPDATE together SET joinPerson = joinPerson + 1, remainPoint = remainPoint + joinPoint";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			joinUResult = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("[SyDao_joinUpdate] : "+e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return joinUResult;
	}

//투게더 수정할 정보 받아오기
	public Together toModify(int toNo) throws SQLException {
		Together together = new Together();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT toNo, title, thumPath, minPerson, maxPerson, startDate, endDate, joinPoint, description FROM together WHERE toNo = ?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, toNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				together.setToNo(rs.getInt("toNo"));
				together.setTitle(rs.getString("title"));
				together.setThumPath(rs.getString("thumPath"));
				together.setMinPerson(rs.getInt("minPerson"));
				together.setMaxPerson(rs.getInt("maxPerson"));
				together.setStartDate(rs.getString("startDate"));
				together.setEndDate(rs.getString("endDate"));
				together.setJoinPoint(rs.getInt("joinPoint"));
				together.setDescription(rs.getString("description"));
			}
		} catch (Exception e) {
			System.out.println("[SyDao_modifyList.java]"+e.getMessage());
		} finally {
			if( rs != null) rs.close();
			if( pstmt != null) pstmt.close();
			if( conn != null) conn.close();
		}	
		return together;
	}
	
	// 투게더 수정
	public int toUpdate(Together together, String id) throws SQLException {
		int modResult = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql ="UPDATE together SET title = ?, thumPath = ?, description = ?, minPerson = ?, maxPerson = ? WHERE toNo = ? AND creatorID = ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, together.getTitle());
			pstmt.setString(2, together.getThumPath());
			pstmt.setString(3, together.getDescription());
			pstmt.setInt(4, together.getMinPerson());
			pstmt.setInt(5, together.getMaxPerson());
			pstmt.setInt(6, together.getToNo());
			pstmt.setString(7, id);
			modResult = pstmt.executeUpdate();
			System.out.println("[SyDao_toUpdate] toNo: " + together.getToNo());
			System.out.println("[SyDao_toUpdate] title: " + together.getTitle());
			System.out.println("[SyDao_toUpdate] thumPath: " + together.getThumPath());
			System.out.println("[SyDao_toUpdate] minPerson: " + together.getMinPerson());
			System.out.println("[SyDao_toUpdate] maxPerson: " + together.getMinPerson());
			System.out.println("[SyDao_toUpdate] modResult: " + modResult);
		} catch (Exception e) {
			System.out.println("[SyDao_toUpdate] : "+e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return modResult;
	}
	
// 투게더 삭제
	public int toDelete(int toNo, String id) throws SQLException {
		int result = 0;
		int joinP = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		/*String sql = "UPDATE together SET status = 0, joinPerson = 0, remainPoint = 0 WHERE toNo = ? AND creatorID = ?";*/
		String sql = "DELETE FROM together WHERE toNo = ? AND creatorID = ?";
		String sqlPoint ="SELECT joinPoint From together WHERE toNo=?";
		String sqlpointUp = "UPDATE member SET point = point + ? WHERE id = (SELECT memberID FROM Join WHERE toNo =?)";
		String sqlJoinRemove = "DELETE FROM join WHERE toNo = ?";
		
		try {

			conn = getConnection();
			
			// 참가자들에게 돌려줄 포인트 구하기
			pstmt = conn.prepareStatement(sqlPoint);
			pstmt.setInt(1, toNo);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				joinP = rs.getInt(1); 
			}
			else {
				joinP = 0;
			}
			System.out.println("[SyDao_toDelete.java] joinPoint = "+joinP);
			rs.close();
			pstmt.close();
			
			// 참가자들에게 포인트 돌려주기
			pstmt = conn.prepareStatement(sqlpointUp);
			pstmt.setInt(1, joinP);
			pstmt.setInt(2, toNo);
			result = pstmt.executeUpdate();
			System.out.println("[SyDao_toDelete.java] 포인트 돌려준거 없으면 0 = "+result);
			
			// 삭제된 투게더 참가자 딜리트하기
			if(result > 0) {
				pstmt.close();
				result = 0;
				pstmt = conn.prepareStatement(sqlJoinRemove);
				pstmt.setInt(1, toNo);
				result = pstmt.executeUpdate();
				System.out.println("[SyDao_toDelete.java] 참가자 삭제 안됐으면 0 = "+result);
				if(result > 0) {	
					pstmt.close();
					result = 0;
					// 투게더 삭제처리
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, toNo);
					pstmt.setString(2, id);
					result = pstmt.executeUpdate();
					pstmt.close();
					System.out.println("[SyDao_toDelete.java] 투게더 삭제 안됐으면 0 = "+result);
				} else result = 0;
			} else result = 0;
			
	
		}catch (Exception e) {
			System.out.println("[SyDao_toDelete.java]"+e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}				
		return result;
	}
}


