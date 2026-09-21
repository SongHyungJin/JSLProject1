package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * DB 연결 유틸.
 *
 * 접속 정보는 환경변수로 덮어쓸 수 있고, 없으면 로컬 개발용 기본값을 쓴다.
 *   DB_URL      (기본: jdbc:oracle:thin:@localhost:1521:xe)
 *   DB_USER     (기본: jsl28)
 *   DB_PASSWORD (기본: 1234)
 *   (선택) DB_DRIVER
 *
 * ※ 아래 기본값은 "로컬 개발용"이다. 공개 저장소/운영에서는 환경변수로 주입하고,
 *   민감한 실계정은 기본값에 두지 말 것.
 */
public class DBmanager {

	public static Connection getInstance() {

		Connection conn = null;
		String driver = env("DB_DRIVER", "oracle.jdbc.driver.OracleDriver");
		String url = env("DB_URL", "jdbc:oracle:thin:@localhost:1521:xe");
		String id  = env("DB_USER", "jsl28");
		String pw  = env("DB_PASSWORD", "1234");

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void close(PreparedStatement pstmt, Connection conn) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void close(PreparedStatement pstmt, Connection conn, ResultSet rs) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/** 환경변수 조회 (없으면 기본값) */
	private static String env(String key, String defaultValue) {
		String v = System.getenv(key);
		return (v != null && !v.isBlank()) ? v : defaultValue;
	}
}
