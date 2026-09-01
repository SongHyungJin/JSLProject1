package model;

import java.time.LocalDateTime;

public class BookmarksDTO {
	private int id;
    private int usersId;
    private int placesId;
    private LocalDateTime createdAt;
    
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUsersId() {
		return usersId;
	}
	public void setUsersId(int usersId) {
		this.usersId = usersId;
	}
	public int getPlacesId() {
		return placesId;
	}
	public void setPlacesId(int placesId) {
		this.placesId = placesId;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
    
    
}
