package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import conn.MyJndiContext;
import vo.BoardVO;
import vo.CommVO;

public class BoardDao {

	private static BoardDao dao;

	public static synchronized BoardDao getDao() {
		if (dao == null)
			dao = new BoardDao();
		return dao;
	}

	public void insert(HashMap<String, String> map) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = MyJndiContext.getDs();
			StringBuffer sql = new StringBuffer();
			sql.append("insert into board values(");
			sql.append("board_seq.nextVal,?,?,?,0,?,sysdate)");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, map.get("title"));
			pstmt.setString(2, map.get("writer"));
			pstmt.setString(3, map.get("content"));
			pstmt.setInt(4, 1);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	public ArrayList<BoardVO> getList(Map<String, Integer> map) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();

		StringBuffer sql = new StringBuffer();
		sql.append("select * from (select rownum r_num, a.* from (");
		sql.append("select * from board order by no desc) a");
		sql.append(") where r_num between ? and ?");
		// ���������� �ܺ� �������� ���� ����ȴ�.
		// from �� �ڿ� ���������� ���� inline view(���� view)
		
		try {
			con = MyJndiContext.getDs();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, map.get("begin"));
			pstmt.setInt(2, map.get("end"));
			rs = pstmt.executeQuery();
			while(rs.next()){
				BoardVO v = new BoardVO();
				v.setTitle(rs.getString("title"));
				v.setNo(rs.getInt("no"));
				v.setWriter(rs.getString("writer"));
				v.setRegdate(rs.getString("regdate"));
				v.setHit(rs.getInt("hit"));
				list.add(v);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	public int getTotalCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) cnt from board");
		// select count(*) from board => *�� null���� �����Ѵ�.

		int res = 0;
		try {
			con = MyJndiContext.getDs();
			pstmt = con.prepareStatement(sql.toString());
		
			rs = pstmt.executeQuery();
			if(rs.next()){
				res = rs.getInt("cnt");	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return res;
	}
	
	public BoardVO getDetail(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append("select no,hit,groupno,title,writer,content,");
		sql.append("to_char(regdate,'yyyy-mm-dd') regdate from board where no=?");
		// select count(*) from board => *�� null���� �����Ѵ�.

		BoardVO v = new BoardVO();
		try {
			con = MyJndiContext.getDs();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()){
				v.setNo(rs.getInt("no"));
				v.setHit(rs.getInt("hit"));
				v.setGroupno(rs.getInt("groupno"));
				v.setTitle(rs.getString("title"));
				v.setWriter(rs.getString("writer"));
				v.setContent(rs.getString("content"));
				v.setRegdate(rs.getString("regdate"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return v;
	}
	
	// comm
	
	public void insertComm(Map<String, String> map){
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = MyJndiContext.getDs();
			StringBuffer sql = new StringBuffer();
			sql.append("insert into comm values(");
			sql.append("comm_seq.nextVal,?,?,?,?,?,sysdate)");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, "��浿");
			pstmt.setString(2, map.get("targetIcon"));
			pstmt.setInt(3, Integer.parseInt(map.get("code")));
			pstmt.setString(4, map.get("comm"));
			pstmt.setString(5, map.get("reip"));
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// ����� �˻��ϱ� ���� �ʼ� ���� ***
	// code ���� �ش� detail�� no���� ������ �ϰ�,
	// ������ ó���� �ʿ��� begin�� end�� ������ �Ѵ�.
	public ArrayList<CommVO> getCommList(Map<String, Integer> map) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<CommVO> list = new ArrayList<CommVO>();

		StringBuffer sql = new StringBuffer();
		sql.append("select * from (select rownum r_num, a.* from (");
		sql.append("select * from comm where code=? order by no desc) a");
		sql.append(") where r_num between ? and ?");
		// inline view
		
		try {
			con = MyJndiContext.getDs();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, map.get("no"));
			pstmt.setInt(2, map.get("begin"));
			pstmt.setInt(3, map.get("end"));
			
			
			rs = pstmt.executeQuery();
			while(rs.next()){
				CommVO v = new CommVO();
				
				v.setNo(rs.getInt("no"));
				v.setWriter(rs.getString("writer"));
				v.setImgicon(rs.getString("imgicon"));
				v.setComm(rs.getString("comm"));
				v.setRegdate(rs.getString("regdate"));
				
				list.add(v);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// Comm�� Total
	// ���ڰ� �� detail�� pk ��(no)�� ��������
	// detail �������� �Ҽӵ� ����� ��ü ī��Ʈ���� �����´�.
	public int getTotalCommCount(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) cnt from comm where code=?");
		// select count(*) from board => *�� null���� �����Ѵ�.
		// count -> ����Լ�, �׷��Լ�

		int res = 0;
		try {
			con = MyJndiContext.getDs();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, no);
			rs = pstmt.executeQuery();
			if(rs.next()){
				res = rs.getInt("cnt");	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return res; 
	}

}
