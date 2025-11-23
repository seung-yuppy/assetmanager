package edu.example.assetmanager;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Component
public class NotificationSseManager {
	 private final Map<Long, SseEmitter> emitters = new ConcurrentHashMap<>();

	    public SseEmitter createEmitter(Long userId) {
        	if (emitters.containsKey(userId)) {
                return emitters.get(userId);
            }
        	
	        SseEmitter emitter = new SseEmitter(0L);
	        emitters.put(userId, emitter);

	        emitter.onCompletion(() -> emitters.remove(userId));
	        emitter.onTimeout(() -> emitters.remove(userId));
	        emitter.onError(e -> emitters.remove(userId));

	        return emitter;
	    }

	    public void send(Long userId, Object data) {
	        SseEmitter emitter = emitters.get(userId);
	        if (emitter != null) {
	            try {
	                emitter.send(data);
	            } catch (Exception e) {
	                emitters.remove(userId);
	            }
	        }
	    }
}
