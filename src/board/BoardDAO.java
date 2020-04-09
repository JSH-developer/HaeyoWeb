package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import connection.DBCon;
import reply.ReplyDAO;
import rereply.RereplyDAO;

public class BoardDAO {
	
	private static BoardDAO bsingleton;
	private BoardDAO() {}
	public static BoardDAO getBoardDAO() {
	 if(bsingleton == null) {
        bsingleton = new BoardDAO();
	 }
	 return bsingleton;
	}
		
	// 게시글 추천수 카운트
	public int countBoardLike(String tb, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		int count=0;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT "+tb+"_recommend FROM board_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	
		 	rs = pstmt.executeQuery();
		 	if(rs.next()) {
		 		count=rs.getInt(tb+"_recommend");
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

	// 게시글 비추천수 카운트
	public int countBoardUnlike(String tb, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		int count=0;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT "+tb+"_oppose FROM board_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	
		 	rs = pstmt.executeQuery();
		 	if(rs.next()) {
		 		count=rs.getInt(tb+"_oppose");
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
		 	
		 	String sql="SELECT l"+tb+"_idx FROM like_"+tb+" WHERE mem_id=? AND "+tb+"_idx=?";
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
		 	
		 	String sql="UPDATE board_"+tb+" SET "+tb+"_recommend="+tb+"_recommend+1 WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,idx);
		 	pstmt.executeUpdate();
		 	pstmt.close();
		 	
		 	sql = "INSERT INTO like_"+tb+"(mem_id,"+tb+"_idx) VALUES(?,?) ";
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
		 	
		 	String sql="UPDATE board_"+tb+" SET "+tb+"_oppose="+tb+"_oppose+1 WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,idx);
		 	pstmt.executeUpdate();
		 	pstmt.close();
		 	
		 	sql = "INSERT INTO like_"+tb+"(mem_id,"+tb+"_idx) VALUES(?,?) ";
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
	
	// idx 갯수 세기
	public int countIdx(String tb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		int count=0;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT COUNT("+tb+"_idx) AS 'idx' FROM board_"+tb;
		 	pstmt = con.prepareStatement(sql);
		 	rs = pstmt.executeQuery();
		 	if(rs.next()) {
		 		count=rs.getInt("idx");
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
	
	// 카테고리 idx 갯수 세기
	public int countCategoryIdx(String tb,String category) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		int count=0;
		
		try {	
			con=DBCon.getConnection();
			
		 	String sql="";
		 	if(category.equals("베스트")) {
		 		sql="SELECT COUNT("+tb+"_idx) AS 'idx' FROM board_"+tb+" WHERE "+tb+"_recommend-"+tb+"_oppose>=50 ";
		 	}else {
		 		sql="SELECT COUNT("+tb+"_idx) AS 'idx' FROM board_"+tb+" WHERE "+tb+"_category='"+category+"'";
		 	}
		 	
		 	
		 	pstmt = con.prepareStatement(sql);
		 	rs = pstmt.executeQuery();
		 	if(rs.next()) {
		 		count=rs.getInt("idx");
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
	
	// 검색항목 idx 갯수 세기
	public int countsearchIdx(String tb,String standard,String scontent) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		String rowname="";
		
		int count=0;
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	if(standard.equals("opt_tt")) {
		 		rowname=tb+"_title";
		 	}else if(standard.equals("opt_nn")) {
		 		rowname="mem_nickname";
		 	}else if(standard.equals("opt_ct")) {
		 		rowname=tb+"_content";
		 	}
			
		 	String sql="SELECT COUNT("+tb+"_idx) AS 'idx' FROM board_"+tb+" WHERE "+ rowname +" LIKE '%"+scontent+"%'";
		 	
		 	pstmt = con.prepareStatement(sql);
		 	rs = pstmt.executeQuery();
		 	if(rs.next()) {
		 		count=rs.getInt("idx");
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
	
	
	//글읽기작업
	public String readContent(String tb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		String res="";
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT "+tb+"_category, " + tb + "_title, mem_id, mem_nickname, "+tb+"_rcount, "+tb+"_content FROM board_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	rs = pstmt.executeQuery();
		 	
		 	if(rs.next()) {
		 		res+=("<tr><td>"+rs.getString(tb+"_category")+"</td></tr><td>"+rs.getString(tb+"_title")+"</td></tr>\n"+"<tr><td>"+rs.getString("mem_nickname")+" | 조회수  "+rs.getInt(tb+"_rcount")+"<br><hr></td></tr>\n"+"<tr><td>"+rs.getString(tb+"_content")+"</td></tr>\n");
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
		return res;
		
	}
	
	//idx로 아이디 알아내기
	public String getIdFromIdx(String tb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		String id="";
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT mem_id FROM board_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	rs = pstmt.executeQuery();
		 	
		 	if(rs.next()) {
		 		id=rs.getString("mem_id");
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
		return id;
		
	}	
	
	
	//조회수카운트
	public void countRead(String tb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="UPDATE board_"+tb+" SET "+tb+"_rcount = (select * FROM (SELECT 1 + "+tb+"_rcount AS 'new_count' FROM board_"+tb+" WHERE "+tb+"_idx=?) as bft) WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	pstmt.setInt(2, idx);
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
	
	// 글 삭제 작업
	public void deleteContent(String tb, int idx){
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="DELETE FROM board_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,idx);
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
	
	// 글 수정 작업
	public void updateContent(String tb,BoardBean bb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="UPDATE board_"+tb+" SET "+tb+"_category=?, "+tb+"_title=?, mem_id=?, mem_nickname=?, "+tb+"_content=? WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1,bb.getCategory());
		 	pstmt.setString(2,bb.getTitle());
		 	pstmt.setString(3,bb.getId());
		 	pstmt.setString(4,bb.getNickname());
		 	pstmt.setString(5,bb.getContent());
		 	pstmt.setInt(6, idx);
		 	
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
	
	//내용 가져오기 작업
	public BoardBean getBean(String tb, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		BoardBean bb = new BoardBean();
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	String sql="SELECT * FROM board_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,idx);
		 	rs = pstmt.executeQuery();
		 	
		 	if(rs.next()) {
		 		bb.setCategory(rs.getString(tb+"_category"));
		 		bb.setTitle(rs.getString(tb+"_title"));
		 		bb.setContent(rs.getString(tb+"_content"));
		 		bb.setId(rs.getString("mem_id"));
		 		bb.setNickname(rs.getString("mem_nickname"));
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
		return bb;
	}
	
	
	//검색항목별 보기작업
	public String searchBoard(String tb,int bpage, String standard, String scontent) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		ReplyDAO rdao = ReplyDAO.getReplyDAO();
		RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
		int rcnt=0; // 댓글 갯수
		String rcnt_dis=" "; // 댓글수 표시
		String con_img=" "; // 이미지 포함 시
		SimpleDateFormat df_basic = new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat df_time = new SimpleDateFormat("HH:mm");
		Timestamp today = new Timestamp(System.currentTimeMillis()); //날짜비교 연산을 위한 오늘 날짜
		String ts = null;
		String res="";
		String rowname="";
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	if(standard.equals("opt_tt")) {
		 		rowname=tb+"_title";
		 	}else if(standard.equals("opt_nn")) {
		 		rowname="mem_nickname";
		 	}else if(standard.equals("opt_ct")) {
		 		rowname=tb+"_content";
		 	}
		 	
		 	int row = 20; // 원하는 출력 행 수
		 	int n = (bpage-1)*row; // 페이지에 따라 출력행 변동되기한 위한 수식 조건
		 	String sql="SELECT * FROM board_"+tb+" br JOIN(SELECT @rownum:=@rownum+1 as row, brf."+tb+"_idx FROM board_"+tb+" brf, (SELECT @rownum:=0) R WHERE "+rowname+" LIKE '%"+scontent+"%') rows ON (rows."+tb+"_idx = br."+tb+"_idx) ORDER BY br."+tb+"_idx DESC limit ?,?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,n);
		 	pstmt.setInt(2,row);
		 	rs = pstmt.executeQuery();
		 	
		 	// row개씩 읽기
		 	while(rs.next()) {
		 		//날짜 형식 바꾸기
		 		if(df_basic.format(today).equals( df_basic.format(rs.getTimestamp(tb+"_regtime"))) ) {
		 			ts=df_time.format(rs.getTimestamp(tb+"_regtime"));
		 		}else{
		 			ts=df_basic.format(rs.getTimestamp(tb+"_regtime"));
		 		}
		 		
		 		//댓글 갯수 구하기
		 		rcnt = rdao.countReply(tb,rs.getInt(tb+"_idx")) + rrdao.countRereply(tb,rs.getInt(tb+"_idx"));
		 		if(rcnt>0) {
		 			rcnt_dis = " ("+rcnt+") ";
		 		}else {
		 			rcnt_dis = " ";
		 		}
		 		
		 		//이미지 포함되어 있는지 표시
		 		if(rs.getString(tb+"_content").contains("<img src=")) {
		 			con_img = " <img src='../images/image.png' width='25 height='25'>";
		 		}else {
		 			con_img = " ";
		 		}
		 		
		 		//글번호, 글제목, 아이디, 조회수, 날짜
		 		res+=("<tr id='tr"+rs.getInt(tb+"_idx")+"'><td>"+rs.getInt("row") +"</td><td>"+
		 		rs.getString(tb+"_category")+"</td><td onclick=\"location.href='readSearchForm.jsp?page="+bpage+"&idx="+rs.getInt(tb+"_idx")+"&standard="+standard+"&scontent="+scontent+"'\">"+
		 		rs.getString(tb+"_title") + con_img + rcnt_dis
		 		+"</td><td>"+rs.getString("mem_nickname")+"</td><td>"+
		 		rs.getInt(tb+"_rcount")+"</td><td>"+ts+"</td></tr>\n");
		 		
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
		return res;
	}
	
	//카테고리별 보기작업
	public String categoryBoard(String tb,int bpage,String category) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		ReplyDAO rdao = ReplyDAO.getReplyDAO();
		RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
		int rcnt=0; // 댓글 갯수
		String rcnt_dis=" "; // 댓글수 표시
		String con_img=" "; // 이미지 포함 시
		SimpleDateFormat df_basic = new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat df_time = new SimpleDateFormat("HH:mm");
		Timestamp today = new Timestamp(System.currentTimeMillis()); //날짜비교 연산을 위한 오늘 날짜
		String ts = null;
		String res="";
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	int row = 20; // 원하는 출력 행 수
		 	int n = (bpage-1)*row; // 페이지에 따라 출력행 변동되기한 위한 수식 조건
		 	String sql="";
		 	if(category.equals("베스트")) {
		 		sql="SELECT * FROM board_"+tb+" br JOIN(SELECT @rownum:=@rownum+1 as row, brf."+tb+"_idx FROM board_"+tb+" brf, (SELECT @rownum:=0) R WHERE "+tb+"_recommend-"+tb+"_oppose>=50) rows ON (rows."+tb+"_idx = br."+tb+"_idx) ORDER BY br."+tb+"_idx DESC limit ?,?";
		 	}else {
		 		sql="SELECT * FROM board_"+tb+" br JOIN(SELECT @rownum:=@rownum+1 as row, brf."+tb+"_idx FROM board_"+tb+" brf, (SELECT @rownum:=0) R WHERE "+tb+"_category='"+category+"') rows ON (rows."+tb+"_idx = br."+tb+"_idx) ORDER BY br."+tb+"_idx DESC limit ?,?";
		 	}
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,n);
		 	pstmt.setInt(2,row);
		 	rs = pstmt.executeQuery();
		 	
		 	// row개씩 읽기
		 	while(rs.next()) {
		 		//날짜 형식 바꾸기
		 		if(df_basic.format(today).equals( df_basic.format(rs.getTimestamp(tb+"_regtime"))) ) {
		 			ts=df_time.format(rs.getTimestamp(tb+"_regtime"));
		 		}else{
		 			ts=df_basic.format(rs.getTimestamp(tb+"_regtime"));
		 		}
		 		
		 		//댓글 갯수 구하기
		 		rcnt = rdao.countReply(tb,rs.getInt(tb+"_idx")) + rrdao.countRereply(tb,rs.getInt(tb+"_idx"));
		 		if(rcnt>0) {
		 			rcnt_dis = " ("+rcnt+") ";
		 		}else {
		 			rcnt_dis = " ";
		 		}
		 		
		 		//이미지 포함되어 있는지 표시
		 		if(rs.getString(tb+"_content").contains("<img src=")) {
		 			con_img = " <img src='../images/image.png' width='25 height='25'>";
		 		}else {
		 			con_img = " ";
		 		}
		 		
		 		//글번호, 글제목, 아이디, 조회수, 날짜
		 		res+=("<tr id='tr"+( (category.equals("공지")) ? "nt":"")+rs.getInt(tb+"_idx")+"'><td>"+( (category.equals("공지")) ? "-":rs.getInt("row") ) +"</td><td>"+
		 		rs.getString(tb+"_category")+"</td><td onclick=\"location.href='readForm.jsp?page="+bpage+"&idx="+rs.getInt(tb+"_idx")+"&category="+category+"'\">"+
		 		rs.getString(tb+"_title") + con_img + rcnt_dis
		 		+"</td><td>"+rs.getString("mem_nickname")+"</td><td>"+
		 		rs.getInt(tb+"_rcount")+"</td><td>"+ts+"</td></tr>\n");
		 		
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
		return res;
		
	}
	
	// 메인 목록 만들기
	public String readMainBoard(String tb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		ReplyDAO rdao = ReplyDAO.getReplyDAO();
		RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
		int rcnt=0; // 댓글 갯수
		String rcnt_dis=" "; // 댓글수 표시
		String con_img=" "; // 이미지 포함 시
		SimpleDateFormat df_basic = new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat df_time = new SimpleDateFormat("HH:mm");
		Timestamp today = new Timestamp(System.currentTimeMillis()); //날짜비교 연산을 위한 오늘 날짜
		String ts = null;
		String res="";
		String title25="";
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	int row = 3; // 원하는 출력 행 수
		 	int n = (1-1)*row; // 페이지에 따라 출력행 변동되기한 위한 수식 조건
		 	String sql="SELECT * FROM board_"+tb+" br JOIN (SELECT @rownum:=@rownum+1 as row, brf."+tb+"_idx FROM board_"+tb+" brf, (SELECT @rownum:=0) R WHERE "+tb+"_category <> '공지') rows ON (rows."+tb+"_idx = br."+tb+"_idx) ORDER BY br."+tb+"_idx DESC limit ?,?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,n);
		 	pstmt.setInt(2,row);
		 	rs = pstmt.executeQuery();
		 	
		 	// row개씩 읽기
		 	while(rs.next()) {
		 		//날짜 형식 바꾸기
		 		if(df_basic.format(today).equals( df_basic.format(rs.getTimestamp(tb+"_regtime"))) ) {
		 			ts=df_time.format(rs.getTimestamp(tb+"_regtime"));
		 		}else{
		 			ts=df_basic.format(rs.getTimestamp(tb+"_regtime"));
		 		}
		 		
		 		//댓글 갯수 구하기
		 		rcnt = rdao.countReply(tb,rs.getInt(tb+"_idx")) + rrdao.countRereply(tb,rs.getInt(tb+"_idx"));
		 		if(rcnt>0) {
		 			rcnt_dis = " ("+rcnt+") ";
		 		}else {
		 			rcnt_dis = " ";
		 		}
		 		
		 		//이미지 포함되어 있는지 표시
		 		if(rs.getString(tb+"_content").contains("<img src=")) {
		 			con_img = " <img src='../images/image.png' width='25' height='25' style='vertical-align: bottom'> ";
		 		}else {
		 			con_img = " ";
		 		}
		 		
		 		//타이틀 길이 25자 제한
		 		if(rs.getString(tb+"_title").length()>25) {
		 			title25=rs.getString(tb+"_title").substring(0,24)+"...";
		 		}else {
		 			title25=rs.getString(tb+"_title");
		 		}
		 		
		 		//글번호, 글제목, 아이디, 조회수, 날짜
		 		res+=("<tr id='tr"+rs.getInt(tb+"_idx")+"'><td>"+rs.getInt("row") +"</td><td>"+
		 		rs.getString(tb+"_category")+"</td><td onclick=\"location.href='../board_"+tb+"/readForm.jsp?page=1&idx="+rs.getInt(tb+"_idx")+"'\">"+
		 		title25 + con_img + rcnt_dis
		 		+"</td><td>"+rs.getString("mem_nickname")+"</td><td>"+
		 		rs.getInt(tb+"_rcount")+"</td><td>"+ts+"</td></tr>\n");
		 		
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
		return res;
		
	}
	
	
	//목록보기작업
	public String readBoard(String tb,int bpage) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		ReplyDAO rdao = ReplyDAO.getReplyDAO();
		RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
		int rcnt=0; // 댓글 갯수
		String rcnt_dis=" "; // 댓글수 표시
		String con_img=" "; // 이미지 포함 시
		SimpleDateFormat df_basic = new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat df_time = new SimpleDateFormat("HH:mm");
		Timestamp today = new Timestamp(System.currentTimeMillis()); //날짜비교 연산을 위한 오늘 날짜
		String ts = null;
		String res="";
		String title25="";
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	int row = 20; // 원하는 출력 행 수
		 	int n = (bpage-1)*row; // 페이지에 따라 출력행 변동되기한 위한 수식 조건
		 	String sql="SELECT * FROM board_"+tb+" br JOIN (SELECT @rownum:=@rownum+1 as row, brf."+tb+"_idx FROM board_"+tb+" brf, (SELECT @rownum:=0) R WHERE "+tb+"_category <> '공지') rows ON (rows."+tb+"_idx = br."+tb+"_idx) ORDER BY br."+tb+"_idx DESC limit ?,?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,n);
		 	pstmt.setInt(2,row);
		 	rs = pstmt.executeQuery();
		 	
		 	// row개씩 읽기
		 	while(rs.next()) {
		 		//날짜 형식 바꾸기
		 		if(df_basic.format(today).equals( df_basic.format(rs.getTimestamp(tb+"_regtime"))) ) {
		 			ts=df_time.format(rs.getTimestamp(tb+"_regtime"));
		 		}else{
		 			ts=df_basic.format(rs.getTimestamp(tb+"_regtime"));
		 		}
		 		
		 		//댓글 갯수 구하기
		 		rcnt = rdao.countReply(tb,rs.getInt(tb+"_idx")) + rrdao.countRereply(tb,rs.getInt(tb+"_idx"));
		 		if(rcnt>0) {
		 			rcnt_dis = " ("+rcnt+") ";
		 		}else {
		 			rcnt_dis = " ";
		 		}
		 		
		 		//이미지 포함되어 있는지 표시
		 		if(rs.getString(tb+"_content").contains("<img src=")) {
		 			con_img = " <img src='../images/image.png' width='25' height='25' style='vertical-align: bottom'> ";
		 		}else {
		 			con_img = " ";
		 		}
		 		
		 		//타이틀 길이 25자 제한
		 		if(rs.getString(tb+"_title").length()>25) {
		 			title25=rs.getString(tb+"_title").substring(0,24)+"...";
		 		}else {
		 			title25=rs.getString(tb+"_title");
		 		}
		 		
		 		//글번호, 글제목, 아이디, 조회수, 날짜
		 		res+=("<tr id='tr"+rs.getInt(tb+"_idx")+"'><td>"+rs.getInt("row") +"</td><td>"+
		 		rs.getString(tb+"_category")+"</td><td onclick=\"location.href='readForm.jsp?page="+bpage+"&idx="+rs.getInt(tb+"_idx")+"'\">"+
		 		title25 + con_img + rcnt_dis
		 		+"</td><td>"+rs.getString("mem_nickname")+"</td><td>"+
		 		rs.getInt(tb+"_rcount")+"</td><td>"+ts+"</td></tr>\n");
		 		
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
		return res;
		
	}
	
	//글쓰기
	public void insertBoard(String tb,BoardBean bb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="INSERT INTO board_"+tb+"("+tb+"_category,"+tb+"_title,"+tb+"_content,"+tb+"_rcount,mem_id,mem_nickname) VALUES(?,?,?,?,?,?)";
			
		 	pstmt = con.prepareStatement(sql);
		 	
		 	pstmt.setString(1,bb.getCategory());
		 	pstmt.setString(2,bb.getTitle());
		 	pstmt.setString(3,bb.getContent());
		 	pstmt.setInt(4,bb.getRcount());
		 	pstmt.setString(5,bb.getId());
		 	pstmt.setString(6,bb.getNickname());
		 	
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
		
		return;
	}


}
