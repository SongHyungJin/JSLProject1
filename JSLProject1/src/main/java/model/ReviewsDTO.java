package model;

import java.time.LocalDateTime;

public class ReviewsDTO {
	 	private int id;
	    private int usersId;
	    private int placesId;
	    private int rating;
	    private String content;
	    private int deleted;
	    private LocalDateTime createdAt;
	    private LocalDateTime updatedAt;
	    private String imageUrl;
	    private String nickname;

	    public String getNickname() {
	        return nickname;
	    }

	    public void setNickname(String nickname) {
	        this.nickname = nickname;
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
		public int getRating() {
			return rating;
		}
		public void setRating(int rating) {
			this.rating = rating;
		}
		public String getContent() {
			return content;
		}
		public void setContent(String content) {
			this.content = content;
		}
		public int getDeleted() {
			return deleted;
		}
		public void setDeleted(int deleted) {
			this.deleted = deleted;
		}
		public LocalDateTime getCreatedAt() {
			return createdAt;
		}
		public void setCreatedAt(LocalDateTime createdAt) {
			this.createdAt = createdAt;
		}
		public LocalDateTime getUpdatedAt() {
			return updatedAt;
		}
		public void setUpdatedAt(LocalDateTime updatedAt) {
			this.updatedAt = updatedAt;
		}
		public String getCreatedDate() {
		    if (createdAt == null) {
		        return "";
		    }

		    return createdAt.format(
		        java.time.format.DateTimeFormatter.ofPattern("yyyy.MM.dd")
		    );
		}
	    
	    
}
