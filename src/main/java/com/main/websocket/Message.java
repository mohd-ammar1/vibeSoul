package com.main.websocket;

import java.sql.Timestamp;

public class Message {
	private int msgId;
	private int senderId;
	private int receiverId;
	private String msgtxt;
	private Timestamp timeSent;

	public Message(int msgId, int senderId, int receiverId, String msgtxt, Timestamp timeSent) {
		super();
		this.msgId = msgId;
		this.senderId = senderId;
		this.receiverId = receiverId;
		this.msgtxt = msgtxt;
		this.timeSent = timeSent;
	}

	public int getMsgId() {
		return msgId;
	}

	public int getSenderId() {
		return senderId;
	}

	public int getReceiverId() {
		return receiverId;
	}

	public String getMsgtxt() {
		return msgtxt;
	}

	public Timestamp getTimeSent() {
		return timeSent;
	}

}
