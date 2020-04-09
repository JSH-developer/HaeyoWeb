package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.DBCon;

public class MemberDAO {
	
	private static MemberDAO msingleton;
	private MemberDAO() {}
	public static MemberDAO getMemberDAO() {
	 if(msingleton == null) {
        msingleton = new MemberDAO();
	 }
	 return msingleton;
	}
	
	
	// 아이디 이메일 일치여부 확인
	public boolean idEmailCheck(String id,String email) {
		boolean is_exist=false;
		PreparedStatement pstmt = null;
		Connection con =null;;
		ResultSet rs = null;
	 
	 	try {
	 		con = DBCon.getConnection();
	 		
		 	String sql="SELECT mem_id FROM member WHERE mem_id=? AND mem_email=?";
		 	
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1, id);
		 	pstmt.setString(2, email);
		 	
		 	rs = pstmt.executeQuery();
	 		
		 	if(rs.next()) {
		 		is_exist=true;
		 	}
		 	
	 	}catch(Exception e){
	 		e.printStackTrace();
	 		
	 	}finally {
	 		try { // finally 안쪽의 예외처리
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				e.printStackTrace();
			}
	 	}
	 	
	 	return is_exist;		
	}	
	
	
	// 회원 정보 수정
	public void updateMember(MemberBean mb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="UPDATE member SET mem_pass=?, mem_nickname=?, mem_gender=?, mem_pcode=?, mem_address1=?, mem_address2=?, mem_phone=?, mem_email=? WHERE mem_id=?";
			
		 	pstmt = con.prepareStatement(sql);
		 	
		 	pstmt.setString(1,mb.getPass());
		 	pstmt.setString(2,mb.getNickname());
		 	pstmt.setString (3, mb.getGender());
		 	pstmt.setString(4, mb.getPcode());
		 	pstmt.setString(5,mb.getAddress1());
		 	pstmt.setString(6,mb.getAddress2());
		 	pstmt.setString(7,mb.getPhone());
		 	pstmt.setString(8, mb.getEmail());
		 	pstmt.setString(9,mb.getId());
		 	
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
	
	// 회원 정보 삭제
	public void deleteMember(String user_id) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="DELETE FROM member WHERE mem_id=?";
			
		 	pstmt = con.prepareStatement(sql);
		 	
		 	pstmt.setString(1,user_id);
		 	
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
	
	// (임시)비밀번호 변경
	public void updatePass(String id, String pass) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="UPDATE member SET mem_pass=? WHERE mem_id=?";
			
		 	pstmt = con.prepareStatement(sql);
		 	
		 	pstmt.setString(1,pass);
		 	pstmt.setString(2,id);
		 	
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
	
	// 아이디로 닉네임 알아내기
	public String getNickname(String id) {
		PreparedStatement pstmt = null;
		Connection con =null;;
		ResultSet rs = null;
		
		String nn = "";
		
	 	try {
	 		con = DBCon.getConnection();
	 		
		 	String sql="SELECT mem_nickname FROM member WHERE mem_id=?";
		 	
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1, id);
		 	
		 	rs = pstmt.executeQuery();
	 		
		 	if(rs.next()) {
		 		nn=rs.getString("mem_nickname");
		 	}
		 	
	 	}catch(Exception e){
	 		e.printStackTrace();
	 		
	 	}finally {
	 		try { // finally 안쪽의 예외처리
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				e.printStackTrace();
			}
	 	}
	 	
	 	return nn;
	}	
	
	
	// 유저 정보 불러오기
	public MemberBean getUserInfo(String id) {
		PreparedStatement pstmt = null;
		Connection con =null;;
		ResultSet rs = null;

		MemberBean mb = new MemberBean();
		
	 	try {
	 		con = DBCon.getConnection();
	 		
		 	String sql="SELECT * FROM member WHERE mem_id=?";
		 	
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1, id);
		 	
		 	rs = pstmt.executeQuery();
	 		
		 	if(rs.next()) {
		 		mb.setIdx(rs.getInt("mem_idx"));
		 		mb.setId(rs.getString("mem_id"));
		 		mb.setPass(rs.getString("mem_pass"));// password ???
		 		mb.setNickname(rs.getString("mem_nickname"));
		 		mb.setGender(rs.getString("mem_gender"));
		 		mb.setPcode(rs.getString("mem_pcode"));
		 		mb.setAddress1(rs.getString("mem_address1"));
		 		mb.setAddress2(rs.getString("mem_address2"));
		 		mb.setPhone(rs.getString("mem_phone"));
		 		mb.setEmail(rs.getString("mem_email"));
		 		mb.setAuth(rs.getInt("mem_auth"));
		 		mb.setRegtime(rs.getTimestamp("mem_regtime"));
		 	}
		 	
	 	}catch(Exception e){
	 		e.printStackTrace();
	 		
	 	}finally {
	 		try { // finally 안쪽의 예외처리
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				e.printStackTrace();
			}
	 	}
	 	
	 	return mb;
		
	}
	
	// 아이디 중복 확인
	public boolean idDupCheck(String id) {
		boolean is_exist=false;
		PreparedStatement pstmt = null;
		Connection con =null;;
		ResultSet rs = null;
	 
	 	try {
	 		con = DBCon.getConnection();
	 		
		 	String sql="SELECT mem_id FROM member WHERE mem_id=?";
		 	
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1, id);
		 	
		 	rs = pstmt.executeQuery();
	 		
		 	if(rs.next()) {
		 		is_exist=true;
		 	}
		 	
	 	}catch(Exception e){
	 		e.printStackTrace();
	 		
	 	}finally {
	 		try { // finally 안쪽의 예외처리
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				e.printStackTrace();
			}
	 	}
	 	
	 	return is_exist;		
	}
	
	// 닉네임 중복 확인
	public boolean nameDupCheck(String name) {
		boolean is_exist=false;
		PreparedStatement pstmt = null;
		Connection con =null;;
		ResultSet rs = null;
	 
	 	try {
	 		con = DBCon.getConnection();
	 		
		 	String sql="SELECT mem_nickname FROM member WHERE mem_nickname=?";
		 	
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1, name);
		 	
		 	rs = pstmt.executeQuery();
	 		
		 	if(rs.next()) {
		 		is_exist=true;
		 	}
		 	
	 	}catch(Exception e){
	 		e.printStackTrace();
	 		
	 	}finally {
	 		try { // finally 안쪽의 예외처리
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				e.printStackTrace();
			}
	 	}
	 	
	 	return is_exist;		
	}
	
	// 아이디 비밀번호 일치확인
	public int userCheck(String id, String pass) {
		int check=10;
		PreparedStatement pstmt = null;
		Connection con =null;;
		ResultSet rs = null;
	 
	 	try {
	 		con = DBCon.getConnection();
	 		
		 	String sql="SELECT mem_pass, mem_auth FROM member WHERE mem_id=?";
		 	
		 	pstmt = con.prepareStatement(sql);
		 	pstmt.setString(1, id);
		 	
		 	rs = pstmt.executeQuery();
	 		
		 	if(rs.next()) {
		 		if(rs.getString("mem_pass").equals(pass) && rs.getInt("mem_auth")==1) {
		 			check = 1; // 아이디 비밀번호 일치
		 		}else if(rs.getInt("mem_auth")!=1){
		 			check = 2; // 권한없음
		 		}else {
		 			check = 0; // 비밀번호 불일치
		 		}
		 	}else {
		 		check = -1; // 아이디 불일치
		 	}
		 	
	 	}catch(Exception e){
	 		e.printStackTrace();
	 		
	 	}finally {
	 		try { // finally 안쪽의 예외처리
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(con != null) {con.close(); con = null;}
				if(rs != null) {rs.close(); rs = null;}
			} catch(SQLException e) {
				e.printStackTrace();
			}
	 	}
	 	
	 	return check;
	}
	
	
	//회원가입
	public void joinMember(MemberBean mb) {
		PreparedStatement pstmt = null;
		Connection con =null;
		
		try {	
		 	con=DBCon.getConnection();
			
		 	String sql="INSERT INTO member(mem_id,mem_pass,mem_nickname,mem_gender,mem_pcode,mem_address1,mem_address2,mem_phone,mem_email) VALUES(?,?,?,?,?,?,?,?,?)";
			
		 	pstmt = con.prepareStatement(sql);
		 	
		 	pstmt.setString(1,mb.getId());
		 	pstmt.setString(2,mb.getPass());
		 	pstmt.setString(3,mb.getNickname());
		 	pstmt.setString (4, mb.getGender());
		 	pstmt.setString(5, mb.getPcode());
		 	pstmt.setString(6,mb.getAddress1());
		 	pstmt.setString(7,mb.getAddress2());
		 	pstmt.setString(8,mb.getPhone());
		 	pstmt.setString(9, mb.getEmail());
		 	
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
