package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import util.DBmanager;

public class ReservationsDAO {
	 // 예약 등록
    public int insert(ReservationsDTO dto) {

        String sql = "INSERT INTO reservations ("
                   + "id, users_id, places_id, reservation_date, "
                   + "time_slot, headcount, request"
                   + ") VALUES ("
                   + "RESERVATIONS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?"
                   + ")";

        int result = 0;

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dto.getUsers_id());
            pstmt.setInt(2, dto.getPlaces_id());

            // LocalDate → Timestamp
            pstmt.setDate(
                3,
                java.sql.Date.valueOf(dto.getReservation_date())
            );

            pstmt.setString(4, dto.getTime_slot());
            pstmt.setInt(5, dto.getHeadcount());
            pstmt.setString(6, dto.getRequest());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }


    // 예약 수정
    public int update(ReservationsDTO dto) {

        String sql = "UPDATE reservations SET "
                   + "reservation_date = ?, "
                   + "time_slot = ?, "
                   + "headcount = ?, "
                   + "request = ?, "
                   + "status = ?, "
                   + "updated_at = CURRENT_TIMESTAMP "
                   + "WHERE id = ?";

        int result = 0;

        try (Connection conn = DBmanager.getInstance();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setDate(
                1,
                java.sql.Date.valueOf(dto.getReservation_date())
            );

            pstmt.setString(2, dto.getTime_slot());
            pstmt.setInt(3, dto.getHeadcount());
            pstmt.setString(4, dto.getRequest());
            pstmt.setString(5, dto.getStatus());
            pstmt.setInt(6, dto.getId());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }
    
    
    
}
