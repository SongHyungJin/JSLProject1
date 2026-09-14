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

	    String sql =
	        "INSERT INTO reviews ("
	        + "id, users_id, places_id, rating, content, image_url"
	        + ") VALUES ("
	        + "REVIEWS_SEQ.NEXTVAL, ?, ?, ?, ?, ?"
	        + ")";

	    int result = 0;

	    try {

	        conn = DBmanager.getInstance();
	        pstmt = conn.prepareStatement(sql);

	        pstmt.setInt(1, dto.getUsersId());
	        pstmt.setInt(2, dto.getPlacesId());
	        pstmt.setInt(3, dto.getRating());
	        pstmt.setString(4, dto.getContent());
	        pstmt.setString(5, dto.getImageUrl());

	        result = pstmt.executeUpdate();

	    } catch (SQLException e) {
	        e.printStackTrace();

	    } finally {
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
                dto.setImageUrl(rs.getString("image_url"));

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
    
 // 장소 ID로 리뷰 조회
    public List<ReviewsDTO> selectByPlacesId(int placesId) {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        List<ReviewsDTO> list = new ArrayList<>();

        String sql =
                "SELECT r.*, u.nickname "
              + "FROM reviews r "
              + "JOIN users u ON r.users_id = u.id "
              + "WHERE r.deleted = 0 "
              + "AND r.places_id = ? "
              + "ORDER BY r.id DESC";

        try {

            conn = DBmanager.getInstance();

            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, placesId);

            rs = pstmt.executeQuery();

            while (rs.next()) {

                ReviewsDTO dto = new ReviewsDTO();

                dto.setId(rs.getInt("id"));
                dto.setUsersId(rs.getInt("users_id"));
                dto.setPlacesId(rs.getInt("places_id"));
                dto.setRating(rs.getInt("rating"));
                dto.setContent(rs.getString("content"));
                dto.setDeleted(rs.getInt("deleted"));
                dto.setImageUrl(rs.getString("image_url"));
                dto.setNickname(rs.getString("nickname"));

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

        } finally {

            DBmanager.close(pstmt, conn, rs);

        }

        return list;
    }
 // 해당 사용자가 해당 장소에 이미 리뷰를 작성했는지 확인
    public boolean existsReview(int usersId, int placesId) {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql =
                "SELECT COUNT(*) "
              + "FROM reviews "
              + "WHERE users_id = ? "
              + "AND places_id = ? "
              + "AND deleted = 0";

        try {

            conn = DBmanager.getInstance();

            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, usersId);
            pstmt.setInt(2, placesId);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {

            e.printStackTrace();

        } finally {

            DBmanager.close(pstmt, conn, rs);

        }

        return false;
    }
}
