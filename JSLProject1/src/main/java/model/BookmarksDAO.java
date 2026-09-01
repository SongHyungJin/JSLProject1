package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBmanager;

public class BookmarksDAO {
	
	// 북마크 등록
    public int insert(BookmarksDTO dto) {
    	
    	Connection conn = null;
		PreparedStatement pstmt = null;

        String sql = "INSERT INTO bookmarks ("
                   + "id, users_id, places_id"
                   + ") VALUES ("
                   + "BOOKMARKS_SEQ.NEXTVAL, ?, ?"
                   + ")";

        int result = 0;

        try{
        	conn = DBmanager.getInstance();
        	pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getUsersId());
            pstmt.setInt(2, dto.getPlacesId());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
            
        }finally {
			DBmanager.close(pstmt, conn);
		}

        return result;
    }


    // 북마크 삭제
    public int delete(int usersId, int placesId) {
    	
    	Connection conn = null;
		PreparedStatement pstmt = null;

        String sql = "DELETE FROM bookmarks "
                   + "WHERE users_id = ? "
                   + "AND places_id = ?";

        int result = 0;

        try {
        	conn = DBmanager.getInstance();
        	pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, usersId);
            pstmt.setInt(2, placesId);

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
        	DBmanager.close(pstmt, conn);
        }

        return result;
    }


    // 특정 사용자 북마크 조회
    public List<BookmarksDTO> selectBookmarksBy(int usersId) {
    	
    	Connection conn=null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;

        String sql = "SELECT * FROM bookmarks "
                   + "WHERE users_id = ? ";

        List<BookmarksDTO> list = new ArrayList<BookmarksDTO>();

        try {
        	conn = DBmanager.getInstance();
        	pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, usersId);
            rs= pstmt.executeQuery();
            
                while (rs.next()) {
                	
                    BookmarksDTO dto = new BookmarksDTO();

                    dto.setId(rs.getInt("id"));
                    dto.setUsersId(rs.getInt("users_id"));
                    dto.setPlacesId(rs.getInt("places_id"));

                    if (rs.getTimestamp("created_at") != null) {
                        dto.setCreatedAt(
                            rs.getTimestamp("created_at").toLocalDateTime()
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
