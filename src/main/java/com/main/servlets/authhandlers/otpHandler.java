package com.main.servlets.authhandlers;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Random;

@WebServlet("/otphandler")
public class otpHandler extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		System.out.println("Veryfing otp");
		int otp = Integer.parseInt(request.getParameter("otp"));
		Object sotpObj = session.getAttribute("otp");
		Object timeObj = session.getAttribute("otpTime");
		if (sotpObj == null || timeObj == null) {
			response.getWriter().println("No OTP found. Please request again.");
			return;
		}
		int sotp = (Integer) sotpObj;
		long time = (Long) timeObj;
		long currenttime = System.currentTimeMillis();
		if ((currenttime - time) > 300000) {
			response.getWriter().write("OTP Expired Please request a new one");
			session.removeAttribute("otp");
			session.removeAttribute("otpTime");
		} else if (otp == sotp) {
			response.getWriter().write("OTP Verified Successfully");
			session.removeAttribute("otp");
			session.removeAttribute("otpTime");
		} else {
			response.getWriter().write("Invalid Otp");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		mailHandler ml = new mailHandler();
		Random rand = new Random();
		int otp = 100000 + rand.nextInt(900000);
		System.out.println("otp: " + otp);
		HttpSession session = request.getSession();
		session.setAttribute("otp", otp);
		session.setAttribute("otpTime", System.currentTimeMillis());
		String mail = request.getParameter("email");
		String subject = "Complete Your Sign-Up – OTP from vibeSoul";
		String msg = "Dear User,\n\n" + "Thank you for signing up with vibeSoul!\n\n"
				+ "Your One-Time Password (OTP) to complete your registration is:\n\n" + "👉 OTP: " + otp + "\n\n"
				+ "This code is valid for the next 10 minutes.\n"
				+ "Please do not share it with anyone for security reasons.\n\n"
				+ "If you did not request this sign-up, you can safely ignore this email.\n\n" + "Warm regards,\n"
				+ "Team vibeSoul";
		if (ml.mailSender(mail, subject, msg)) {
			System.out.println("MailHandler Called");
		}
	}
}
