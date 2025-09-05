package com.main.websocket;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.Collections;

import org.apache.commons.codec.binary.Hex;

public class Secret {
	private static int key;

	public Secret() {
		super();
	}

	private int key(String sender, String receiver) {
		String[] users = { sender, receiver };
		Arrays.sort(users, Collections.reverseOrder());
		String sUsers = String.join("|", users);
		String skey = System.getenv("MASTER_KEY");
		String finalstr = "||" + sUsers + "|" + skey + "||";
		String hex = Hex.encodeHexString(finalstr.getBytes()); // String to Hex
		key = new BigInteger(hex, 16).mod(BigInteger.valueOf(999999999)).intValue();
		return key;
	}

	protected String encrypt(String sender, String receiver, String message) {
		int secretkey = key(sender, receiver);
		StringBuilder encrypt = new StringBuilder();
		for (int i = 0; i < message.length(); i++) {
			char ch = (char) (message.charAt(i) + secretkey);
			encrypt.append(ch); // modifies same object
		}
		return encrypt.toString();

	}

	protected String decrypt(String sender, String receiver, String encrypted) {
		int secretkey = key(sender, receiver);
		StringBuilder decrypt = new StringBuilder();
		for (int i = 0; i < encrypted.length(); i++) {
			char ch = (char) (encrypted.charAt(i) - secretkey);
			decrypt.append(ch); // modifies same object
		}
		return decrypt.toString();
	}
}
