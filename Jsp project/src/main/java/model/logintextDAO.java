package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBManager;

public class logintextDAO {

	public int sign_up(loginDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "insert into test_userid (user_id, user_pwd, user_name) "
				+ "values (?, ?, ?)";
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getUser_pwd());
			pstmt.setString(3, dto.getUser_name());
			pstmt.executeUpdate();
			
			return 1;
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(pstmt, conn);
		}
		
		return 0;
	}
	
	
	public loginDTO login(loginDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from test_userid where user_id = ? and user_pwd = ?";
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_id());
			pstmt.setString(2, dto.getUser_pwd());
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				loginDTO resultDto = new loginDTO();
				resultDto.setUser_id(rs.getString("user_id"));
				resultDto.setUser_pwd(rs.getString("user_pwd"));
				resultDto.setUser_name(rs.getString("user_name"));
				return resultDto;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(rs, pstmt, conn);
		}
		
		return null;
	}
}
