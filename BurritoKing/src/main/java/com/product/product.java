package com.product;

import java.math.BigDecimal;

public class product {

	private int pid;
	private String name;
	private String category;
    private BigDecimal price;
	private String img;
	private String description;
	
	
	public product() {

	}


	public product(int pid, String name, String category, BigDecimal price, String img, String description) {
		this.pid = pid;
		this.name = name;
		this.category = category;
		this.price = price;
		this.img = img;
		this.description = description;
	}


	public int getPid() {
		return pid;
	}


	public void setPid(int pid) {
		this.pid = pid;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getCategory() {
		return category;
	}


	public void setCategory(String category) {
		this.category = category;
	}


	public BigDecimal getPrice() {
		return price;
	}


	public void setPrice(BigDecimal price) {
		this.price = price;
	}


	public String getImg() {
		return img;
	}


	public void setImg(String img) {
		this.img = img;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	
	
	
}
