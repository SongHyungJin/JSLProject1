package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBmanager;

public class UsersDAO {
	// 회원정보 DB등록 메서드 (회원가입)
	public int insertUsers(UsersDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0; // 회원가입 성공여부 확인용
		String sql = "insert into users(id,email,password,nickname,language) values(users_seq.nextval,?,?,?,?)";

		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getNickname());
			pstmt.setString(4, dto.getLanguage());
			result = pstmt.executeUpdate(); // 성공시 1

		} catch (Exception e) {
			e.printStackTrace();
			return result; // 회원가입 실패
		} finally {
			DBmanager.close(pstmt, conn);
		}
		return result; // 회원가입 성공
	}

	// 이메일 중복여부 확인 메서드(유저확인용),email unique 제약조건
	public int checkEmail(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		// result==0 아이디 사용가능
		// result==1 아이디 사용 불가
		String sql = "select email from users where email=?";
		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				
				result = 1;
			} else {
				result = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			DBmanager.close(pstmt, conn);
		}
		return result;
	}

	public String checkEmailStatus(String email) {

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String status = null;

		String sql = "SELECT status FROM users WHERE email = ?";

		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, email);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				status = rs.getString("status");
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			DBmanager.close(pstmt, conn, rs);
		}

		return status;
	}

	// 재가입, 권한 복구
	public int restoreWithdrawnUser(String email, String password, String nickname, String language) {

		Connection conn = null;
		PreparedStatement pstmt = null;

		int result = 0;

		String sql = "UPDATE users " + "SET password = ?, " + "    nickname = ?, " + "    language = ?, "
				+ "    status = 'ACTIVE' " + "WHERE email = ? " + "AND status = 'WITHDRAWN'";

		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, password);
			pstmt.setString(2, nickname);
			pstmt.setString(3, language);
			pstmt.setString(4, email);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			DBmanager.close(pstmt, conn);
		}

		return result;
	}

	// 닉네임 중복여부 확인 메서드(유저확인용) ninkname unique 제약조건
	public int checkNickname(String nickname) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;
		// result==0 닉네임 사용가능
		// result==1 닉네임 사용 불가
		String sql = "select nickname from users where nickname=?";

		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = 1;
			} else {
				result = 0;
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			DBmanager.close(pstmt, conn);
		}
		return result;
	}

	// 로그인
	public UsersDTO loginByEmail(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		String sql = "SELECT * FROM users " + "WHERE email = ? " + "AND status = 'ACTIVE'";

		UsersDTO dto = null;

		try {

			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new UsersDTO();
				dto.setId(rs.getInt("id"));
				dto.setEmail(rs.getString("email"));
				dto.setPassword(rs.getString("password"));
				return dto;
			}

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			DBmanager.close(pstmt, conn, rs);
		}
		return dto;

	}

	// 닉네임 수정
	public int updateNickname(int id, String nickname) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0; // 닉네임 변경 성공여부 확인용
		String sql = "update users set nickname=? where id=?";

		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nickname);
			pstmt.setInt(2, id);
			result = pstmt.executeUpdate(); // 성공시 1

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			DBmanager.close(pstmt, conn);
		}
		return result;
	}

	// 비밀번호 변경(service에서 입력받은 비밀번호 일치 확인 후,BCrypt암호화해서 변경)
	public int updatePassword(int id, String password) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0; // 비밀번호 변경 성공여부 확인용

		String sql = "update users set password=? where id=?";

		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setInt(2, id);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			DBmanager.close(pstmt, conn);
		}
		return result;
	}

	// 프로필 조회
	public UsersDTO getProfile(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UsersDTO dto = null;

		String sql = "select * from users where id=?";

		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new UsersDTO();
				dto.setId(rs.getInt("id"));
				dto.setEmail(rs.getString("email"));
				dto.setNickname(rs.getString("nickname"));
				dto.setPassword(rs.getString("password"));
				dto.setRole(rs.getString("role"));
				dto.setLanguage(rs.getString("language"));
				dto.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
				dto.setUpdate_at(rs.getTimestamp("update_at").toLocalDateTime());
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			DBmanager.close(pstmt, conn, rs);
		}
		return dto;
	}

	public int withdrawUser(int usersId) {

		Connection conn = null;
		PreparedStatement pstmt = null;

		String sql = "UPDATE users " + "SET status = 'WITHDRAWN' " + "WHERE id = ?";

		int result = 0;

		try {

			conn = DBmanager.getInstance();

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, usersId);

			result = pstmt.executeUpdate();

		} catch (SQLException e) {

			e.printStackTrace();

		} finally {

			DBmanager.close(pstmt, conn);
		}

		return result;
	}

	// 이메일 찾기

	public UsersDTO findEmail(String nickname) {

		String sql = "SELECT email " + "FROM users " + "WHERE nickname = ?";
		UsersDTO dto = new UsersDTO();
		try (
			Connection conn = DBmanager.getInstance(); 
			PreparedStatement pstmt = conn.prepareStatement(sql)){

			pstmt.setString(1, nickname);

			try (ResultSet rs = pstmt.executeQuery()) {

				while (rs.next()) {
					
					dto.setEmail(rs.getString("email"));
					return dto;
				}

			}

		} catch (SQLException e) {

			e.printStackTrace();
		}
		return dto;

	}
	
	public UsersDTO findByEmail(String email) {

	    String sql = "SELECT id, email, password "
	               + "FROM users "
	               + "WHERE email = ?";

	    UsersDTO dto = new UsersDTO();

	    try (
	        Connection conn = DBmanager.getInstance();
	        PreparedStatement pstmt = conn.prepareStatement(sql)
	    ) {

	        pstmt.setString(1, email);

	        try (ResultSet rs = pstmt.executeQuery()) {

	            if (rs.next()) {
	                dto.setId(rs.getInt("id"));
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return dto;
	}

}
