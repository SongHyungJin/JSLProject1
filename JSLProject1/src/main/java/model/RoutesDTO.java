package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class RoutesDTO {

    private int id; //경로 pk 아이디
    private int users_id; // users 아이디
    private String title; // 경로 이름
    private String region; // 지역
    private LocalDate start_date; // 여행 시작 날짜
    private LocalDate end_date; // 여행 종료 날짜
    private LocalDateTime created_at; // 경로 생성 날짜

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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public LocalDate getStart_date() {
        return start_date;
    }

    public void setStart_date(LocalDate start_date) {
        this.start_date = start_date;
    }

    public LocalDate getEnd_date() {
        return end_date;
    }

    public void setEnd_date(LocalDate end_date) {
        this.end_date = end_date;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }
}