package com.eg.listener;


public class PushMsgCustomEvent {
	
	String message;
	
	public PushMsgCustomEvent(Object source, String message) {
		this.message = message;
	}
	
	public String getMessage() {
		return message;
	}
}
