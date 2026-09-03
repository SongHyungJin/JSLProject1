package util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    // Gmail SMTP 서버 정보
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";

    // 보내는 사람 Gmail
    private static final String FROM_EMAIL = "구글계정만들어야함@gmail.com";

    // Gmail 앱 비밀번호
    private static final String APP_PASSWORD = "비밀번호";

    // 이메일 보내기
    public static void sendEmail(String toEmail, String subject, String content) {

        Properties props = new Properties();

        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Gmail 로그인 정보
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

            System.out.println("메일 발송 성공!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
