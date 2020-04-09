package fileboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import connection.DBCon;
import reply.ReplyDAO;
import rereply.RereplyDAO;

public class FileboardDAO {
	
	private static FileboardDAO fbsingleton;
	private FileboardDAO() {}
	public static FileboardDAO getFileboardDAO() {
	 if(fbsingleton == null) {
        fbsingleton = new FileboardDAO();
	 }
	 return fbsingleton;
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
	
	//검색항목별 자료실 보기작업
	public String searchdatBoard(int bpage, String standard, String scontent) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		ReplyDAO rdao = ReplyDAO.getReplyDAO();
		RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
		int rcnt=0; // 댓글 갯수
		String rcnt_dis=" "; // 댓글수 표시
		String con_img= " <img src='../images/file.png' width='25 height='25'>"; // 이미지 포함 시
		SimpleDateFormat df_basic = new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat df_time = new SimpleDateFormat("HH:mm");
		Timestamp today = new Timestamp(System.currentTimeMillis()); //날짜비교 연산을 위한 오늘 날짜
		String ts = null;
		String res="";
		String rowname="";
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	if(standard.equals("opt_tt")) {
		 		rowname="dat_title";
		 	}else if(standard.equals("opt_nn")) {
		 		rowname="mem_nickname";
		 	}else if(standard.equals("opt_ct")) {
		 		rowname="dat_content";
		 	}
		 	
		 	int row = 20; // 원하는 출력 행 수
		 	int n = (bpage-1)*row; // 페이지에 따라 출력행 변동되기한 위한 수식 조건
		 	String sql="SELECT * FROM board_dat br JOIN(SELECT @rownum:=@rownum+1 as row, brf.dat_idx FROM board_dat brf, (SELECT @rownum:=0) R WHERE "+rowname+" LIKE '%"+scontent+"%') rows ON (rows.dat_idx = br.dat_idx) ORDER BY br.dat_idx DESC limit ?,?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,n);
		 	pstmt.setInt(2,row);
		 	rs = pstmt.executeQuery();
		 	
		 	// row개씩 읽기
		 	while(rs.next()) {
		 		//날짜 형식 바꾸기
		 		if(df_basic.format(today).equals( df_basic.format(rs.getTimestamp("dat_regtime"))) ) {
		 			ts=df_time.format(rs.getTimestamp("dat_regtime"));
		 		}else{
		 			ts=df_basic.format(rs.getTimestamp("dat_regtime"));
		 		}
		 		
		 		//댓글 갯수 구하기
		 		rcnt = rdao.countReply("dat",rs.getInt("dat_idx")) + rrdao.countRereply("dat",rs.getInt("dat_idx"));
		 		if(rcnt>0) {
		 			rcnt_dis = " ("+rcnt+") ";
		 		}else {
		 			rcnt_dis = " ";
		 		}
		 		
		 		//글번호, 글제목, 아이디, 조회수, 날짜
		 		res+=("<tr id='tr"+rs.getInt("dat_idx")+"'><td>"+rs.getInt("row") +"</td><td>"+
		 		rs.getString("dat_category")+"</td><td onclick=\"location.href='readSearchForm.jsp?page="+bpage+"&idx="+rs.getInt("dat_idx")+"&standard="+standard+"&scontent="+scontent+"'\">"+
		 		rs.getString("dat_title") + con_img + rcnt_dis
		 		+"</td><td>"+rs.getString("mem_nickname")+"</td><td>"+
		 		rs.getInt("dat_rcount")+"</td><td>"+ts+"</td></tr>\n");
		 		
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
	
	//검색항목별 갤러리 보기작업
	public String searchgalBoard(int bpage, String standard, String scontent) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		ReplyDAO rdao = ReplyDAO.getReplyDAO();
		RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
		int rcnt=0; // 댓글 갯수
		String rcnt_dis=" "; // 댓글수 표시
		SimpleDateFormat df_basic = new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat df_time = new SimpleDateFormat("HH:mm");
		Timestamp today = new Timestamp(System.currentTimeMillis()); //날짜비교 연산을 위한 오늘 날짜
		String ts = null;
		String res="";
		String rowname="";
		String title10="";
		String imgpath="";
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	if(standard.equals("opt_tt")) {
		 		rowname="gal_title";
		 	}else if(standard.equals("opt_nn")) {
		 		rowname="mem_nickname";
		 	}else if(standard.equals("opt_ct")) {
		 		rowname="gal_content";
		 	}
		 	
		 	int row = 20; // 원하는 출력 행 수
		 	int n = (bpage-1)*row; // 페이지에 따라 출력행 변동되기한 위한 수식 조건
		 	String sql="SELECT * FROM board_gal WHERE "+rowname+" LIKE '%"+scontent+"%' limit ?,?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,n);
		 	pstmt.setInt(2,row);
		 	rs = pstmt.executeQuery();
		 	
		 	// row개씩 읽기
		 	while(rs.next()) {
		 		//날짜 형식 바꾸기
		 		if(df_basic.format(today).equals( df_basic.format(rs.getTimestamp("gal_regtime"))) ) {
		 			ts=df_time.format(rs.getTimestamp("gal_regtime"));
		 		}else{
		 			ts=df_basic.format(rs.getTimestamp("gal_regtime"));
		 		}
		 		
		 		//댓글 갯수 구하기
		 		rcnt = rdao.countReply("gal",rs.getInt("gal_idx")) + rrdao.countRereply("gal",rs.getInt("gal_idx"));
		 		if(rcnt>0) {
		 			rcnt_dis = " ("+rcnt+") ";
		 		}else {
		 			rcnt_dis = " ";
		 		}
		 		
		 		//타이틀 길이 10자 제한
		 		if(rs.getString("gal_title").length()>10) {
		 			title10=rs.getString("gal_title").substring(0,9)+"...";
		 		}else {
		 			title10=rs.getString("gal_title");
		 		}
		 		
		 		imgpath = "<img onclick=\"location.href='readSearchForm.jsp?page="+bpage+"&idx="+rs.getInt("gal_idx")+"&standard="+standard+"&scontent="+scontent+"'\" src='"+"../upload/thumb_"+rs.getString("gal_file")+"' width='245' height='245' />";
		 		
		 		//글번호, 글제목, 아이디, 조회수, 날짜
		 		res+=("<div id='gal"+rs.getInt("gal_idx")+"'>"+imgpath+"<br>"+
		 		rs.getString("gal_category")+"<br>"+
		 		"<a class='title' href='readSearchForm.jsp?page="+bpage+"&idx="+rs.getInt("gal_idx")+"&standard="+standard+"&scontent="+scontent+"'>" + title10+ "</a>" +rcnt_dis+"<br>"+
		 		"<span class='nickname'>" + rs.getString("mem_nickname")+"</span><span class='regdate'>"+ts+"</span></div>");
		 		
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
	
	//글읽기작업
	public String readContent(String tb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		String filepath="";
		String res="";
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT "+tb+"_category, " + tb + "_title, mem_id, mem_nickname, "+tb+"_rcount, "+tb+"_content, "+tb+"_file FROM board_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	rs = pstmt.executeQuery();
		 	
		 	if(rs.next()) {
		 		if(tb.equals("gal")) {
		 			filepath = "<img  src='"+"../upload/"+rs.getString("gal_file")+"' />";
		 		}else if(tb.equals("dat")) {
		 			filepath="<span class='download_box'><span class='filename'>"+rs.getString("dat_file")+"</span>&nbsp;<a href='download.jsp?file="+rs.getString("dat_file")+"' class='download'><img src='../images/download.png' width='20' height='20'></a></span>";
		 		}
		 		res+=("<tr><td>"+rs.getString(tb+"_category")+"</td></tr><td>"+rs.getString(tb+"_title")+"</td></tr>\n"+"<tr><td>"+rs.getString("mem_nickname")+" | 조회수 "+rs.getInt(tb+"_rcount")+"<hr></td></tr>"+"<tr><td>" + filepath + "<br>" +rs.getString(tb+"_content")+"</td></tr>\n");
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
	
	//idx로 첨부파일 알아내기
	public String getFileFromIdx(String tb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		String file="";
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="SELECT "+tb+"_file FROM board_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1, idx);
		 	rs = pstmt.executeQuery();
		 	
		 	if(rs.next()) {
		 		file=rs.getString(tb+"_file");
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
		return file;
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
	public void updateContent(String tb,FileboardBean fb,int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="UPDATE board_"+tb+" SET "+tb+"_category=?, "+tb+"_title=?, mem_id=?, mem_nickname=?, "+tb+"_content=?, "+tb+"_file=? WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1,fb.getCategory());
		 	pstmt.setString(2,fb.getTitle());
		 	pstmt.setString(3,fb.getId());
		 	pstmt.setString(4,fb.getNickname());
		 	pstmt.setString(5,fb.getContent());
		 	pstmt.setString(6,fb.getFile());
		 	pstmt.setInt(7, idx);
		 	
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
	public FileboardBean getBean(String tb, int idx) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		
		FileboardBean fb = new FileboardBean();
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	String sql="SELECT * FROM board_"+tb+" WHERE "+tb+"_idx=?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,idx);
		 	rs = pstmt.executeQuery();
		 	
		 	if(rs.next()) {
		 		fb.setCategory(rs.getString(tb+"_category"));
		 		fb.setTitle(rs.getString(tb+"_title"));
		 		fb.setContent(rs.getString(tb+"_content"));
		 		fb.setFile(rs.getString(tb+"_file"));
		 		fb.setId(rs.getString("mem_id"));
		 		fb.setNickname(rs.getString("mem_nickname"));
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
		return fb;
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
			
		 	String sql="SELECT COUNT("+tb+"_idx) AS 'idx' FROM board_"+tb+" WHERE "+tb+"_category='"+category+"'";
		 	
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
	
	//카테고리별목록보기작업
	public String categorygalBoard(int bpage,String category) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		ReplyDAO rdao = ReplyDAO.getReplyDAO();
		RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
		int rcnt=0; // 댓글 갯수
		String rcnt_dis=" "; // 댓글수 표시
		String imgpath = "";
		SimpleDateFormat df_basic = new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat df_time = new SimpleDateFormat("HH:mm");
		Timestamp today = new Timestamp(System.currentTimeMillis()); //날짜비교 연산을 위한 오늘 날짜
		String ts = null;
		String res="";
		String title10="";
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	int row = 20; // 원하는 출력 행 수
		 	int n = (bpage-1)*row; // 페이지에 따라 출력행 변동되기한 위한 수식 조건
		 	String sql="SELECT * FROM board_gal WHERE gal_category=? ORDER BY gal_idx DESC limit ?,?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1,category);
		 	pstmt.setInt(2,n);
		 	pstmt.setInt(3,row);
		 	rs = pstmt.executeQuery();
		 	
		 	// row개씩 읽기
		 	while(rs.next()) {
		 		//날짜 형식 바꾸기
		 		if(df_basic.format(today).equals( df_basic.format(rs.getTimestamp("gal_regtime"))) ) {
		 			ts=df_time.format(rs.getTimestamp("gal_regtime"));
		 		}else{
		 			ts=df_basic.format(rs.getTimestamp("gal_regtime"));
		 		}
		 		
		 		//댓글 갯수 구하기
		 		rcnt = rdao.countReply("gal",rs.getInt("gal_idx")) + rrdao.countRereply("gal",rs.getInt("gal"+"_idx"));
		 		if(rcnt>0) {
		 			rcnt_dis = " ("+rcnt+") ";
		 		}else {
		 			rcnt_dis = " ";
		 		}
		 		
		 		//타이틀 길이 10자 제한
		 		if(rs.getString("gal_title").length()>10) {
		 			title10=rs.getString("gal_title").substring(0,9)+"...";
		 		}else {
		 			title10=rs.getString("gal_title");
		 		}
		 		
		 		imgpath = "<img onclick=\"location.href='readForm.jsp?page="+bpage+"&idx="+rs.getInt("gal_idx")+"'\" src='"+"../upload/thumb_"+rs.getString("gal_file")+"' width='245' height='245' />";
		 		
		 		//글번호, 글제목, 아이디, 조회수, 날짜
		 		res+=("<div id='gal"+rs.getInt("gal_idx")+"'>"+imgpath+"<br>"+
		 		rs.getString("gal_category")+"<br>"+
		 		"<a class='title' href='readForm.jsp?page="+bpage+"&idx="+rs.getInt("gal_idx")+"'>" + title10+ "</a>" +rcnt_dis+"<br>"+
		 		"<span class='nickname'>" + rs.getString("mem_nickname")+"</span><span class='regdate'>"+ts+"</span></div>");
		 		
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
	public String readgalBoard(int bpage) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		ReplyDAO rdao = ReplyDAO.getReplyDAO();
		RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
		int rcnt=0; // 댓글 갯수
		String rcnt_dis=" "; // 댓글수 표시
		String imgpath = "";
		SimpleDateFormat df_basic = new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat df_time = new SimpleDateFormat("HH:mm");
		Timestamp today = new Timestamp(System.currentTimeMillis()); //날짜비교 연산을 위한 오늘 날짜
		String ts = null;
		String res="";
		String title10="";
		
		try {	
		 	con=DBCon.getConnection();
		 	
		 	int row = 20; // 원하는 출력 행 수
		 	int n = (bpage-1)*row; // 페이지에 따라 출력행 변동되기한 위한 수식 조건
		 	String sql="SELECT * FROM board_gal ORDER BY gal_idx DESC limit ?,?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,n);
		 	pstmt.setInt(2,row);
		 	rs = pstmt.executeQuery();
		 	
		 	// row개씩 읽기
		 	while(rs.next()) {
		 		//날짜 형식 바꾸기
		 		if(df_basic.format(today).equals( df_basic.format(rs.getTimestamp("gal_regtime"))) ) {
		 			ts=df_time.format(rs.getTimestamp("gal_regtime"));
		 		}else{
		 			ts=df_basic.format(rs.getTimestamp("gal_regtime"));
		 		}
		 		
		 		//댓글 갯수 구하기
		 		rcnt = rdao.countReply("gal",rs.getInt("gal_idx")) + rrdao.countRereply("gal",rs.getInt("gal"+"_idx"));
		 		if(rcnt>0) {
		 			rcnt_dis = " ("+rcnt+") ";
		 		}else {
		 			rcnt_dis = " ";
		 		}
		 		
		 		//타이틀 길이 10자 제한
		 		if(rs.getString("gal_title").length()>10) {
		 			title10=rs.getString("gal_title").substring(0,9)+"...";
		 		}else {
		 			title10=rs.getString("gal_title");
		 		}
		 		
		 		imgpath = "<img onclick=\"location.href='readForm.jsp?page="+bpage+"&idx="+rs.getInt("gal_idx")+"'\" src='"+"../upload/thumb_"+rs.getString("gal_file")+"' width='245' height='245' />";
		 		
		 		//글번호, 글제목, 아이디, 조회수, 날짜
		 		res+=("<div id='gal"+rs.getInt("gal_idx")+"'>"+imgpath+"<br>"+
		 		rs.getString("gal_category")+"<br>"+
		 		"<a class='title' href='readForm.jsp?page="+bpage+"&idx="+rs.getInt("gal_idx")+"'>" + title10+ "</a>" +rcnt_dis+"<br>"+
		 		"<span class='nickname'>" + rs.getString("mem_nickname")+"</span><span class='regdate'>"+ts+"</span></div>");
		 		
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
	
	// 자료실 목록보기작업
	public String readdatBoard(int bpage) {
		PreparedStatement pstmt = null;
		Connection con =null;
		ResultSet rs = null;
		ReplyDAO rdao = ReplyDAO.getReplyDAO();
		RereplyDAO rrdao = RereplyDAO.getRereplyDAO();
		int rcnt=0; // 댓글 갯수
		String rcnt_dis=" "; // 댓글수 표시
		String con_img = " <img src='../images/file.png' width='25 height='25'>";
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
		 	String sql="SELECT * FROM board_dat br JOIN (SELECT @rownum:=@rownum+1 as row, brf.dat_idx FROM board_dat brf, (SELECT @rownum:=0) R WHERE dat_category <> '공지') rows ON (rows.dat_idx = br.dat_idx) ORDER BY br.dat_idx DESC limit ?,?";
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setInt(1,n);
		 	pstmt.setInt(2,row);
		 	rs = pstmt.executeQuery();
		 	
		 	// row개씩 읽기
		 	while(rs.next()) {
		 		//날짜 형식 바꾸기
		 		if(df_basic.format(today).equals( df_basic.format(rs.getTimestamp("dat_regtime"))) ) {
		 			ts=df_time.format(rs.getTimestamp("dat_regtime"));
		 		}else{
		 			ts=df_basic.format(rs.getTimestamp("dat_regtime"));
		 		}
		 		
		 		//댓글 갯수 구하기
		 		rcnt = rdao.countReply("dat",rs.getInt("dat_idx")) + rrdao.countRereply("dat",rs.getInt("dat_idx"));
		 		if(rcnt>0) {
		 			rcnt_dis = " ("+rcnt+") ";
		 		}else {
		 			rcnt_dis = " ";
		 		}
		 		
		 		//타이틀 길이 25자 제한
		 		if(rs.getString("dat_title").length()>25) {
		 			title25=rs.getString("dat_title").substring(0,24)+"...";
		 		}else {
		 			title25=rs.getString("dat_title");
		 		}
		 		
		 		//글번호, 글제목, 아이디, 조회수, 날짜
		 		res+=("<tr id='tr"+rs.getInt("dat_idx")+"'><td>"+rs.getInt("row") +"</td><td>"+
		 		rs.getString("dat_category")+"</td><td onclick=\"location.href='readForm.jsp?page="+bpage+"&idx="+rs.getInt("dat_idx")+"'\">"+
		 		title25 + con_img +rcnt_dis
		 		+"</td><td>"+rs.getString("mem_nickname")+"</td><td>"+
		 		rs.getInt("dat_rcount")+"</td><td>"+ts+"</td></tr>\n");
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
	public void insertBoard(String tb,FileboardBean fb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="INSERT INTO board_"+tb+"("+tb+"_category,"+tb+"_title,"+tb+"_content,"+tb+"_file,"+tb+"_rcount,mem_id,mem_nickname) VALUES(?,?,?,?,?,?,?)";
			
		 	pstmt = con.prepareStatement(sql);
		 	
		 	pstmt.setString(1,fb.getCategory());
		 	pstmt.setString(2,fb.getTitle());
		 	pstmt.setString(3,fb.getContent());
		 	pstmt.setString(4,fb.getFile());
		 	pstmt.setInt(5,fb.getRcount());
		 	pstmt.setString(6,fb.getId());
		 	pstmt.setString(7,fb.getNickname());
		 	
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
