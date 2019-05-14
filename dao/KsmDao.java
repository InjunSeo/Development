package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dto.Member;

public class KsmDao {
	private static KsmDao instance;
	private Connection conn 		= null;
	private PreparedStatement pstmt = null;

	
	private KsmDao() {}
	
	// Dao Instance의 생성 method
	public static KsmDao getInstance() {
		if ( instance == null ) {
			instance = new KsmDao();
		}
		return instance;
	}
	// Dao Instance의 연결 method
	public Connection getConnection() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}

	// 아이디와 비밀번호를 넣고 
	// 로그인이 가능하면 member인스턴스를 세션에 저장
	// 로그인이 가능하지 않으면 member에 null로 에 저장
	public Member login(String id, String password) throws SQLException {
		
		Member member			= new Member();
		String sql				= "SELECT * FROM member WHERE id = ? AND password = ?";
		ResultSet rs			= null;
		
		try {
			conn	= getConnection();
			pstmt 	= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs	 	= pstmt.executeQuery();

			if (rs.next()) {

				member.setCreateDate(rs.getString("createdate"));
				member.setEmail(rs.getString("email"));
				member.setID(rs.getString("id"));
				member.setName(rs.getString("name"));
				member.setPassword(rs.getString("password"));
				member.setPoint(rs.getInt("point"));
				member.setTel(rs.getString("tel"));
			} else {
				member = null;
			}
			System.out.println("[Memeber]"+member);
			System.out.println("[createdat]" + rs.getString("name"));
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (rs != null) rs.close();
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return member;
	}
	
	// 회원가입
	public int signup(Member member) throws SQLException {
		int result	= 0;
		String sql	= "INSERT INTO member(id, name, password, tel, email, point, createdate)"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?)";
		
		try {
			conn		= getConnection();
			pstmt		= conn.prepareStatement(sql);
			pstmt.setString(1, member.getID());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getPassword());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getEmail());
			pstmt.setInt(6, member.getPoint());
			pstmt.setString(7, member.getCreateDate());
			
			result = pstmt.executeUpdate();

			if (result == 0) {
				System.out.println("There's a problem with processing");
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		
		return result;
	}
	
	// 회원정보 수정
	public int updateMember(Member member, String updatePw) throws SQLException {
		int result = 0;
		String sql = "UPDATE member"
				+ " SET name = ?,"
				+ "password = ?,"
				+ "email = ?,"
				+ "tel = ?"
				+ " WHERE id = ?"
				+ " AND password = ?";
		
		try {
			conn 	= getConnection();
			pstmt 	= conn.prepareStatement(sql);
			pstmt.setString(1, member.getName());
			pstmt.setString(2, updatePw);
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getTel());
			pstmt.setString(5, member.getID());
			pstmt.setString(6, member.getPassword());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return result;
	}
	
	// 회원틸퇴
	public int closeMember(Member member) throws SQLException {
		int result = 0;
		String sql	= "DELETE member WHERE id = ? AND password = ?";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getID());
			pstmt.setString(2, member.getPassword());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		}
		return result;
	}
	
	// 아이디 중복조회 : result가 0이면 중복아이디, 1이면 중복아이디가 아님
	public boolean existID(String id) throws SQLException {
		
		boolean result = false;
		ResultSet rs = null;
		String sql	 = "SELECT * FROM Member WHERE id = ?";

		try {
			conn 	= getConnection();
			pstmt 	= conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs 		= pstmt.executeQuery();
			result = rs.next();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (pstmt != null) pstmt.close();
			if (conn != null)  conn.close();
			if (rs!= null) rs.close();
		}
			
		return result;
	}
	
}
