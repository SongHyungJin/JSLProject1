package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class ReservationsDTO {
	
	private int id;
	private int users_id;
	private int places_id;
	private LocalDate reservation_date;
	private String time_slot;
	private int headcount;
	private String request;
	private String status;
	private LocalDateTime created_at;
	private LocalDateTime updated_at;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUsers_id() {
		return users_id;
	}
	public void setUsers_id(int users_id) {
		this.users_id = users_id;
	}
	public int getPlaces_id() {
		return places_id;
	}
	public void setPlaces_id(int places_id) {
		this.places_id = places_id;
	}
	public LocalDate getReservation_date() {
		return reservation_date;
	}
	public void setReservation_date(LocalDate reservation_date) {
		this.reservation_date = reservation_date;
	}
	public String getTime_slot() {
		return time_slot;
	}
	public void setTime_slot(String time_slot) {
		this.time_slot = time_slot;
	}
	public int getHeadcount() {
		return headcount;
	}
	public void setHeadcount(int headcount) {
		this.headcount = headcount;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public LocalDateTime getCreated_at() {
		return created_at;
	}
	public void setCreated_at(LocalDateTime created_at) {
		this.created_at = created_at;
	}
	public LocalDateTime getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(LocalDateTime updated_at) {
		this.updated_at = updated_at;
	}
	
	
}
