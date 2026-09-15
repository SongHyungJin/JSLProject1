package model;

import java.time.LocalDateTime;

public class BookmarksDTO {
	private int id; //북마크 확인용 pk, 사용자의 여러데이터 중 어떤 데이터인지 구분용  
	//사용자 한명의 여러개의 데이터를 다룰 떄 편리 
    private int usersId; //저장된 데이터의 사용자 구분용 
    private int placesId; //저장된 장소 구분용 
    private LocalDateTime createdAt; //저장된 날짜 
    private String name; //사용자 닉네임 
    private String category; //장소 종류 구분 카테고리 
    private String region; //지역
    private double rating; //평점
    private String imageUrl; //사진 주소 
    
    
    
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
