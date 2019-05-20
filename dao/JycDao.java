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
import javax.swing.plaf.synth.SynthSeparatorUI;

import dto.Reply;
import dto.Together;

public class JycDao {
	// 싱글 톤
	private static JycDao instance;

	private JycDao() {
	}

	public static JycDao getInstance() {
		if (instance == null) {
			instance = new JycDao();
		}
		return instance;
	}

	// DBCP
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}

	// 투게서 상세 정보 메소드
	public Together getTogetherInfo(int toNo) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from together where toNo=?";
		Together together = new Together();

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			System.out.println("Dao toNo=>" + toNo);
			pstmt.setInt(1, toNo);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				together.setToNo(rs.getInt("tono"));
				together.setTitle(rs.getString("title"));
				together.setDescription(rs.getString("description"));
				together.setThumPath(rs.getString("thumpath"));
				together.setJoinPoint(rs.getInt("joinpoint"));
				together.setStartDate(rs.getString("startdate"));
				together.setEndDate(rs.getString("enddate"));
				together.setMinPerson(rs.getInt("minperson"));
				together.setMaxPerson(rs.getInt("maxperson"));
				together.setJoinPerson(rs.getInt("joinperson"));
				together.setRemainPoint(rs.getInt("remainpoint"));
				together.setCreatorID(rs.getString("creatorid"));
				together.setCreateDate(rs.getString("createdate"));
				together.setStatus(rs.getInt("status"));

			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (conn != null)
				conn.close();
			if (pstmt != null)
				pstmt.close();
			if (rs != null)
				rs.close();

		}
		return together;
	}

	// 댓글 정보리스트 메소드
	public List<Reply> getReplyList(int toNo) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = " SELECT * FROM Reply WHERE toNo = ? ORDER BY seq DESC";

		List<Reply> replyList = new ArrayList<Reply>();

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, toNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Reply reply = new Reply();
				reply.setToNo(rs.getInt("toNo"));
				reply.setSeq(rs.getInt("seq"));
				reply.setReply(rs.getString("reply"));
				reply.setCreatorID(rs.getString("creatorId"));
				reply.setCreateDate(rs.getString("createDate"));
				replyList.add(reply);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (conn != null)
				conn.close();
			if (pstmt != null)
				pstmt.close();
			if (rs != null)
				rs.close();
		}
		return replyList;
	}

	// 댓글 작성 추가(insert)
	public int insertReply(Reply reply) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		System.out.println("insert Start..");
		String sql = "INSERT INTO Reply ( toNo, seq, reply, creatorID, createDate) "
				+ " VALUES (?, seqforpk.NEXTVAL, ?, ?, TO_CHAR(SYSDATE, 'YYYYMMDD'))";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, reply.getToNo());
			pstmt.setString(2, reply.getReply());
			pstmt.setString(3, reply.getCreatorID());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (conn != null)
				conn.close();
			if (pstmt != null)
				pstmt.close();
		}
		return result;
	}

	//댓글 삭제(delete)
	public int deleteReply(int toNo, int seq) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;
		System.out.println("Delete Start..");
		String sql = "delete from reply where toNo = ? AND seq= ?";
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);

			ps.setInt(1, toNo);
			ps.setInt(2, seq);

			result = ps.executeUpdate();
			if (result == 0) {
				// 투게더가 존재하지 않으면
				if (!SaintpDao.getInstance().existTogether(toNo)) {
					result = Together.NOT_EXIST;
				} else {
					// 댓글이 없으면...
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}

		return result;
	}
	
	//댓글 수정 (upate)
	public int updateReply(int seq, String reply) throws SQLException {
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;
		System.out.println("update Start..");
		String sql = "UPDATE reply SET reply = ? WHERE seq = ?";
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);

			ps.setString(1, reply);
			ps.setInt(2, seq);

			result = ps.executeUpdate();
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		return result;
	}
}
