package util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * 이메일 발송 유틸.
 *
 * [중요] 발송 계정/앱 비밀번호는 코드에 하드코딩하지 않고 환경변수로 주입한다.
 *   MAIL_USERNAME = 보내는 Gmail 주소
 *   MAIL_PASSWORD = Gmail 앱 비밀번호
 *   (선택) MAIL_HOST, MAIL_PORT
 *
 * Eclipse 톰캣: 서버 더블클릭 → Open launch configuration → Environment 탭에서 설정.
 * 환경변수가 없으면 메일을 보내지 않고 콘솔에 경고만 남긴다(앱은 죽지 않음).
 */
public class EmailUtil {

    private static final String SMTP_HOST = env("MAIL_HOST", "smtp.gmail.com");
    private static final String SMTP_PORT = env("MAIL_PORT", "587");
    private static final String FROM_EMAIL = env("MAIL_USERNAME", "");   // 발송 계정 (환경변수)
    private static final String APP_PASSWORD = env("MAIL_PASSWORD", ""); // 앱 비밀번호 (환경변수, 코드에 두지 않음)

    // 이메일 보내기
    public static void sendEmail(String toEmail, String subject, String content) {

        // 자격증명 미설정 시 발송 시도하지 않음
        if (FROM_EMAIL.isEmpty() || APP_PASSWORD.isEmpty()) {
            System.out.println("[EmailUtil] MAIL_USERNAME / MAIL_PASSWORD 환경변수가 설정되지 않아 메일을 보내지 않습니다.");
            return;
        }

        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Gmail 로그인 정보 (환경변수 값 사용)
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });
        try {
            Message message = new MimeMessage(session);

            // 보내는 사람
            message.setFrom(new InternetAddress(FROM_EMAIL));

            // 받는 사람
            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(toEmail)
            );

            // 제목
            message.setSubject(subject);

            // 내용
            message.setText(content);

            // 메일 발송
            Transport.send(message);

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
