package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBManager;

/**
 * users 테이블 비밀번호 찾기 / 변경 담당 DAO
 */
public class FindPasswordDAO {


    /**
     * 가입된 이메일인지 확인
     *
     * @param email 확인할 이메일
     * @return 존재하면 true, 없으면 false
     */
    public boolean checkEmail(String email) {

        boolean result = false;

        String sql =
                "SELECT id "
              + "FROM users "
              + "WHERE email = ?";


        try (Connection conn = DBManager.getInstance();
             PreparedStatement pstmt =
                     conn.prepareStatement(sql)) {


            pstmt.setString(1, email);


            try (ResultSet rs =
                    pstmt.executeQuery()) {

                if (rs.next()) {
                    result = true;
                }
            }


        } catch (SQLException e) {

            e.printStackTrace();
        }


        return result;
    }



    /**
     * 비밀번호 변경
     *
     * @param email 가입 이메일
     * @param newPassword 새 비밀번호
     * @return 성공 시 1, 실패 시 0
     */
    public int updatePassword(
            String email,
            String newPassword) {

        int result = 0;


        String sql =
                "UPDATE users "
              + "SET password = ?, "
              + "updated_at = SYSDATE "
              + "WHERE email = ?";


        try (Connection conn = DBManager.getInstance();
             PreparedStatement pstmt =
                     conn.prepareStatement(sql)) {


            pstmt.setString(
                    1,
                    newPassword
            );

            pstmt.setString(
                    2,
                    email
            );


            result =
                    pstmt.executeUpdate();


        } catch (SQLException e) {

            e.printStackTrace();
        }


        return result;
    }
}