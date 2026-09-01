package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBmanager;

public class UsersDAO {
	//회원정보 DB등록 메서드 
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
			
		}
		return result;
	}
}
