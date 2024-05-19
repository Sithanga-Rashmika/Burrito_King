package com.cart;

import com.product.product;

public class cart extends product{

	private int quantity;
	

	public cart() {
		super();
	}
	
	
	public cart(int quantity) {
		super();
		this.quantity = quantity;
	}


	public int getQuantity() {
		return quantity;
	}


	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	
}
