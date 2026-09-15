package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBManager;

/**
 * users 테이블 이메일 찾기 담당 DAO
 */
public class FindEmailDAO {

    /**
     * 닉네임으로 가입 이메일 조회
     *
     * @param nickname 가입할 때 사용한 닉네임
     * @return 이메일, 없으면 null
     */
    public String findEmail(String nickname) {

        String email = null;

        String sql =
                "SELECT email "
              + "FROM users "
              + "WHERE nickname = ?";


        try (Connection conn = DBManager.getInstance();
             PreparedStatement pstmt =
                     conn.prepareStatement(sql)) {


            pstmt.setString(
                    1,
                    nickname
            );


            try (ResultSet rs =
                    pstmt.executeQuery()) {


                if (rs.next()) {

                    email =
                        rs.getString(
                            "email"
                        );
                }
            }


        } catch (SQLException e) {

            e.printStackTrace();
        }


        return email;
    }
}
