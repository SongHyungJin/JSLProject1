package model;

/**
 * users 테이블 한 줄을 담는 DTO
 */
public class UserDTO {

    private long id;
    private String email;
    private String password;
    private String nickname;
    private String role;      // 'USER' 또는 'ADMIN'
    private String language;  // 기본값 'ko'

    public UserDTO() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    @Override
    public String toString() {
        return "UserDTO [id=" + id + ", email=" + email + ", nickname=" + nickname + ", role=" + role + "]";
    }
}