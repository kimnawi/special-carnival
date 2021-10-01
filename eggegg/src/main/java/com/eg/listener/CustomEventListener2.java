package com.eg.listener;

import javax.inject.Inject;

import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class CustomEventListener2 {

	@Inject
	private SimpMessagingTemplate messagingTemplate;
	
	@EventListener(PushMsgCustomEvent.class)
	public void pushMsgEvent(PushMsgCustomEvent event) {
		String message = event.getMessage();
		messagingTemplate.convertAndSend("/topic/pushMsg", message);
	}
}
