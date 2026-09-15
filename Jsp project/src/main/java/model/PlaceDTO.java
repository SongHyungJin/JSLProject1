package model;

/**
 * PLACES 테이블 한 행을 담는 DTO
 */
public class PlaceDTO {

    private long id;             // PK
    private String name;
    private String category;     // RESTAURANT, CAFE, SHOP, ATTRACTION
    private String region;
    private Double latitude;
    private Double longitude;
    private String description;
    private String businessHours;
    private String imageUrl;
    private int reservable;      // 0 또는 1
    private Double avgRating;

    public PlaceDTO() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

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

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBusinessHours() {
        return businessHours;
    }

    public void setBusinessHours(String businessHours) {
        this.businessHours = businessHours;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public int getReservable() {
        return reservable;
    }

    public void setReservable(int reservable) {
        this.reservable = reservable;
    }

    // JSP EL에서 예약가능 여부를 boolean처럼 쓰기 위한 편의 메서드 (${place.reservableYn})
    public boolean isReservableYn() {
        return reservable == 1;
    }

    public Double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(Double avgRating) {
        this.avgRating = avgRating;
    }

    @Override
    public String toString() {
        return "PlaceDTO [id=" + id + ", name=" + name + ", category=" + category
                + ", region=" + region + ", avgRating=" + avgRating + "]";
    }
}
