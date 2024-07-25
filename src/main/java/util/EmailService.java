package util;

import model.Customer;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailService implements IJavaMail {
    @Override
    public boolean send(String to, String subject, String messageContent) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", EmailProperty.HOST_NAME);
        props.put("mail.smtp.port", String.valueOf(EmailProperty.TSL_PORT));


        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EmailProperty.APP_EMAIL, EmailProperty.APP_PASSWORD);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(messageContent, "text/html; charset=utf-8");

            // Replace placeholder with reset password URL
            String resetPasswordURL = "https://www.yourwebsite.com/reset-password?token=" + generateResetToken();
            String customizedMessageContent = messageContent.replace("{resetLink}", resetPasswordURL);
            message.setContent(customizedMessageContent, "text/html; charset=utf-8");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    // Dummy token generation for example purpose
    private String generateResetToken() {
        Customer customer = new Customer();
        return customer.getToken(); // Replace this with actual token generation logic
    }
}