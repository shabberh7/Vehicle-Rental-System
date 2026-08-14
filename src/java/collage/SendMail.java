package collage;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class SendMail {

    public static boolean sendOtp(
            String receiverEmail,
            String userName,
            String otp) {

        String senderEmail = "shabberh54@gmail.com";

        String appPassword = "";

        Properties properties = new Properties();

        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(
                properties,
                new Authenticator() {

                    @Override
                    protected PasswordAuthentication
                    getPasswordAuthentication() {

                        return new PasswordAuthentication(
                                senderEmail,
                                appPassword
                        );
                    }
                }
        );

        try {

            MimeMessage message = new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(senderEmail)
            );

            message.addRecipient(
                    Message.RecipientType.TO,
                    new InternetAddress(receiverEmail)
            );

            message.setSubject(
                    "LuxeDrive Password Reset OTP"
            );

            String emailBody =
                    "Hello " + userName + ",\n\n"
                    + "Your password reset OTP is:\n\n"
                    + otp
                    + "\n\nThis OTP is valid for 5 minutes."
                    + "\n\nDo not share this OTP with anyone."
                    + "\n\nThank You,\nLuxeDrive Team";

            message.setText(emailBody);

            Transport.send(message);

            System.out.println(
                    "OTP email sent successfully to: "
                    + receiverEmail
            );

            return true;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}