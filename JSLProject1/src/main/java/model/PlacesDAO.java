package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBmanager;

public class PlacesDAO {
	
	// 점포 등록
    public int PlacesInsert(PlacesDTO dto) {

        String sql = "INSERT INTO places ("
                + "id, name, category, region, latitude, longitude, "
                + "description, business_hours, image_url, reservable"
                + ") VALUES ("
                + "PLACES_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?"
                + ")";

        int result = 0;

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getName());
            pstmt.setString(2, dto.getCategory());
            pstmt.setString(3, dto.getRegion());
            pstmt.setDouble(4, dto.getLatitude());
            pstmt.setDouble(5, dto.getLongitude());
            pstmt.setString(6, dto.getDescription());
            pstmt.setString(7, dto.getBusiness_hours());
            pstmt.setString(8, dto.getImage_url());
            pstmt.setInt(9, dto.isReservable() ? 1 : 0);

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }


    // 점포 수정
    public int PlacesUpdate(PlacesDTO dto) {

        String sql = "UPDATE places SET "
                + "name = ?, "
                + "category = ?, "
                + "region = ?, "
                + "latitude = ?, "
                + "longitude = ?, "
                + "description = ?, "
                + "business_hours = ?, "
                + "image_url = ?, "
                + "reservable = ?, "
                + "rating = ?, "
                + "updated_at = CURRENT_TIMESTAMP "
                + "WHERE id = ?";

        int result = 0;

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getName());
            pstmt.setString(2, dto.getCategory());
            pstmt.setString(3, dto.getRegion());
            pstmt.setDouble(4, dto.getLatitude());
            pstmt.setDouble(5, dto.getLongitude());
            pstmt.setString(6, dto.getDescription());
            pstmt.setString(7, dto.getBusiness_hours());
            pstmt.setString(8, dto.getImage_url());
            pstmt.setInt(9, dto.isReservable()? 1 : 0);
            pstmt.setDouble(10, dto.getRating());
            pstmt.setInt(11, dto.getId());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }
    
    //점포 전체 조회 
    public List<PlacesDTO> PlacesSelectAll() {
    	
		List<PlacesDTO> placesList = new ArrayList<>();
		String sql = "SELECT (id,name,category,region,latitude,longitude,description,business_hours,"
				+ "image_url,reservable,rating,created_at,updated_at)"
				+ " FROM places";

		try (Connection conn = DBmanager.getInstance();
			 PreparedStatement pstmt = conn.prepareStatement(sql);
			 ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				PlacesDTO dto = new PlacesDTO();
				dto.setId(rs.getInt("id"));
				dto.setName(rs.getString("name"));
				dto.setCategory(rs.getString("category"));
				dto.setRegion(rs.getString("region"));
				dto.setLatitude(rs.getDouble("latitude"));
				dto.setLongitude(rs.getDouble("longitude"));
				dto.setDescription(rs.getString("description"));
				dto.setBusiness_hours(rs.getString("business_hours"));
				dto.setImage_url(rs.getString("image_url"));
				dto.setReservable(rs.getInt("reservable") == 1);
				dto.setRating(rs.getDouble("rating"));
				dto.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
				dto.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());

				placesList.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return placesList;
	}
}
