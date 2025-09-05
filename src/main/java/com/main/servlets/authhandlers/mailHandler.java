package com.main.servlets.authhandlers;

import java.util.Properties;

import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class mailHandler {

	public mailHandler() {
	}

	public boolean mailSender(String rmail, String rsubject, String rmessage) {
		String pass = "onzf tvqi ldet jbyt";
		String sendermail = "vibesoul007@gmail.com";
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(sendermail, pass);
			}
		});
		try {
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(sendermail, "VibeSoul Team"));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(rmail));
			msg.setSubject(rsubject);
			msg.setText(rmessage);

			Transport.send(msg);
			System.out.println("Mail Sended");
		} catch (Exception exp) {
			exp.printStackTrace();
		}

		return (true);
	}

}
