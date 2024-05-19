package com.order;

import com.product.product;

public class order extends product {

	private String OID;
	private String uid;
	private String date;
	private String specific_time;
	private String status;
	private float total_amount;
	private String nameList;
	

	public order() {
	}

	public order(String OID, String uid, String date, String specific_time, String status, float total_amount , String nameList) {
		this.OID = OID;
		this.uid = uid;
		this.date = date;
		this.specific_time = specific_time;
		this.status = status;
		this.total_amount = total_amount;
		this.nameList = nameList;
	}

	public String getOID() {
		return OID;
	}

	public void setOID(String oID) {
		OID = oID;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getSpecific_time() {
		return specific_time;
	}

	public void setSpecific_time(String specific_time) {
		this.specific_time = specific_time;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public float getTotal_amount() {
		return total_amount;
	}

	public void setTotal_amount(float total_amount) {
		this.total_amount = total_amount;
	}
	
	public String getNameList() {
		return nameList;
	}

	public void setNameList(String nameList) {
		this.nameList = nameList;
	}
	
	
}
