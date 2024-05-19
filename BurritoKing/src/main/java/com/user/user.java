package com.user;

public class user {
	
	
	private String UID;
	private String firstName;
	private String lastName;
	private String status;
	private String email;
	private String password;
	private int rewards;
	
	
	public user() {
		
	}
	
	public user(String UID, String firstName, String lastName,String status, String email, String password, int rewards) {
		super();
		this.UID = UID;
		this.firstName = firstName;
		this.lastName = lastName;
		this.status=status;
		this.email = email;
		this.password = password;
		this.rewards = rewards;
	}
	
	public String getUID() {
		return UID;
	}
	
	
	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}
	
	public String getStatus() {
		return status;
	}

	public String getEmail() {
		return email;
	}

	public String getPassword() {
		return password;
	}

	public int getRewards() {
		return rewards;
	}
	
	
	
}
