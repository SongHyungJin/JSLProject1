package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBmanager;

public class UsersDAO {
	//회원정보 DB등록 메서드 (회원가입)
	public void insertUsers(UsersDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql ="insert into users(id,email,password,nickname) values(users_seq.nextval,?,?,?)";
		
		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getNickname());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
			
		}finally {
			
		}
	}
	//이메일 중복여부 확인 메서드(유저확인용),email unique 제약조건 
	public int checkEmail(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0; 
		//result==0 아이디 사용가능 
		//result==1 아이디 사용 불가 
		String sql ="select email from users where email=?";
		
		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result=1;
			}else {
				result=0;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			
		}finally {
			DBmanager.close(pstmt, conn);
		}
		return result;
	}
	//닉네임 중복여부 확인 메서드(유저확인용) ninkname unique 제약조건
	public int checkNickname(String nickname) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0; 
		//result==0 닉네임 사용가능 
		//result==1 닉네임 사용 불가 
		String sql ="select nickname from users where ninkname=?";
		
		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result=1;
			}else {
				result=0;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			
		}finally {
			DBmanager.close(pstmt, conn);
		}
		return result;
	}
	
	//로그인
		public UsersDTO loginByEmail(String email) {
			Connection conn =null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int result = 0;
			
			String sql ="select * from users where email=?";
			
			UsersDTO dto =null;
			
			try {
				
				conn= DBmanager.getInstance();
				pstmt =conn.prepareStatement(sql);
				pstmt.setString(1, email);
				rs =pstmt.executeQuery();
			
					if(rs.next()) {
						dto = new UsersDTO();
						dto.setEmail(rs.getString("email"));
						dto.setPassword(rs.getString("password"));
						return dto;
					}
				
					
				
			}catch(Exception e) {
				
				e.printStackTrace();
			}finally {
				DBmanager.close(pstmt, conn, rs);
			}
			return dto;
			
		} 
		
	//닉네임 수정 
		public void updateNickname(int id, String nickname) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			String sql ="update users set nickname=? where id=?";
			
			try {
				conn = DBmanager.getInstance();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, nickname);
				pstmt.setInt(2, id);
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
				
			}finally {
				DBmanager.close(pstmt, conn);
			}
		}
		
	//비밀번호 변경(service에서 입력받은 비밀번호 일치 확인 후,BCrypt암호화해서 변경)
		public void updatePassword(int id,String password) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			String sql ="update users set password=? where id=?";
			
			try {
				conn = DBmanager.getInstance();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, password);
				pstmt.setInt(2, id);
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
				
			}finally {
				DBmanager.close(pstmt, conn);
			}
		}
		
		//프로필 조회
		public UsersDTO getProfile(int id) {
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			UsersDTO dto = null;
			
			String sql ="select * from users where id=?";
			
			try {
				conn = DBmanager.getInstance();
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, id);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dto = new UsersDTO();
					dto.setId(rs.getInt("id"));
					dto.setEmail(rs.getString("email"));
					dto.setNickname(rs.getString("nickname"));
					dto.setRole(rs.getString("role"));
					dto.setLanguage(rs.getString("language"));
					dto.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
					dto.setUpdate_at(rs.getTimestamp("update_at").toLocalDateTime());
				}
				
			}catch(Exception e) {
				e.printStackTrace();
				
			}finally {
				DBmanager.close(pstmt, conn, rs);
			}
			return dto;
		}
		
		
	
}
