package model;

import java.time.LocalDateTime;

public class BookmarksDTO {
	private int id;
    private int usersId;
    private int placesId;
    private LocalDateTime createdAt;
    private String name;
    private String category;
    private String region;
    private double rating;
    private String imageUrl;
    
    
    
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public double getRating() {
		return rating;
	}
	public void setRating(double rating) {
		this.rating = rating;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
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
