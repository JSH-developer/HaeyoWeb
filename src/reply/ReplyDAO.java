package reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.DBCon;

public class ReplyDAO {

	private static ReplyDAO rsingleton;
	private ReplyDAO() {}
	public static ReplyDAO getReplyDAO() {
	 if(rsingleton == null) {
        rsingleton = new ReplyDAO();
	 }
	 return rsingleton;
	}
	
	// 댓글 추천수 카운트
	public int countReplyLike(String tb, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		int count=0;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT r"+tb+"_recommend FROM reply_"+tb+" WHERE r"+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	
		 	rs = pstmt.executeQuery();
		 	if(rs.next()) {
		 		count=rs.getInt("r"+tb+"_recommend");
		 	}
		 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return count;
	}

	// 댓글 비추천수 카운트
	public int countReplyUnlike(String tb, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		int count=0;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT r"+tb+"_oppose FROM reply_"+tb+" WHERE r"+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	
		 	rs = pstmt.executeQuery();
		 	if(rs.next()) {
		 		count=rs.getInt("r"+tb+"_oppose");
		 	}
		 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return count;
	}
	
	// 추천할수 있는 아이디인지 판별
	public boolean isLike(String tb, String id, int idx ) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		boolean is_like = true; // 좋아요 가능함
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	String sql="SELECT rl"+tb+"_idx FROM rlike_"+tb+" WHERE mem_id=? AND r"+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1,id);
		 	pstmt.setInt(2,idx);
		 	rs = pstmt.executeQuery();
		 	
		 	if(rs.next()) {
		 		is_like = false; // 불가능함
		 	}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
		return is_like;
	}	
	
	
	// 추천하고 데이터베이스에 넣기
	public void likeUp(String tb, String id, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	String sql="UPDATE reply_"+tb+" SET r"+tb+"_recommend=r"+tb+"_recommend+1 WHERE r"+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,idx);
		 	pstmt.executeUpdate();
		 	pstmt.close();
		 	
		 	sql = "INSERT INTO rlike_"+tb+"(mem_id, r"+tb+"_idx) VALUES(?,?) ";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1,id);
		 	pstmt.setInt(2,idx);
		 	pstmt.executeUpdate();
		 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}	
	
	
	// 비추천하기
	public void likeDown(String tb, String id, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	String sql="UPDATE reply_"+tb+" SET r"+tb+"_oppose=r"+tb+"_oppose+1 WHERE r"+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,idx);
		 	pstmt.executeUpdate();
		 	pstmt.close();
		 	
		 	sql = "INSERT INTO rlike_"+tb+"(mem_id, r"+tb+"_idx) VALUES(?,?) ";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1,id);
		 	pstmt.setInt(2,idx);
		 	pstmt.executeUpdate();
		 	
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				System.out.println(e.getMessage());
			}
		}
	}	
	
	// 댓글 갯수
	public int countReply(String tb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		int cnt =0;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT COUNT(*) cnt FROM reply_"+tb+" WHERE "+tb+"_idx=?";
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
	
	
	// 댓글 삭제하기
	public void deleteReply(String tb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="DELETE FROM reply_"+tb+" WHERE r"+tb+"_idx=?";
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
	
	//댓글업데이트
	public void updateReply(String tb, ReplyBean rb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="UPDATE reply_"+tb+" SET r"+tb+"_content=?, mem_id=?, mem_nickname=? WHERE r"+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1, rb.getContent());
		 	pstmt.setString(2, rb.getId());
		 	pstmt.setString(3, rb.getNickname());
		 	pstmt.setInt(4, rb.getIdx());

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
	
	//댓글 불러오기
	public List readReply(String tb, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		List<ReplyBean> rbs = new ArrayList<ReplyBean>();
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT * FROM reply_"+tb+" WHERE "+tb+"_idx=? ORDER BY r"+tb+"_recommend ASC, r"+tb+"_idx DESC";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	rs= pstmt.executeQuery();

		 	while(rs.next()) {
		 		ReplyBean rb = new ReplyBean();
		 		rb.setIdx(rs.getInt("r"+tb+"_idx"));
		 		rb.setContent(rs.getString("r"+tb+"_content"));
		 		rb.setId(rs.getString("mem_id"));
		 		rb.setNickname(rs.getString("mem_nickname"));
		 		rb.setRegtime(rs.getTimestamp("r"+tb+"_regtime"));
		 		rbs.add(rb);
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
		
		return rbs;
	}
	
	//댓글쓰기
	public void insertReply(String tb, ReplyBean rb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="INSERT INTO reply_"+tb+"("+tb+"_idx, r"+tb+"_content, mem_id, mem_nickname) VALUES(?,?,?,?)";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, rb.getBr_idx());
		 	pstmt.setString(2, rb.getContent());
		 	pstmt.setString(3, rb.getId());
		 	pstmt.setString(4, rb.getNickname());
		 	
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
	
	
}
