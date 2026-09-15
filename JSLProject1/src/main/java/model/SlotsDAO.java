package model;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBmanager;

public class SlotsDAO {
	//점포 시간대별 예약가능 인원수 입력 
	public int insertSlots(SlotsDTO dto){
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result =0;
		
		String sql ="insert into reservation_slots(id,places_id,slot_time,capacity) "
				+ "values (reservation_slots_seq.nextval,?,?,?)";
		
		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getPlaces_id());
			pstmt.setString(2, dto.getSlot_time());
			pstmt.setInt(3, dto.getCapacity());
			result = pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			
			DBmanager.close(pstmt, conn);
		}
		return result;
	}
	//점포 시간대별 예약가능 인원수 수정 
	public int updateNickname(int id, int capacity) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0; //닉네임 변경 성공여부 확인용
		String sql ="update users set capacity=? where id=?";
		
		try {
			conn = DBmanager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, capacity);
			pstmt.setInt(2, id);
			result = pstmt.executeUpdate(); //성공시 1
			
		}catch(Exception e) {
			e.printStackTrace();
			
		}finally {
			DBmanager.close(pstmt, conn);
		}
		return result; 
	}
	
	
}
