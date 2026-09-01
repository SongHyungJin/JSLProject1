package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.DBmanager;

public class BookmarksDAO {
	
	// 북마크 등록
    public int insert(BookmarksDTO dto) {

        String sql = "INSERT INTO bookmarks ("
                   + "id, users_id, places_id"
                   + ") VALUES ("
                   + "BOOKMARKS_SEQ.NEXTVAL, ?, ?"
                   + ")";

        int result = 0;

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dto.getUsersId());
            pstmt.setInt(2, dto.getPlacesId());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }


    // 북마크 삭제
    public int delete(int usersId, int placesId) {

        String sql = "DELETE FROM bookmarks "
                   + "WHERE users_id = ? "
                   + "AND places_id = ?";

        int result = 0;

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, usersId);
            pstmt.setInt(2, placesId);

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }


    // 특정 사용자 북마크 조회
    public BookmarksDTO selectOne(int usersId) {

        String sql = "SELECT * FROM bookmarks "
                   + "WHERE users_id = ? "
                   + "AND places_id = ?";

        BookmarksDTO dto = null;

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, usersId);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {

                    dto = new BookmarksDTO();

                    dto.setId(rs.getInt("id"));
                    dto.setUsersId(rs.getInt("users_id"));
                    dto.setPlacesId(rs.getInt("places_id"));

                    if (rs.getTimestamp("created_at") != null) {
                        dto.setCreatedAt(
                            rs.getTimestamp("created_at").toLocalDateTime()
                        );
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return dto;
    }
}
