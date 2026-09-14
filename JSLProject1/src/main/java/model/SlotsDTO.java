package model;

public class SlotsDTO {
	
	private int id;
	private int places_id; //장소 pk 아이디
	private String slot_time; //시간대
	private int capacity; //예약 가능 인원
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPlaces_id() {
		return places_id;
	}
	public void setPlaces_id(int places_id) {
		this.places_id = places_id;
	}
	public String getSlot_time() {
		return slot_time;
	}
	public void setSlot_time(String slot_time) {
		this.slot_time = slot_time;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	
	
	
}
