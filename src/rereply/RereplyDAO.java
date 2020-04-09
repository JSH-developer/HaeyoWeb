package rereply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.DBCon;

public class RereplyDAO {
	
	private static RereplyDAO rrsingleton;
	private RereplyDAO() {}
	public static RereplyDAO getRereplyDAO() {
	 if(rrsingleton == null) {
        rrsingleton = new RereplyDAO();
	 }
	 return rrsingleton;
	}
	
	// 대댓글 갯수
	public int countRereply(String tb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		int cnt =0;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT COUNT(*) cnt FROM rereply_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);

		 	rs = pstmt.executeQuery();
		 	
		 	if(rs.next()) {
		 		cnt = rs.getInt("cnt");
		 	}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		
		return cnt;
	}
	
	
	//대댓글업데이트
	public void updateRereply(String tb, RereplyBean rrb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="UPDATE rereply_"+tb+" SET rr"+tb+"_content=?, mem_id=?, mem_nickname=? WHERE rr"+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1, rrb.getContent());
		 	pstmt.setString(2, rrb.getId());
		 	pstmt.setString(3, rrb.getNickname());
		 	pstmt.setInt(4, rrb.getIdx());

		 	pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}	

	// 대댓글 입력하기
	public void insertRereply(String tb, RereplyBean rrb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="INSERT INTO rereply_"+tb+"("+tb+"_idx, r"+tb+"_idx,rr"+tb+"_content,mem_id,mem_nickname) VALUES(?,?,?,?,?)";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, rrb.getBr_idx());
		 	pstmt.setInt(2, rrb.getRp_idx());
		 	pstmt.setString(3, rrb.getContent());
		 	pstmt.setString(4, rrb.getId());
		 	pstmt.setString(5, rrb.getNickname());
		 	
		 	pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		
	}
	
	// 대댓글 삭제하기
	public void deleteRereply(String tb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="DELETE FROM rereply_"+tb+" WHERE rr"+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);

		 	pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}	
	
	
	//대댓글 불러오기
	public List readRereply(String tb, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		List<RereplyBean> rrbs = new ArrayList<RereplyBean>();
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT * FROM rereply_"+tb+" WHERE r"+tb+"_idx=? ORDER BY rr"+tb+"_idx DESC";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	rs= pstmt.executeQuery();

		 	while(rs.next()) {
		 		RereplyBean rrb = new RereplyBean();
		 		rrb.setIdx(rs.getInt("rr"+tb+"_idx"));
		 		rrb.setContent(rs.getString("rr"+tb+"_content"));
		 		rrb.setId(rs.getString("mem_id"));
		 		rrb.setNickname(rs.getString("mem_nickname"));
		 		rrb.setRegtime(rs.getTimestamp("rr"+tb+"_regtime"));
		 		rrbs.add(rrb);
		 	}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		
		return rrbs;
	}


}
