package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conn.MyJndiContext;
import vo.MemVO;

public class MemDao {
	private static MemDao dao;

	public static synchronized MemDao getDao() {
		if(dao == null) dao = new MemDao();
		return dao;
	}
	public int login(MemVO v) throws SQLException{
		  int count = 0;
		   StringBuffer sql = new StringBuffer();
		   sql.append("select count(*) cnt from mem");
		   sql.append(" where id=? and pwd=?");
		   Connection con = MyJndiContext.getDs();
		   PreparedStatement pstmt = con.prepareStatement(sql.toString());
		   pstmt.setString(1, v.getId());
		   pstmt.setString(2, v.getPwd());
		   ResultSet rs = pstmt.executeQuery();
		   if(rs.next()){
		    count = rs.getInt("cnt");
		   }
		   rs.close();
		   pstmt.close();
		   con.close();
		  return count;
	}
}
