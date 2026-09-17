package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBmanager;

/**
 * 구글 Places 점포 찜 처리용 DAO.
 *  - upsertPlace : google_place_id 기준으로 places 에 없으면 저장, 있으면 그 id 반환
 *  - toggleBookmark : (users_id, places_id) 찜이 있으면 삭제(false), 없으면 추가(true)
 *
 * 기존 팀 DAO(BookmarksDAO/PlacesDAO)는 건드리지 않고, 이 기능만 별도로 처리한다.
 * 점포정보=Places / 찜=우리 DB 하이브리드 설계의 저장 담당.
 */
public class GoogleBookmarkDAO {

    /** google_place_id 로 places 를 upsert 하고 places.id 반환 (실패 시 -1) */
    public int upsertPlace(String googlePlaceId, String name, String category,
                           String region, double lat, double lng, double rating) {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBmanager.getInstance();

            // 1) 이미 저장된 구글 점포면 그 id 사용
            pstmt = conn.prepareStatement("SELECT id FROM places WHERE google_place_id = ?");
            pstmt.setString(1, googlePlaceId);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                rs.close();
                pstmt.close();
                return id;
            }
            rs.close();
            pstmt.close();

            // 2) 없으면 새로 저장 (reservable=0: 구글 점포는 우리 예약 대상 아님)
            String insert =
                "INSERT INTO places "
              + "(id, name, category, region, latitude, longitude, reservable, rating, google_place_id) "
              + "VALUES (places_seq.NEXTVAL, ?, ?, ?, ?, ?, 0, ?, ?)";
            pstmt = conn.prepareStatement(insert);
            pstmt.setString(1, name);
            pstmt.setString(2, category);
            pstmt.setString(3, region);
            pstmt.setDouble(4, lat);
            pstmt.setDouble(5, lng);
            pstmt.setDouble(6, rating);
            pstmt.setString(7, googlePlaceId);
            pstmt.executeUpdate();
            pstmt.close();

            // 3) 방금 저장한 id 조회
            pstmt = conn.prepareStatement("SELECT id FROM places WHERE google_place_id = ?");
            pstmt.setString(1, googlePlaceId);
            rs = pstmt.executeQuery();
            int newId = rs.next() ? rs.getInt("id") : -1;
            return newId;

        } catch (Exception e) {
            e.printStackTrace();
            return -1;
        } finally {
            DBmanager.close(pstmt, conn, rs);
        }
    }

    /** 사용자가 찜한 점포들을 좌표 포함해서 조회 (나의 여행루트용, PlacesDTO 목록) */
    public List<PlacesDTO> selectBookmarkedPlaces(int usersId) {

        List<PlacesDTO> list = new ArrayList<PlacesDTO>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql =
            "SELECT p.id, p.name, p.category, p.region, p.latitude, p.longitude, p.rating, p.image_url "
          + "FROM places p JOIN bookmarks b ON b.places_id = p.id "
          + "WHERE b.users_id = ? "
          + "ORDER BY b.created_at";

        try {
            conn = DBmanager.getInstance();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, usersId);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                PlacesDTO p = new PlacesDTO();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setCategory(rs.getString("category"));
                p.setRegion(rs.getString("region"));
                p.setLatitude(rs.getDouble("latitude"));
                p.setLongitude(rs.getDouble("longitude"));
                p.setRating(rs.getDouble("rating"));
                p.setImage_url(rs.getString("image_url"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBmanager.close(pstmt, conn, rs);
        }
        return list;
    }

    /** 찜 토글: 있으면 삭제(false 반환), 없으면 추가(true 반환) */
    public boolean toggleBookmark(int usersId, int placesId) {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DBmanager.getInstance();

            pstmt = conn.prepareStatement(
                "SELECT COUNT(*) FROM bookmarks WHERE users_id = ? AND places_id = ?");
            pstmt.setInt(1, usersId);
            pstmt.setInt(2, placesId);
            rs = pstmt.executeQuery();
            boolean exists = rs.next() && rs.getInt(1) > 0;
            rs.close();
            pstmt.close();
            rs = null;

            if (exists) {
                pstmt = conn.prepareStatement(
                    "DELETE FROM bookmarks WHERE users_id = ? AND places_id = ?");
                pstmt.setInt(1, usersId);
                pstmt.setInt(2, placesId);
                pstmt.executeUpdate();
                return false; // 찜 해제됨
            } else {
                pstmt = conn.prepareStatement(
                    "INSERT INTO bookmarks (id, users_id, places_id) "
                  + "VALUES (bookmarks_seq.NEXTVAL, ?, ?)");
                pstmt.setInt(1, usersId);
                pstmt.setInt(2, placesId);
                pstmt.executeUpdate();
                return true; // 찜 추가됨
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DBmanager.close(pstmt, conn);
        }
    }
}
