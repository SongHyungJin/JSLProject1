package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DBmanager;

public class ReservationsDAO {
	 // 예약 등록
	public int insert(ReservationsDTO dto) {

	    Connection conn = null;
	    PreparedStatement pstmt = null;

	    String sql = "INSERT INTO reservations ("
	               + "id, users_id, places_id, reservation_date, "
	               + "time_slot, headcount, request"
	               + ") VALUES ("
	               + "RESERVATIONS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?"
	               + ")";

	    int result = 0;

	    try {

	        conn = DBmanager.getInstance();

	        pstmt = conn.prepareStatement(sql);

	        pstmt.setInt(1, dto.getUsers_id());
	        pstmt.setInt(2, dto.getPlaces_id());

	        pstmt.setDate(
	            3,
	            java.sql.Date.valueOf(dto.getReservation_date())
	        );

	        pstmt.setString(4, dto.getTime_slot());
	        pstmt.setInt(5, dto.getHeadcount());
	        pstmt.setString(6, dto.getRequest());

	        result = pstmt.executeUpdate();

	    } catch (SQLException e) {

	        // 중복 예약
	        if (e.getErrorCode() == 1) {


	            result = -1;

	        } else {

	            e.printStackTrace();

	            result = 0;
	        }

	    } finally {

	        DBmanager.close(pstmt, conn);
	    }

	    return result;
	}


    // 예약 수정
    public int update(ReservationsDTO dto) {
    	
    	Connection conn = null;
		PreparedStatement pstmt = null;

        String sql = "UPDATE reservations SET "
                   + "reservation_date = ?, "
                   + "time_slot = ?, "
                   + "headcount = ?, "
                   + "request = ?, "
                   + "status = ?, "
                   + "updated_at = CURRENT_TIMESTAMP "
                   + "WHERE id = ?";

        int result = 0;

        try {
        	conn = DBmanager.getInstance();
        	pstmt = conn.prepareStatement(sql);
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
        }finally {
			DBmanager.close(pstmt, conn);
		}

        return result;
    }
    
    
    public List<ReservationsDTO> userBookingList(int usersId) {

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        List<ReservationsDTO> list = new ArrayList<>();

        String sql =
                "SELECT r.id, r.users_id, r.places_id, "
              + "r.reservation_date, r.time_slot, r.headcount, "
              + "r.request, r.status, r.created_at, r.updated_at, "
              + "p.name AS place_name, p.category "
              + "FROM reservations r "
              + "JOIN places p ON r.places_id = p.id "
              + "WHERE r.users_id = ? "
              + "ORDER BY r.reservation_date DESC, r.time_slot DESC";

        try {
            conn = DBmanager.getInstance();

            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, usersId);

            rs = pstmt.executeQuery();

            while (rs.next()) {

                ReservationsDTO dto = new ReservationsDTO();

                dto.setId(rs.getInt("id"));
                dto.setUsers_id(rs.getInt("users_id"));
                dto.setPlaces_id(rs.getInt("places_id"));

                if (rs.getDate("reservation_date") != null) {
                    dto.setReservation_date(
                        rs.getDate("reservation_date").toLocalDate()
                    );
                }

                dto.setTime_slot(rs.getString("time_slot"));
                dto.setHeadcount(rs.getInt("headcount"));
                dto.setRequest(rs.getString("request"));
                dto.setStatus(rs.getString("status"));

                if (rs.getTimestamp("created_at") != null) {
                    dto.setCreated_at(
                        rs.getTimestamp("created_at").toLocalDateTime()
                    );
                }

                if (rs.getTimestamp("updated_at") != null) {
                    dto.setUpdated_at(
                        rs.getTimestamp("updated_at").toLocalDateTime()
                    );
                }

                dto.setPlace_name(rs.getString("place_name"));

                list.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            DBmanager.close(pstmt, conn, rs);
        }

        return list;
    }
    
    
    
}
