package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBmanager;

public class ReviewsDAO {
	// 리뷰 등록
    public int insert(ReviewsDTO dto) {
    	Connection conn = null;
		PreparedStatement pstmt = null;

        String sql = "INSERT INTO reviews ("
                   + "id, users_id, places_id, rating, content"
                   + ") VALUES ("
                   + "REVIEWS_SEQ.NEXTVAL, ?, ?, ?, ?"
                   + ")";

        int result = 0;

        try  {
        	conn = DBmanager.getInstance();
        	pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getUsersId());
            pstmt.setInt(2, dto.getPlacesId());
            pstmt.setInt(3, dto.getRating());
            pstmt.setString(4, dto.getContent());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
			DBmanager.close(pstmt, conn);
		}

        return result;
    }


    // 리뷰 수정
    public int update(ReviewsDTO dto) {
    	
    	Connection conn = null;
		PreparedStatement pstmt = null;

        String sql = "UPDATE reviews SET "
                   + "rating = ?, "
                   + "content = ?, "
                   + "updated_at = CURRENT_TIMESTAMP "
                   + "WHERE id = ? "
                   + "AND deleted = 0";

        int result = 0;

        try {
        	conn = DBmanager.getInstance();
        	pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getRating());
            pstmt.setString(2, dto.getContent());
            pstmt.setInt(3, dto.getId());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
        	DBmanager.close(pstmt, conn);
        }

        return result;
    }


    // 전체 리뷰 조회
    public List<ReviewsDTO> selectAll() {
    	Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;

        List<ReviewsDTO> list = new ArrayList<>();

        String sql = "SELECT * FROM reviews "
                   + "WHERE deleted = 0 "
                   + "ORDER BY id DESC";

        try {
        	conn = DBmanager.getInstance();
        	pstmt = conn.prepareStatement(sql);
            rs= pstmt.executeQuery();

            while (rs.next()) {

                ReviewsDTO dto = new ReviewsDTO();

                dto.setId(rs.getInt("id"));
                dto.setUsersId(rs.getInt("users_id"));
                dto.setPlacesId(rs.getInt("places_id"));
                dto.setRating(rs.getInt("rating"));
                dto.setContent(rs.getString("content"));
                dto.setDeleted(rs.getInt("deleted"));

                if (rs.getTimestamp("created_at") != null) {
                    dto.setCreatedAt(
                        rs.getTimestamp("created_at").toLocalDateTime()
                    );
                }

                if (rs.getTimestamp("updated_at") != null) {
                    dto.setUpdatedAt(
                        rs.getTimestamp("updated_at").toLocalDateTime()
                    );
                }

                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
			DBmanager.close(pstmt, conn,rs);
		}

        return list;
    }
}
