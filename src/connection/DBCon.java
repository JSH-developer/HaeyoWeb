package connection;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBCon {
	private static Connection con;

	private DBCon(){ //외부에서 생성하지 못하게 생성자 private으로 지정      
	}
	
	// DB연결설정
	public static Connection getConnection() throws Exception {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();
		return con;
	}

}
