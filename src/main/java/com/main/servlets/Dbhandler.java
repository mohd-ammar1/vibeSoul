package com.main.servlets;

import jakarta.servlet.ServletContext;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class Dbhandler {
	private ServletContext context;
	private String dbUrl;
	private String dbUser = null;
	private String dbPass;

	public Dbhandler() {
		this.dbUrl = "jdbc:mysql://localhost:3306/vibeSoul_db";
		this.dbUser = "root";
		this.dbPass = "Lucifer";
	}

	public Connection concreater() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
			return con;
		} catch (Exception exp) {
			System.out.println("Error while getting connection: " + exp.getMessage());
			return null;
		}
	}

	public boolean insertData(String query, Object... params) {
		try (Connection con = concreater(); PreparedStatement ps = con.prepareStatement(query)) {
			for (int i = 0; i < params.length; i++) {
				ps.setObject(i + 1, params[i]);
			}
			int affectedRows = ps.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException exp) {
			System.out.println("Error during insert: " + exp.getMessage());
			return false;
		}
	}

	public ResultSet selectData(String query, Object... params) {
		try {
			Connection con = concreater();
			PreparedStatement ps = con.prepareStatement(query);
			for (int i = 0; i < params.length; i++) {
				ps.setObject(i + 1, params[i]);
			}
			return ps.executeQuery();
		} catch (SQLException exp) {
			System.out.println("Error during select: " + exp.getMessage());
			return null;
		}
	}

	public boolean updateData(String query, Object... params) {
		try (Connection con = concreater(); PreparedStatement ps = con.prepareStatement(query)) {
			for (int i = 0; i < params.length; i++) {
				ps.setObject(i + 1, params[i]);
			}
			int affectedRows = ps.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException exp) {
			System.out.println("Error during update: " + exp.getMessage());
			return false;
		}
	}

	public boolean deleteData(String query, Object... params) {
		try (Connection con = concreater(); PreparedStatement ps = con.prepareStatement(query)) {
			for (int i = 0; i < params.length; i++) {
				ps.setObject(i + 1, params[i]);
			}
			int affectedRows = ps.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException exp) {
			System.out.println("Error during delete: " + exp.getMessage());
			return false;
		}
	}
}
